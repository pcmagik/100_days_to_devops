# Tydzień 10: Terraform & Proxmox

## Dzień 64: Wprowadzenie do Terraform 🌍

### Pierwsze kroki z Terraform
Dzień 64. "100 dni do DevOps" to wprowadzenie do Terraform, narzędzia od HashiCorp służącego do zarządzania infrastrukturą jako kod (IaC). Terraform umożliwia definicję, wdrożenie i aktualizację infrastruktury za pomocą języka konfiguracyjnego HCL (HashiCorp Configuration Language).

### Dlaczego Terraform?
- ```Deklaratywne podejście``` : Określasz stan docelowy infrastruktury, a Terraform zajmuje się jego realizacją.
- ```Idempotentność``` : Powtarzalne uruchomienia konfiguracji bez wpływu na stan końcowy, dopóki nie zaszły zmiany.
- ```Wsparcie dla wielu dostawców``` : Terraform współpracuje z licznymi dostawcami usług chmurowych oraz lokalnymi rozwiązaniami (on-premise).

### Kompletny przewodnik po Terraform:

#### 1. Instalacja Terraform
Pobierz Terraform ze strony [Terraform Downloads](https://www.terraform.io/downloads.html) i postępuj zgodnie z instrukcjami instalacji dla swojego systemu operacyjnego.

#### 2. Struktura projektu
- ```Main.tf``` : Główny plik konfiguracji Terraform.
- ```Variables.tf``` : Definiuje zmienne używane w konfiguracjach.
- ```Terraform.tfvars``` : Opcjonalny plik do przekazywania wartości zmiennym.
- ```Outputs.tf``` : Definiuje wartości, które mają być wyjściem po zastosowaniu konfiguracji.

#### 3. Tworzenie plików konfiguracyjnych
- ```Main.tf``` :
  ```hcl
  provider "aws" {
    region = var.region
  }

  resource "aws_instance" "example" {
    ami           = var.ami_id
    instance_type = "t2.micro"
  }
  ```

- ```Variables.tf``` :
  ```hcl
  variable "region" {
    description = "The region where AWS resources will be created"
    default     = "us-west-2"
  }

  variable "ami_id" {
    description = "The AMI to use for the server"
  }
  ```

- ```Terraform.tfvars``` :
  ```hcl
  ami_id = "ami-0c55b159cbfafe1f0"
  ```

- ```Outputs.tf``` :
  ```hcl
  output "instance_id" {
    value = aws_instance.example.id
  }
  ```

#### 4. Inicjalizacja i stosowanie konfiguracji
- ```Inicjalizacja``` :
  ```bash
  terraform init
  ```
  Przygotowuje Terraform do pracy z podanymi konfiguracjami.

- ```Planowanie``` :
  ```bash
  terraform plan
  ```
  Wyświetla, co zostanie utworzone, zmodyfikowane lub usunięte.

- ```Zastosowanie``` :
  ```bash
  terraform apply
  ```
  Stosuje zaplanowane zmiany.

### Podsumowanie
Terraform jest potężnym narzędziem do zarządzania infrastrukturą jako kod, pozwalającym na automatyzację i uproszczenie wdrażania infrastruktury. Zapewnia to nie tylko szybkość, ale także spójność w zarządzaniu zasobami.

### Co dalej?
Zachęcam do eksplorowania bardziej zaawansowanych funkcji Terraform, takich jak moduły, workspaces i zaawansowane techniki zarządzania stanem, które mogą jeszcze bardziej usprawnić i zautomatyzować procesy w Twoim środowisku IT.
