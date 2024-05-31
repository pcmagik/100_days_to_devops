# Tydzień 13: Ansible & Terraform

## Dzień 91: Podsumowanie tygodnia z Ansible & Terraform 🎉

### Refleksje nad tygodniem integracji
W dniu 91. "100 dni do DevOps" podsumowujemy nasz tydzień poświęcony połączeniu sił Ansible i Terraform, które razem tworzą potężny zestaw narzędzi do zarządzania infrastrukturą IT i automatyzacji.

### Kluczowe wnioski z tygodnia:
- **Integracja Ansible z Terraform**: Odkryliśmy, jak te narzędzia mogą współpracować, by zapewnić płynne przejście od tworzenia infrastruktury do jej konfiguracji i zarządzania.
  - Przykład użycia: Terraform tworzy instancje EC2, a Ansible konfiguruje serwery i wdraża aplikacje.
    &&&
    # Plik Terraform do tworzenia instancji EC2
    provider "aws" {
      region = "us-east-1"
    }

    resource "aws_instance" "example" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"
      tags = {
        Name = "example-instance"
      }
    }

    output "instance_ip" {
      value = aws_instance.example.public_ip
    }
    &&&
    &&&
    # Playbook Ansible do konfiguracji serwera
    ---
    - name: Konfiguracja serwera
      hosts: example-instance
      become: yes
      tasks:
        - name: Instalacja Nginx
          apt:
            name: nginx
            state: present

        - name: Uruchomienie Nginx
          service:
            name: nginx
            state: started
            enabled: yes
    &&&

- **Dynamiczne inventory**: Zrozumieliśmy wartość dynamicznego inventory w Ansible, zasilanego przez Terraform, dla automatyzacji i elastyczności.
  - Przykład dynamicznego inventory:
    &&&
    # inventory_aws_ec2.yml
    ---
    plugin: aws_ec2
    regions:
      - us-east-1
    keyed_groups:
      - key: tags.Name
        prefix: tag_
    &&&

- **Automatyzacja end-to-end**: Doświadczyliśmy, jak integracja Ansible i Terraform umożliwia kompleksową automatyzację zarówno infrastruktury, jak i konfiguracji.
  - Przykład automatyzacji workflow:
    1. Uruchomienie Terraform:
       &&&
       terraform init
       terraform apply -auto-approve
       &&&
    2. Generowanie dynamicznego inventory dla Ansible:
       &&&
       terraform output -json > inventory.json
       &&&
    3. Uruchomienie playbooka Ansible:
       &&&
       ansible-playbook -i inventory.json configure.yml
       &&&

- **Wieloplatformowość**: Zajęliśmy się wyzwaniami zarządzania infrastrukturą działającą na wielu platformach przy użyciu obu narzędzi.
  - Przykład pliku Terraform dla wielu platform:
    &&&
    provider "aws" {
      region = "us-east-1"
    }

    provider "azurerm" {
      features {}
    }

    provider "google" {
      project = "my-gcp-project"
      region  = "us-central1"
    }

    resource "aws_instance" "aws_app" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"
      tags = {
        Name = "aws-app-instance"
      }
    }

    resource "azurerm_virtual_machine" "azure_app" {
      name                  = "azure-app-vm"
      location              = "East US"
      resource_group_name   = azurerm_resource_group.example.name
      network_interface_ids = [azurerm_network_interface.example.id]
      vm_size               = "Standard_B1s"

      storage_os_disk {
        name              = "example-os-disk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
      }

      storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }

      os_profile {
        computer_name  = "hostname"
        admin_username = "adminuser"
        admin_password = "Password1234!"
      }
    }

    resource "google_compute_instance" "gcp_app" {
      name         = "gcp-app-instance"
      machine_type = "f1-micro"
      zone         = "us-central1-a"

      boot_disk {
        initialize_params {
          image = "debian-cloud/debian-9"
        }
      }

      network_interface {
        network = "default"
        access_config {}
      }
    }
    &&&
    &&&
    # Playbook Ansible dla konfiguracji na wielu platformach
    ---
    - name: Konfiguracja aplikacji w AWS
      hosts: aws-app-instance
      become: yes
      tasks:
        - name: Instalacja Nginx
          apt:
            name: nginx
            state: present

        - name: Uruchomienie Nginx
          service:
            name: nginx
            state: started
            enabled: yes

    - name: Konfiguracja aplikacji w Azure
      hosts: azure-app-vm
      become: yes
      tasks:
        - name: Instalacja Nginx
          apt:
            name: nginx
            state: present

        - name: Uruchomienie Nginx
          service:
            name: nginx
            state: started
            enabled: yes

    - name: Konfiguracja aplikacji w GCP
      hosts: gcp-app-instance
      become: yes
      tasks:
        - name: Instalacja Nginx
          apt:
            name: nginx
            state: present

        - name: Uruchomienie Nginx
          service:
            name: nginx
            state: started
            enabled: yes
    &&&

- **Bezpieczeństwo i compliance**: Podkreśliliśmy znaczenie Ansible i Terraform w wdrażaniu praktyk bezpieczeństwa i spełnianiu wymogów compliance.
  - Przykład playbooka Ansible do audytu zgodności:
    &&&
    ---
    - name: Audyt zgodności
      hosts: all
      become: yes
      tasks:
        - name: Sprawdzenie wersji SSH
          command: ssh -V
          register: ssh_version

        - name: Weryfikacja, czy SSH jest w wersji 7.4 lub wyższej
          assert:
            that:
              - "ssh_version.stdout.find('OpenSSH_7.4') != -1 or ssh_version.stdout.find('OpenSSH_8') != -1"

        - name: Sprawdzenie stanu UFW
          command: ufw status
          register: ufw_status

        - name: Weryfikacja, czy UFW jest włączony
          assert:
            that:
              - "ufw_status.stdout.find('Status: active') != -1"
    &&&

### Podsumowanie
Ten tydzień pokazał, że połączenie Ansible i Terraform może znacząco przyspieszyć i usprawnić procesy DevOps, zapewniając zarówno efektywność operacyjną, jak i wysoki poziom bezpieczeństwa i zgodności. Dzięki integracji tych narzędzi zespoły mogą osiągnąć lepszą kontrolę nad infrastrukturą, poprawić elastyczność oraz skrócić czas wdrożeń.

### Co dalej?
Zachęcamy do dalszej eksploracji możliwości integracji Ansible i Terraform oraz do eksperymentowania z różnymi scenariuszami użycia tych narzędzi w swojej codziennej pracy. Podziel się swoimi przemyśleniami na temat integracji Ansible i Terraform. Jakie są twoje kluczowe wnioski z tego tygodnia?

Podziel się swoimi doświadczeniami z tego tygodnia. Jakie wyzwania udało Ci się pokonać dzięki integracji Ansible i Terraform? Jakie najlepsze praktyki wprowadziłeś w swoich projektach? Czekamy na Wasze komentarze i sugestie.
