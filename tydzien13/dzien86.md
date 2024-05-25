# Tydzień 13: Ansible & Terraform

## Dzień 86: Dynamiczne inventory w Ansible z Terraform 🔄

### Wykorzystanie dynamicznego inventory
W dniu 86. "100 dni do DevOps" zgłębiamy, jak dynamiczne inventory w Ansible może być zasilane danymi z Terraform, co znacząco usprawnia procesy automatyzacji i zarządzania infrastrukturą.

### Dlaczego dynamiczne inventory jest ważne?
- **Automatyzacja**: Automatyczne odświeżanie danych inventory w Ansible na podstawie aktualnego stanu infrastruktury zarządzanej przez Terraform.
- **Elastyczność**: Umożliwia Ansible łatwe dostosowanie się do zmieniającej się infrastruktury, np. podczas skalowania.
- **Spójność**: Zapewnia, że Ansible zawsze pracuje z aktualnym obrazem infrastruktury, co zwiększa dokładność konfiguracji i deploymentu.

### Implementacja dynamicznego inventory:
1. **Wykorzystanie Terraform state**:
   - Pobieranie danych o infrastrukturze z pliku stanu Terraform i przekazywanie ich do Ansible jako dynamiczne inventory.
   - Przykład konfigurowania Terraform, aby generować dynamiczne inventory dla Ansible:
     ```
     output "instance_ips" {
       value = aws_instance.example.*.public_ip
     }
     ```
   - Eksportowanie danych do formatu JSON:
     ```
     terraform output -json > inventory.json
     ```

2. **Użycie wtyczek**:
   - Ansible oferuje wtyczki do dynamicznego inventory, które mogą bezpośrednio korzystać z danych generowanych przez Terraform.
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

### Praktyczne zastosowanie:
1. **Konfiguracja**:
   - Automatyczne konfigurowanie nowo stworzonych instancji VM w chmurze, które zostały utworzone przez Terraform.
   - Przykład playbooka do konfiguracji serwera:
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

2. **Deployment**:
   - Użycie Ansible do deploymentu aplikacji na infrastrukturze utworzonej przez Terraform z uwzględnieniem aktualnych konfiguracji i zależności.
   - Przykład playbooka do deploymentu aplikacji:
     ```
     ---
     - name: Deployment aplikacji
       hosts: tag_name_example-instance
       become: yes
       tasks:
         - name: Skopiowanie plików aplikacji
           copy:
             src: /local/path/to/app/
             dest: /remote/path/to/app/
             owner: appuser
             group: appgroup
             mode: '0755'

         - name: Instalacja zależności
           apt:
             name: "{{ item }}"
             state: present
           with_items:
             - libapache2-mod-wsgi
             - python3-pip

         - name: Uruchomienie usługi aplikacji
           service:
             name: myapp
             state: started
             enabled: yes
     ```

### Podsumowanie
Dynamiczne inventory w Ansible, zasilane danymi z Terraform, znacząco podnosi poziom automatyzacji i efektywności zarządzania infrastrukturą. Dzięki temu, Ansible może łatwo dostosować się do zmieniającej się infrastruktury, zapewniając spójność i dokładność konfiguracji oraz deploymentu aplikacji.

### Co dalej?
W nadchodzących dniach będziemy badać bardziej zaawansowane scenariusze integracji Ansible z Terraform, w tym zarządzanie złożonymi środowiskami oraz integrację z narzędziami CI/CD. Zachęcamy do eksperymentowania z dynamicznym inventory, aby w pełni wykorzystać potencjał Ansible i Terraform w codziennej pracy.

Podziel się swoimi doświadczeniami z dynamicznym inventory w Ansible! Jakie wyzwania napotkaliście i jakie rozwiązania okazały się skuteczne? Czekamy na Wasze komentarze i sugestie.
