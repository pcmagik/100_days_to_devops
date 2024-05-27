# Tydzień 13: Ansible & Terraform

## Dzień 88: Zarządzanie wieloplatformową infrastrukturą z Ansible i Terraform 🌍

### Opanowanie wieloplatformowości
W dniu 88. "100 dni do DevOps" skupiamy się na wykorzystaniu Ansible i Terraform do zarządzania złożoną infrastrukturą działającą na wielu platformach i u różnych dostawców chmurowych.

### Dlaczego zarządzanie wieloplatformowe jest ważne?
- **Elastyczność**: Dostosowanie się do różnych środowisk i technologii zwiększa odporność oraz optymalizację kosztów.
- **Zgodność**: Zapewnia, że wszystkie platformy są zarządzane zgodnie z jednolitymi standardami i praktykami.
- **Skalowalność**: Umożliwia rozszerzanie infrastruktury w miarę rozwoju projektów i potrzeb biznesowych.

### Implementacja z Ansible i Terraform:
1. **Terraform dla wielu dostawców**:
   - Używanie Terraform do definiowania infrastruktury na różnych platformach (np. AWS, Azure, GCP) z jednolitego miejsca.
   - Przykład pliku Terraform do tworzenia infrastruktury na AWS, Azure i GCP:
     ```
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

     resource "aws_instance" "aws_example" {
       ami           = "ami-0c55b159cbfafe1f0"
       instance_type = "t2.micro"
       tags = {
         Name = "aws-example-instance"
       }
     }

     resource "azurerm_virtual_machine" "azure_example" {
       name                  = "azure-example-vm"
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

     resource "google_compute_instance" "gcp_example" {
       name         = "gcp-example-instance"
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
     ```

2. **Ansible dla konfiguracji**:
   - Stosowanie Ansible do konsekwentnego konfigurowania i zarządzania zasobami na tych platformach, wykorzystując dynamiczne inventory dla różnych środowisk.
   - Przykład dynamicznego inventory dla AWS, Azure i GCP:
     ```
     ---
     plugin: aws_ec2
     regions:
       - us-east-1
     keyed_groups:
       - key: tags.Name
         prefix: aws_

     ---
     plugin: azure_rm
     include_vm_resource_groups:
       - example-resource-group
     keyed_groups:
       - key: tags.Name
         prefix: azure_

     ---
     plugin: gcp_compute
     projects:
       - my-gcp-project
     keyed_groups:
       - key: labels.Name
         prefix: gcp_
     ```

3. **Modularność i ponowne wykorzystanie**:
   - Tworzenie modułów w Terraform i ról w Ansible, które mogą być łatwo dostosowywane i ponownie wykorzystywane na różnych platformach.
   - Przykład roli Ansible do instalacji i konfiguracji Nginx:
     ```
     # roles/nginx/tasks/main.yml
     ---
     - name: Instalacja Nginx
       apt:
         name: nginx
         state: present
       when: ansible_os_family == "Debian"

     - name: Instalacja Nginx
       yum:
         name: nginx
         state: present
       when: ansible_os_family == "RedHat"

     - name: Uruchomienie Nginx
       service:
         name: nginx
         state: started
         enabled: yes
     ```

### Podsumowanie
Integracja Ansible i Terraform oferuje solidne rozwiązanie do zarządzania wieloplatformową infrastrukturą, maksymalizując jej potencjał przy jednoczesnym zachowaniu kontroli i spójności. Dzięki tej synergii, zespoły mogą efektywnie zarządzać złożonymi środowiskami i dostosowywać się do dynamicznie zmieniających się potrzeb biznesowych.

### Co dalej?
W kolejnych dniach będziemy kontynuować eksplorację zaawansowanych scenariuszy zarządzania infrastrukturą z Ansible i Terraform, w tym integrację z systemami CI/CD oraz zarządzanie złożonymi środowiskami. Zachęcamy do eksperymentowania z zarządzaniem wieloplatformowym, aby w pełni wykorzystać potencjał tych narzędzi w codziennej pracy.

Podziel się swoimi doświadczeniami z zarządzaniem wieloplatformową infrastrukturą z Ansible i Terraform! Jakie wyzwania napotkaliście i jakie rozwiązania okazały się skuteczne? Czekamy na Wasze komentarze i sugestie.
