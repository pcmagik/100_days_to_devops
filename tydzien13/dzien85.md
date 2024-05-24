# Tydzień 13: Ansible & Terraform

## Dzień 85: Integracja Ansible z Terraform 🤝

### Łączenie sił Ansible i Terraform
W dniu 85. "100 dni do DevOps" rozpoczynamy tydzień poświęcony synergii między Ansible i Terraform, dwoma potężnymi narzędziami do automatyzacji IT i zarządzania infrastrukturą jako kod. Integracja tych narzędzi pozwala na efektywne zarządzanie całym cyklem życia infrastruktury – od jej tworzenia po konfigurację i utrzymanie.

### Dlaczego integracja Ansible z Terraform?
- **Orkiestracja i konfiguracja**: Terraform skutecznie zarządza tworzeniem infrastruktury, podczas gdy Ansible doskonale nadaje się do jej konfiguracji i zarządzania stanem zasobów.
- **Automatyzacja end-to-end**: Integracja umożliwia płynne przechodzenie od tworzenia infrastruktury do jej konfiguracji i zarządzania, eliminując manualne przerwy.
- **Elastyczność**: Wykorzystanie obu narzędzi razem daje większą kontrolę nad zarządzaniem infrastrukturą w różnych środowiskach i u różnych dostawców chmury.

### Implementacja integracji:
1. **Wykorzystanie danych z Terraform w Ansible**:
   - Przekazywanie danych o infrastrukturze stworzonej przez Terraform do Ansible, np. poprzez dynamiczne inventory.
   - Przykład konfigurowania Terraform, aby generować dynamiczne inventory dla Ansible:
     ```
     output "instance_ips" {
       value = aws_instance.example.*.public_ip
     }
     ```
   - Przykład użycia dynamicznego inventory w Ansible:
     ```
     ---
     plugin: aws_ec2
     regions:
       - us-east-1
     keyed_groups:
       - key: tags.Name
         prefix: tag_name_
     hostnames:
       - tag:Name
     ```

2. **Automatyzacja workflow**:
   - Orkiestracja procesów, w których najpierw Terraform tworzy infrastrukturę, a następnie Ansible przejmuje konfigurację i zarządzanie.
   - Przykład workflow integrującego Terraform i Ansible:
     - Plik Terraform tworzący infrastrukturę:
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
     - Playbook Ansible konfigurujący stworzony serwer:
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

### Przykładowy proces integracji:
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
Integracja Ansible z Terraform otwiera nowe możliwości dla automatyzacji i zarządzania infrastrukturą, sprawiając, że procesy są bardziej spójne i efektywne. Dzięki tej integracji można zautomatyzować cały cykl życia infrastruktury – od jej tworzenia, przez konfigurację, aż po zarządzanie i monitorowanie.

### Co dalej?
W nadchodzących dniach będziemy badać bardziej zaawansowane scenariusze integracji Ansible z Terraform, w tym zarządzanie złożonymi środowiskami, automatyzację zadań operacyjnych oraz integrację z narzędziami CI/CD. Zachęcamy do eksperymentowania z integracją Ansible i Terraform, aby w pełni wykorzystać ich potencjał w codziennej pracy.

Podziel się swoimi doświadczeniami z integracją Ansible i Terraform! Jakie wyzwania napotkaliście i jakie rozwiązania okazały się skuteczne? Czekamy na Wasze komentarze i sugestie.
