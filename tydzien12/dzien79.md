# Tydzień 12: Ansible & Automations

## Dzień 79: Podstawy playbooków i roli w Ansible 📖

### Zanurzamy się w playbooki i role
W dniu 79. "100 dni do DevOps" zagłębiamy się w playbooki i role w Ansible, które są fundamentem do definiowania i zarządzania automatyzacją na dużą skalę.

### Dlaczego playbooki i role są ważne?
- **Organizacja**: Playbooki i role umożliwiają strukturalne i modularne podejście do zarządzania konfiguracjami i zadaniami automatyzacyjnymi, co ułatwia utrzymanie i skalowanie.
- **Ponowne wykorzystanie**: Role mogą być łatwo ponownie wykorzystywane w różnych projektach i playbookach, co zwiększa efektywność i spójność konfiguracji.
- **Czytelność**: Playbooki zapisane w formacie YAML są łatwe do zrozumienia i edycji nawet dla osób nie będących programistami, co sprzyja współpracy w zespole.

### Budowanie playbooków i roli:
1. **Playbooki**:
   - Playbooki definiują zbiór zadań do wykonania na określonych hostach, używając specyficznej konfiguracji z pliku inventory.
   - Przykład prostego playbooka instalującego Nginx:
     ```yaml
     ---
     - name: Instalacja i konfiguracja Nginx
       hosts: webservers
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

2. **Role**:
   - Role grupują zadania, zmienne, pliki i inne elementy w logiczne jednostki, które można łatwo zarządzać i ponownie wykorzystywać.
   - Przykład struktury katalogu roli 'nginx':
     ```
     roles/
     └── nginx
         ├── tasks
         │   └── main.yml
         ├── handlers
         │   └── main.yml
         ├── templates
         │   └── nginx.conf.j2
         └── vars
             └── main.yml
     ```
   - Zawartość `tasks/main.yml` dla roli 'nginx':
     ```yaml
     ---
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

### Praktyczne wykorzystanie:
1. **Tworzenie playbooka do konfiguracji serwera webowego**:
   - Zdefiniuj playbooka, który używa roli 'nginx' do instalacji i konfiguracji serwera Nginx.
     ```yaml
     ---
     - name: Konfiguracja serwera webowego
       hosts: webservers
       become: yes
       roles:
         - nginx
     ```

2. **Użycie roli 'user' do zarządzania użytkownikami**:
   - Stwórz rolę 'user' do zarządzania użytkownikami i ich uprawnieniami na różnych hostach.
   - Przykład `tasks/main.yml` dla roli 'user':
     ```yaml
     ---
     - name: Tworzenie użytkownika
       user:
         name: "{{ username }}"
         state: present
         groups: "sudo"

     - name: Ustawienie hasła użytkownika
       user:
         name: "{{ username }}"
         password: "{{ password | password_hash('sha512') }}"
     ```

### Podsumowanie
Playbooki i role w Ansible to kluczowe elementy, które pozwalają na efektywne zarządzanie konfiguracjami i automatyzację zadań w infrastrukturze IT. Dzięki nim można w łatwy sposób tworzyć skalowalne, modularne i powtarzalne rozwiązania, które ułatwiają utrzymanie i rozwój infrastruktury.

### Co dalej?
W kolejnych dniach będziemy zagłębiać się w bardziej zaawansowane funkcje Ansible, takie jak zarządzanie dynamicznymi inwentaryzacjami, integracja z systemami CI/CD oraz automatyzacja bardziej złożonych scenariuszy wdrażania aplikacji. Zachęcamy do eksperymentowania z playbookami i rolami, aby lepiej zrozumieć ich potencjał i jak mogą pomóc w codziennej pracy z infrastrukturą.

Podziel się swoimi doświadczeniami i przykładami użycia playbooków i roli w Ansible! Jakie wyzwania napotkaliście i jakie sukcesy odnieśliście? Czekamy na Wasze komentarze i sugestie.
