# Tydzień 10: Terraform & Proxmox

## Dzień 67: Moduły i dostawcy w Terraform 🧩

### Modularność i elastyczność z Terraform
W dniu 67. "100 dni do DevOps" eksplorujemy moduły i dostawców w Terraform. Te funkcje umożliwiają organizację i ponowne wykorzystanie kodu infrastruktury, ułatwiając wdrażanie w różnych środowiskach i na różnych platformach.

### Dlaczego moduły i dostawcy są ważne?
- **Ponowne wykorzystanie kodu**: Moduły pozwalają grupować zasoby Terraform, które można łatwo ponownie wykorzystać w różnych projektach, co zwiększa efektywność i spójność w zarządzaniu infrastrukturą.
- **Abstrakcja**: Dostawcy (providers) w Terraform umożliwiają abstrakcyjne zarządzanie zasobami poprzez różne platformy i usługi, zapewniając jednolity interfejs do wszystkich typów infrastruktury.
- **Organizacja**: Lepsza organizacja kodu Terraform przekłada się na większą czytelność i łatwość zarządzania, dzięki czemu projekty są bardziej zrozumiałe i łatwiejsze w utrzymaniu.

### Praca z modułami i dostawcami:
1. **Tworzenie modułów Terraform**:
   - Moduły są definiowane poprzez grupowanie zasobów i konfiguracji, które mają wspólne cechy. Na przykład, moduł dla serwera VPC w AWS mógłby zawierać konfiguracje dla sieci VPC, subnety, i security groups.
     ```hcl
     module "vpc" {
       source = "./modules/vpc"
       region = "us-west-1"
       cidr_block = "10.0.0.0/16"
     }
     ```

2. **Wykorzystanie dostawców Terraform**:
   - Dostawcy tak jak AWS, Google Cloud, Azure, czy Proxmox są konfigurowani na początku projektu, aby umożliwić Terraformowi zarządzanie zasobami na tych platformach.
     ```hcl
     provider "aws" {
       region = var.region
     }
     ```

3. **Zarządzanie zależnościami między modułami**:
   - Terraform umożliwia zarządzanie zależnościami między modułami, co pozwala na automatyczne rozwiązywanie kolejności tworzenia i niszczenia zasobów.
   - Parametryzacja modułów pozwala na łatwą konfigurację i dostosowanie modułów do specyficznych potrzeb danego wdrożenia.

### Podsumowanie
Wykorzystanie modułów i dostawców w Terraform to klucz do zwiększenia elastyczności i efektywności zarządzania infrastrukturą jako kodem. Dzięki temu można tworzyć bardziej złożone i skalowalne architektury, jednocześnie zachowując porządek i łatwość w zarządzaniu projektami. Wprowadza to nowy poziom modularności i optymalizacji w procesach DevOps.

### Co dalej?
Zachęcam do eksplorowania i tworzenia własnych modułów oraz integracji z różnymi dostawcami w Terraform, aby maksymalnie wykorzystać potencjał tego narzędzia w zarządzaniu nowoczesną infrastrukturą IT.
