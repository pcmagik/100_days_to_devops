#!/bin/bash

# Check if libguestfs-tools is installed
if ! dpkg -l | grep -q libguestfs-tools; then
    echo "libguestfs-tools is not installed. Installing..."
    apt-get update
    apt-get install -y libguestfs-tools
fi

if ! dpkg -l | grep -q unzip; then
    echo "unzip is not installed. Installing..."
    apt-get update
    apt-get install -y unzip
fi
# Detect templates and destroy them
for i in 9000 9001 9002 9010 9011 9012;
do
  if qm status $i > /dev/null 2>&1; then
    echo "Destroying existing VM with ID $i"
    qm stop $i
    qm destroy $i
  fi
done


# Funkcja pomocnicza do pobierania obrazu, jeśli nie istnieje
function download_image() {
    local url=$1
    local file_name=$(basename "${url}")
    if [[ ! -f ${file_name} ]]; then
        wget "${url}"
    else
        echo "Image ${file_name} already exists. Skipping download."
    fi
    echo "${file_name}"
}

#Create template
#args:
# vm_id
# vm_name
# file name in the current directory
function create_template() {
    local vm_id=$1
    local vm_name=$2
    local file_name=$3

    #Print all of the configuration
    echo "Creating template ${vm_name} (${vm_id})"

    # Modify image using virt-customize and install necessary packages
    echo "Modifying image $3 with virt-customize"
    virt-customize -a "$3" --install qemu-guest-agent


    # Add commands to make each cloned machine unique
    virt-customize -a "$3" \
        --run-command 'truncate -s 0 /etc/machine-id' \
        --run-command 'cloud-init clean' \
        --run-command 'rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg' \
        --run-command 'sync'


    #Create new VM 
    #Feel free to change any of these to your liking
    qm create $1 --name $2 --ostype l26 
    #Set networking to default bridge
    qm set $1 --net0 virtio,bridge=vmbr0
    #Set display to serial
    qm set $1 --serial0 socket --vga serial0
    #Set memory, cpu, type defaults
    #If you are in a cluster, you might need to change cpu type
    qm set $1 --memory 1024 --cores 4 --cpu host
    #Set boot device to new file
    qm set $1 --scsi0 ${storage}:0,import-from="$(pwd)/$3",discard=on
    #Set scsi hardware as default boot disk using virtio scsi single
    qm set $1 --boot order=scsi0 --scsihw virtio-scsi-single
    #Enable Qemu guest agent in case the guest has it available
    qm set $1 --agent enabled=1,fstrim_cloned_disks=1
    #Add cloud-init device
    qm set $1 --ide2 ${storage}:cloudinit
    #Set CI ip config
    #IP6 = auto means SLAAC (a reliable default with no bad effects on non-IPv6 networks)
    #IP = DHCP means what it says, so leave that out entirely on non-IPv4 networks to avoid DHCP delays
    qm set $1 --ipconfig0 "ip6=auto,ip=dhcp"
    #Import the ssh keyfile
    qm set $1 --sshkeys ${ssh_keyfile}
    #If you want to do password-based auth instaed
    #Then use this option and comment out the line above
    qm set $1 --cipassword password
    #Add the user
    qm set $1 --ciuser ${username}
    #Resize the disk to 8G, a reasonable minimum. You can expand it more later.
    #If the disk is already bigger than 8G, this will fail, and that is okay.
    qm disk resize $1 scsi0 8G
    #Make it a template
    qm template $1
    #Remove file when done
     rm $3
}

#Path to your ssh authorized_keys file
#Alternatively, use /etc/pve/priv/authorized_keys if you are already authorized
#on the Proxmox system
export ssh_keyfile=/root/id_rsa.pub
#Username to create on VM template
export username=yourname

#Name of your storage
export storage=local-zfs

#The images that I've found premade
#Feel free to add your own

## Debian
#Buster (10)
download_image "https://cloud.debian.org/images/cloud/buster/latest/debian-10-genericcloud-amd64.qcow2"
create_template 9000 "template-debian-10" "debian-10-genericcloud-amd64.qcow2"
#Bullseye (11)
download_image "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-genericcloud-amd64.qcow2"
create_template 9001 "template-debian-11" "debian-11-genericcloud-amd64.qcow2" 
#Bookworm (12)
download_image "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
create_template 9002 "template-debian-12" "debian-12-genericcloud-amd64.qcow2" 


## Ubuntu
# 18.04 LTS (Bionic Beaver)
download_image "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img"
create_template 9010 "template-ubuntu-18-04" "ubuntu-18.04-server-cloudimg-amd64.img" 
# 20.04 LTS (Focal Fossa)
download_image "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
create_template 9011 "template-ubuntu-20-04" "ubuntu-20.04-server-cloudimg-amd64.img" 
# 22.04 LTS (Jammy Jellyfish)
download_image "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
create_template 9012 "template-ubuntu-22-04" "ubuntu-22.04-server-cloudimg-amd64.img"



