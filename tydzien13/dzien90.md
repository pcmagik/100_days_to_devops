# Tydzień 13: Ansible & Terraform

## Dzień 90: Bezpieczeństwo i compliance z Ansible i Terraform 🔐

### Podnoszenie standardów bezpieczeństwa
W dniu 90. "100 dni do DevOps" skupiamy się na wykorzystaniu Ansible i Terraform do zapewnienia wyższych standardów bezpieczeństwa i zgodności (compliance) w zarządzaniu infrastrukturą IT.

### Dlaczego bezpieczeństwo i compliance są kluczowe?
- **Ochrona danych**: Zapewnienie, że infrastruktura i dane są chronione przed nieautoryzowanym dostępem i innymi zagrożeniami.
- **Zgodność z regulacjami**: Przestrzeganie wymogów prawnych i branżowych dotyczących bezpieczeństwa danych i infrastruktury.
- **Zaufanie**: Budowanie zaufania użytkowników i klientów poprzez demonstrację solidnych praktyk bezpieczeństwa.

### Wdrażanie z Ansible i Terraform:
1. **Bezpieczna konfiguracja**:
   - Używanie Ansible do stosowania konfiguracji bezpieczeństwa, np. hardening serwerów, zarządzanie zaporami ogniowymi, i aktualizacje bezpieczeństwa.
   - Przykład playbooka Ansible do hardeningu serwera:
     ```
     ---
     - name: Hardening serwera
       hosts: all
       become: yes
       tasks:
         - name: Aktualizacja wszystkich pakietów
           apt:
             upgrade: dist
             update_cache: yes
             cache_valid_time: 3600

         - name: Instalacja ufw
           apt:
             name: ufw
             state: present

         - name: Konfiguracja reguł UFW
           ufw:
             rule: allow
             port: '22'
             proto: tcp

         - name: Włączanie UFW
           ufw:
             state: enabled
     ```

2. **Infrastruktura jako kod z Terraform**:
   - Definiowanie infrastruktury w sposób zgodny z najlepszymi praktykami bezpieczeństwa, np. minimalne uprawnienia, segregacja sieci, szyfrowanie danych w spoczynku i w transmisji.
   - Przykład pliku Terraform definiującego zasoby zgodnie z zasadami bezpieczeństwa:
     ```
     provider "aws" {
       region = "us-east-1"
     }

     resource "aws_vpc" "main" {
       cidr_block = "10.0.0.0/16"

       tags = {
         Name = "main-vpc"
       }
     }

     resource "aws_subnet" "public" {
       vpc_id     = aws_vpc.main.id
       cidr_block = "10.0.1.0/24"
       map_public_ip_on_launch = true

       tags = {
         Name = "public-subnet"
       }
     }

     resource "aws_security_group" "allow_ssh" {
       vpc_id = aws_vpc.main.id

       ingress {
         from_port   = 22
         to_port     = 22
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
       }

       egress {
         from_port   = 0
         to_port     = 0
         protocol    = "-1"
         cidr_blocks = ["0.0.0.0/0"]
       }

       tags = {
         Name = "allow_ssh"
       }
     }

     resource "aws_instance" "secure_instance" {
       ami           = "ami-0c55b159cbfafe1f0"
       instance_type = "t2.micro"
       subnet_id     = aws_subnet.public.id
       security_groups = [aws_security_group.allow_ssh.name]

       tags = {
         Name = "secure-instance"
       }
     }
     ```

3. **Automatyzacja compliance**:
   - Stosowanie playbooków Ansible do regularnego sprawdzania i utrzymania zgodności z politykami bezpieczeństwa i compliance.
   - Przykład playbooka Ansible do audytu zgodności:
     ```
     ---
     - name: Audyt zgodności
       hosts: all
       become: yes
       tasks:
         - name: Sprawdzenie wersji SSH
           command: ssh -V
           register: ssh_version

         - name: Weryfikacja, czy SSH jest w wersji 7.4 lub wyższej
           assert:
             that:
               - "ssh_version.stdout.find('OpenSSH_7.4') != -1 or ssh_version.stdout.find('OpenSSH_8') != -1"

         - name: Sprawdzenie stanu UFW
           command: ufw status
           register: ufw_status

         - name: Weryfikacja, czy UFW jest włączony
           assert:
             that:
               - "ufw_status.stdout.find('Status: active') != -1"
     ```

### Podsumowanie
Integracja Ansible i Terraform w strategie bezpieczeństwa i zgodności znacząco wzmacnia ochronę i efektywność zarządzania infrastrukturą IT, jednocześnie ułatwiając przestrzeganie wymogów regulacyjnych. Dzięki tym narzędziom można skutecznie zabezpieczać zasoby i dane, minimalizując ryzyko i budując zaufanie użytkowników.

### Co dalej?
W kolejnych dniach będziemy kontynuować eksplorację zaawansowanych scenariuszy zarządzania infrastrukturą z Ansible i Terraform, w tym integrację z systemami CI/CD oraz zarządzanie złożonymi środowiskami. Zachęcamy do dalszego eksperymentowania z tymi narzędziami, aby w pełni wykorzystać ich potencjał w codziennej pracy.

Podziel się swoimi doświadczeniami z wykorzystaniem Ansible i Terraform do zapewnienia bezpieczeństwa i zgodności! Jakie wyzwania napotkaliście i jakie rozwiązania okazały się skuteczne? Czekamy na Wasze komentarze i sugestie.
