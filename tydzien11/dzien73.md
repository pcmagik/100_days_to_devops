# Tydzień 11: Terraform & Cloud

## Dzień 73: Zarządzanie zasobami Azure z Terraform ☁️

### Terraform w ekosystemie Azure
W dniu 73. "100 dni do DevOps" eksplorujemy, jak Terraform może być wykorzystywany do zarządzania zasobami w Microsoft Azure, co umożliwia efektywne wdrażanie i zarządzanie infrastrukturą w chmurze Azure.

### Dlaczego Terraform dla Azure?
- **Spójne zarządzanie**: Terraform oferuje spójne podejście do zarządzania różnorodnymi zasobami Azure, umożliwiając łatwe wdrażanie złożonych architektur.
- **Automatyzacja i skalowalność**: Terraform umożliwia szybkie i skalowalne wdrażanie zasobów Azure, automatyzując konfigurację i zarządzanie.
- **Kontrola wersji i współpraca**: Kod infrastruktury umożliwia śledzenie zmian i efektywną współpracę w zespołach.

### Przystępowanie do zarządzania Azure z Terraform:
1. **Konfiguracja dostawcy Azure**:
   - Użyj Terraform do konfiguracji dostawcy Azure, uwierzytelniając się za pomocą Azure CLI lub Service Principal.
     ```hcl
     provider "azurerm" {
       features {}
       client_id       = var.client_id
       client_secret   = var.client_secret
       tenant_id       = var.tenant_id
       subscription_id = var.subscription_id
     }
     ```
2. **Definiowanie zasobów Azure**:
   - Zdefiniuj zasoby Azure, takie jak maszyny wirtualne, sieci VPC, grupy zasobów, używając plików konfiguracyjnych Terraform.
     ```hcl
     resource "azurerm_virtual_machine" "myvm" {
       name                  = "myVM"
       location              = "East US"
       resource_group_name   = azurerm_resource_group.myrg.name
       network_interface_ids = [azurerm_network_interface.my_nic.id]
       vm_size               = "Standard_DS1_v2"
     }
     ```
3. **Wykorzystanie modułów Terraform dla Azure**:
   - Użyj modułów Terraform dostępnych dla Azure, aby usprawnić zarządzanie infrastrukturą i zwiększyć reużywalność kodu.

### Podsumowanie
Zarządzanie zasobami Azure za pomocą Terraform zapewnia organizacjom większą skalowalność, elastyczność i kontrolę nad infrastrukturą chmurową. Umożliwia to przyspieszenie wdrażania i innowacji, co jest kluczowe w dynamicznie zmieniającym się środowisku technologicznym.

### Co dalej?
Zachęcamy do dalszego eksplorowania i wykorzystywania Terraform w środowisku Azure, aby maksymalizować korzyści płynące z automatyzacji i integracji infrastruktury chmurowej. Jakie doświadczenia mieliście z Terraform i Azure? Jakie wyzwania napotkaliście i jakie strategie okazały się skuteczne?
