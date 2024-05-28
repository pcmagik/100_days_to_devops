# Tydzień 13: Ansible & Terraform

## Dzień 89: Przypadki użycia i najlepsze praktyki dla Ansible i Terraform 📋

### Eksploracja praktycznych zastosowań
W dniu 89. "100 dni do DevOps" przyglądamy się konkretnym przypadkom użycia oraz najlepszym praktykom związanym z wykorzystaniem Ansible i Terraform w codziennej pracy zespołów DevOps.

### Przypadki użycia:
- **Automatyczne wdrożenia**:
  - Używanie Terraform do tworzenia infrastruktury i Ansible do deploymentu aplikacji w sposób zautomatyzowany i powtarzalny.
  - Przykład: Terraform tworzy instancje EC2 w AWS, a Ansible konfiguruje serwery i wdraża aplikacje.
    ```
    # Plik Terraform tworzący infrastrukturę
    provider "aws" {
      region = "us-east-1"
    }

    resource "aws_instance" "app" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"
      tags = {
        Name = "app-instance"
      }
    }

    output "instance_ip" {
      value = aws_instance.app.public_ip
    }
    ```
    ```
    # Playbook Ansible wdrażający aplikację
    ---
    - name: Deployment aplikacji
      hosts: app-instance
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

        - name: Skopiowanie plików aplikacji
          copy:
            src: /local/path/to/app/
            dest: /var/www/html/
            owner: www-data
            group: www-data
            mode: '0755'
    ```

- **Disaster recovery**:
  - Konfigurowanie środowisk DR z Terraform i zapewnienie szybkiej rekonfiguracji zasobów z Ansible w przypadku awarii.
  - Przykład: Terraform definiuje zasoby DR, a Ansible konfiguruje usługi w nowym środowisku po przełączeniu.
    ```
    # Plik Terraform tworzący infrastrukturę DR
    provider "aws" {
      region = "us-west-2"
    }

    resource "aws_instance" "dr_app" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"
      tags = {
        Name = "dr-app-instance"
      }
    }

    output "dr_instance_ip" {
      value = aws_instance.dr_app.public_ip
    }
    ```
    ```
    # Playbook Ansible rekonfigurujący usługi w DR
    ---
    - name: Konfiguracja DR
      hosts: dr-app-instance
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

        - name: Skopiowanie plików aplikacji z backupu
          copy:
            src: /backup/path/to/app/
            dest: /var/www/html/
            owner: www-data
            group: www-data
            mode: '0755'
    ```

- **Multi-cloud management**:
  - Zarządzanie zasobami rozproszonymi po wielu chmurach za pomocą Terraform, z jednolitą konfiguracją poprzez Ansible.
  - Przykład: Terraform tworzy zasoby w AWS, Azure i GCP, a Ansible konfiguruje usługi na wszystkich tych platformach.
    ```
    # Plik Terraform tworzący infrastrukturę w wielu chmurach
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
    ```
    ```
    # Playbook Ansible konfigurujący zasoby w wielu chmurach
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
    ```

### Najlepsze praktyki:
- **Kod jako dokumentacja**:
  - Utrzymywanie kodu Terraform i playbooków Ansible w sposób, który służy jako aktualna dokumentacja infrastruktury i konfiguracji.
- **Testowanie i walidacja**:
  - Regularne testowanie kodu Terraform i Ansible, w tym testy jednostkowe, integracyjne i akceptacyjne, aby zapewnić niezawodność.
- **Bezpieczeństwo**:
  - Szyfrowanie wrażliwych danych za pomocą Ansible Vault i stosowanie bezpiecznych modułów Terraform do zarządzania dostępem i uprawnieniami.

### Podsumowanie
Zrozumienie i implementacja najlepszych praktyk oraz konkretnych przypadków użycia dla Ansible i Terraform może znacząco podnieść jakość i efektywność zarządzania infrastrukturą i automatyzacji. Dzięki tym narzędziom zespoły DevOps mogą osiągnąć wyższy poziom spójności, elastyczności i bezpieczeństwa w swoich operacjach.

### Co dalej?
W kolejnych dniach będziemy kontynuować eksplorację zaawansowanych scenariuszy zarządzania infrastrukturą z Ansible i Terraform, w tym integrację z systemami CI/CD oraz zarządzanie złożonymi środowiskami. Zachęcamy do dalszego eksperymentowania z tymi narzędziami, aby w pełni wykorzystać ich potencjał w codziennej pracy.

Podziel się swoimi doświadczeniami z wykorzystaniem Ansible i Terraform! Jakie wyzwania napotkaliście i jakie rozwiązania okazały się skuteczne? Czekamy na Wasze komentarze i sugestie.
