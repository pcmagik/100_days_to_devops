# Tydzień 11: Terraform & Cloud

## Dzień 74: Zarządzanie zasobami Google Cloud z Terraform ☁️

### Optymalizacja Google Cloud z Terraform
W dniu 74. "100 dni do DevOps" eksplorujemy, jak Terraform może usprawnić zarządzanie zasobami w Google Cloud Platform (GCP), umożliwiając efektywne wdrażanie i zarządzanie infrastrukturą chmurową Google.

### Dlaczego Terraform dla GCP?
- **Uniwersalne zarządzanie**: Terraform oferuje spójny i zautomatyzowany sposób zarządzania różnorodnymi zasobami GCP, od maszyn wirtualnych i sieci, po usługi bazodanowe i kontenery.
- **Automatyzacja procesów**: Automatyzuje proces tworzenia, konfiguracji i zarządzania zasobami GCP, co przyspiesza wdrożenia i minimalizuje ryzyko błędów manualnych.
- **Kontrola i audyt**: Terraform integruje się z systemami kontroli wersji, umożliwiając dokładne śledzenie zmian i audyt konfiguracji, co jest kluczowe dla bezpieczeństwa i zgodności.

### Implementacja zarządzania GCP z Terraform:
1. **Konfiguracja dostawcy GCP**:
   - Użyj Terraform do konfiguracji dostawcy GCP, uwierzytelniając się za pomocą konta serwisowego Google.
     ```hcl
     provider "google" {
       credentials = file("account.json")
       project     = "my-gcp-project"
       region      = "us-central1"
     }
     ```
2. **Definiowanie i zarządzanie zasobami GCP**:
   - Zdefiniuj i zarządzaj kluczowymi zasobami GCP takimi jak Compute Engine, Cloud Storage, i Virtual Private Cloud (VPC), używając plików konfiguracyjnych Terraform.
     ```hcl
     resource "google_compute_instance" "vm_instance" {
       name         = "terraform-instance"
       machine_type = "e2-medium"
       zone         = "us-central1-a"

       boot_disk {
         initialize_params {
           image = "debian-cloud/debian-9"
         }
       }

       network_interface {
         network = "default"
         access_config {
           // Ephemeral IP
         }
       }
     }
     ```
3. **Wykorzystanie modułów Terraform dla GCP**:
   - Implementuj moduły Terraform dostosowane do GCP, aby ułatwić reużywalność konfiguracji i standaryzację zarządzania infrastrukturą.
     ```hcl
     module "vpc" {
       source  = "terraform-google-modules/network/google"
       version = "~> 2.0"

       project_id   = "my-gcp-project"
       network_name = "my-vpc"
       routing_mode = "GLOBAL"
       mtu          = 1460

       subnets = [
         {
           subnet_name   = "subnet-01"
           subnet_ip     = "10.10.10.0/24"
           subnet_region = "us-central1"
         },
       ]
     }
     ```

### Podsumowanie
Zarządzanie zasobami Google Cloud za pomocą Terraform otwiera przed organizacjami nowe możliwości dla usprawnienia wdrożeń i zapewnienia spójności w całym cyklu życia infrastruktury chmurowej. Dzięki temu można znacząco zwiększyć efektywność operacyjną i reagować na zmieniające się wymagania biznesowe z większą elastycznością.

### Co dalej?
Zachęcamy do eksplorowania możliwości, jakie oferuje Terraform w środowisku Google Cloud, i adaptacji tego narzędzia do swoich potrzeb operacyjnych. Jakie doświadczenia mieliście z Terraform i GCP? Jakie wyzwania napotkaliście i jakie rozwiązania znaleźliście?
