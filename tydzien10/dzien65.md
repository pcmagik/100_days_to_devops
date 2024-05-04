# Tydzień 10: Terraform & Proxmox

## Dzień 65: Zarządzanie infrastrukturą jako kodem z Terraform 📜

### Znaczenie Infrastruktury jako Kod (IaC)
Dzień 65. "100 dni do DevOps" koncentruje się na wykorzystaniu Terraform, narzędzia od HashiCorp, do zarządzania infrastrukturą jako kodem (IaC). Praktyka ta jest kluczowym elementem metodologii DevOps, umożliwiającym szybkie, spójne i skalowalne wdrażanie zasobów IT.

### Dlaczego IaC z Terraform?
- **Automatyzacja**: Terraform automatyzuje proces tworzenia, modyfikacji i zarządzania infrastrukturą, minimalizując ryzyko błędów ludzkich i przyspieszając wdrożenia.
- **Powtarzalność**: Dzięki deklaratywnej naturze kodu Terraform, środowiska można łatwo replikować, zapewniając konsystencję w różnych środowiskach produkcyjnych i testowych.
- **Śledzenie zmian**: Używanie Terraform w połączeniu z systemami kontroli wersji, jak Git, ułatwia zarządzanie historią zmian, przeglądanie zmian i współpracę w zespołach.

### Implementacja IaC z Terraform:
1. **Definiowanie zasobów infrastruktury**:
   - Zasoby są definiowane w plikach konfiguracyjnych Terraform, zwykle zapisywane jako `.tf`. Na przykład, konfiguracja serwera AWS EC2 może wyglądać tak:
     ```hcl
     resource "aws_instance" "my_instance" {
       ami           = "ami-0c55b159cbfafe1f0"
       instance_type = "t2.micro"
     }
     ```

2. **Planowanie zmian**:
   - Użyj polecenia `terraform plan` do przeglądu i weryfikacji zmian przed ich zastosowaniem. To polecenie wygeneruje plan działań, które Terraform podejmie, aby osiągnąć żądany stan infrastruktury określony w konfiguracji.
     ```bash
     terraform plan
     ```

3. **Stosowanie zmian**:
   - Zastosuj zmiany za pomocą polecenia `terraform apply`. Terraform automatycznie stworzy zasoby opisane w plikach `.tf`.
     ```bash
     terraform apply
     ```

4. **Zarządzanie cyklem życia zasobów**:
   - Terraform umożliwia nie tylko tworzenie, ale również aktualizację, skalowanie i niszczenie zasobów. Aby usunąć zasoby, użyj:
     ```bash
     terraform destroy
     ```

### Podsumowanie
Wykorzystanie Terraform do zarządzania infrastrukturą jako kodem (IaC) przyspiesza procesy DevOps, zwiększając przy tym spójność i niezawodność infrastruktury. Terraform umożliwia efektywne wdrażanie, skalowanie i zarządzanie infrastrukturą w sposób zautomatyzowany i kontrolowany, co jest kluczowe dla nowoczesnych strategii zarządzania infrastrukturą.

### Co dalej?
Zachęcam do dalszego eksplorowania zaawansowanych funkcji Terraform, takich jak moduły, stan back-end i zaawansowane techniki zarządzania zależnościami, które mogą jeszcze bardziej usprawnić procesy zarządzania infrastrukturą w Twojej organizacji.
