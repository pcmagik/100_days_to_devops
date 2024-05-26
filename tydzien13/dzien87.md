# Tydzień 13: Ansible & Terraform

## Dzień 87: Automatyzacja infrastruktury i konfiguracji z Ansible i Terraform 🌐

### Pełna automatyzacja z Ansible i Terraform
W dniu 87. "100 dni do DevOps" koncentrujemy się na pełnej automatyzacji procesów zarządzania infrastrukturą i jej konfiguracją, wykorzystując w tandemie Terraform i Ansible.

### Dlaczego pełna automatyzacja jest ważna?
- **Szybkość i efektywność**: Automatyzacja całego cyklu życia infrastruktury, od tworzenia przez konfigurację po zarządzanie, przyspiesza wdrożenia i operacje.
- **Spójność i zgodność**: Gwarantuje, że infrastruktura jest konsekwentnie wdrażana i zarządzana zgodnie z zasadami i wymaganiami.
- **Skalowalność**: Ułatwia zarządzanie infrastrukturą na dużą skalę, dostosowując się do potrzeb biznesowych.

### Implementacja z Ansible i Terraform:
1. **Orkiestracja z Terraform**:
   - Terraform służy do deklaratywnego definiowania i tworzenia infrastruktury w chmurze lub na miejscu.
   - Przykład pliku Terraform do tworzenia infrastruktury:
     ```
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
     ```

2. **Konfiguracja z Ansible**:
   - Po utworzeniu infrastruktury, Ansible przejmuje rolę w konfigurowaniu i zarządzaniu stanem zasobów, opierając się na danych dostarczonych przez Terraform.
   - Przykład playbooka Ansible do konfiguracji serwera:
     ```
     ---
     - name: Konfiguracja serwera
       hosts: tag_name_example-instance
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

3. **Automatyzacja workflow**:
   - Łączenie Terraform i Ansible w jednolity proces workflow, gdzie Terraform tworzy infrastrukturę, a Ansible od razu aplikuje konfiguracje.
   - Przykładowy proces integracji:
     1. Uruchomienie Terraform:
        ```
        terraform init
        terraform apply -auto-approve
        ```
     2. Generowanie dynamicznego inventory dla Ansible:
        ```
        terraform output -json > inventory.json
        ```
     3. Uruchomienie playbooka Ansible:
        ```
        ansible-playbook -i inventory.json configure.yml
        ```

### Podsumowanie
Zastosowanie Terraform do automatyzacji infrastruktury w połączeniu z Ansible do zarządzania konfiguracją pozwala na stworzenie wydajnego i elastycznego środowiska DevOps. Dzięki tej synergii, zespoły mogą efektywnie zarządzać całym cyklem życia infrastruktury, od jej tworzenia, przez konfigurację, aż po zarządzanie i monitorowanie.

### Co dalej?
W kolejnych dniach będziemy badać bardziej zaawansowane scenariusze automatyzacji z Ansible i Terraform, w tym integrację z systemami CI/CD oraz zarządzanie złożonymi środowiskami. Zachęcamy do eksperymentowania z pełną automatyzacją, aby w pełni wykorzystać potencjał tych narzędzi w codziennej pracy.

Podziel się swoimi doświadczeniami z pełną automatyzacją z Ansible i Terraform! Jakie wyzwania napotkaliście i jakie rozwiązania okazały się skuteczne? Czekamy na Wasze komentarze i sugestie.
