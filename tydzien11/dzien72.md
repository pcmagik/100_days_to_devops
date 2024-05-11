# Tydzień 11: Terraform & Cloud

## Dzień 72: Zarządzanie zasobami AWS z Terraform 🌐

### Terraform jako klucz do AWS
W dniu 72. "100 dni do DevOps" zagłębiamy się w możliwości, jakie Terraform oferuje w zarządzaniu zasobami Amazon Web Services (AWS), największego dostawcy usług chmurowych na świecie.

### Dlaczego Terraform w AWS?
- **Zintegrowane zarządzanie**: Terraform umożliwia kompleksowe zarządzanie różnorodnymi zasobami AWS, od instancji EC2 i baz danych RDS, po sieci VPC i wiele więcej.
- **Automatyzacja i skalowalność**: Terraform pozwala na szybkie wdrażanie, skalowanie infrastruktury w AWS oraz automatyzację zadań zarządzania bez potrzeby manualnych interwencji.
- **Kontrola i bezpieczeństwo**: Dzięki Terraform możliwa jest precyzyjna kontrola konfiguracji zasobów, zapewniając bezpieczeństwo i zgodność z najlepszymi praktykami.

### Przystąpienie do zarządzania AWS z Terraform:
1. **Konfiguracja dostawcy AWS**:
   - Zainicjuj dostawcę AWS w Terraform, używając kluczy dostępu API do autoryzacji.
     ```hcl
     provider "aws" {
       region     = "us-west-2"
       access_key = "your-access-key"
       secret_key = "your-secret-key"
     }
     ```
2. **Definiowanie zasobów AWS**:
   - Określ zasoby AWS w plikach konfiguracyjnych Terraform, tworząc moduły dla każdego typu zasobu, takich jak instancje EC2, grupy bezpieczeństwa, sieci VPC.
     ```hcl
     resource "aws_instance" "example" {
       ami           = "ami-0c55b159cbfafe1f0"
       instance_type = "t2.micro"
       tags = {
         Name = "ExampleInstance"
       }
     }
     ```
3. **Wykorzystanie modułów Terraform dla AWS**:
   - Implementuj moduły Terraform dostosowane do zarządzania zasobami AWS, co ułatwia organizację i reużywalność konfiguracji.
     ```hcl
     module "vpc" {
       source = "terraform-aws-modules/vpc/aws"
       version = "2.77.0"
       name = "my-vpc"
       cidr = "10.0.0.0/16"
       azs  = ["us-west-2a", "us-west-2b", "us-west-2c"]
       private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
       public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
       enable_nat_gateway = true
       enable_vpn_gateway = true
     }
     ```

### Podsumowanie
Wykorzystanie Terraform do zarządzania zasobami AWS otwiera przed zespołami DevOps nowe możliwości dla efektywnego i bezpiecznego zarządzania infrastrukturą chmurową. Integracja ta pozwala na automatyzację procesów, zapewniając jednocześnie wysoki poziom kontroli i bezpieczeństwa.

### Co dalej?
Zachęcamy do eksperymentowania z Terraform w środowisku AWS, adaptując narzędzie do swoich potrzeb i odkrywając nowe możliwości w zarządzaniu infrastrukturą chmurową. Jakie wyzwania napotkaliście podczas pracy z Terraform i AWS? Jakie rozwiązania znaleźliście? Podzielcie się swoimi doświadczeniami!
