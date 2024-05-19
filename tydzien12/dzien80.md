# Tydzień 12: Ansible & Automations

## Dzień 80: Zarządzanie konfiguracją i stanem z Ansible 🛠️

### Udoskonalenie zarządzania konfiguracją
W dniu 80. "100 dni do DevOps" skupiamy się na wykorzystaniu Ansible do zarządzania konfiguracją i stanem w infrastrukturze IT. Zapewnienie spójności, bezpieczeństwa i efektywności operacyjnej jest kluczowe dla każdej organizacji, a Ansible dostarcza narzędzi, które to umożliwiają.

### Dlaczego zarządzanie konfiguracją jest ważne?
- **Spójność**: Utrzymuje jednolitą konfigurację w całej infrastrukturze, minimalizując ryzyko błędów i problemów związanych z niezgodnościami.
- **Automatyzacja**: Pozwala na automatyczne stosowanie konfiguracji, co oszczędza czas i zasoby, redukując ręczne interwencje.
- **Łatwe przywracanie**: W przypadku awarii lub błędów, Ansible umożliwia szybkie przywrócenie pożądanej konfiguracji, zwiększając dostępność systemów.

### Implementacja z Ansible:
1. **Definiowanie konfiguracji**:
   - Używanie playbooków do definiowania pożądanych stanów dla różnych grup hostów.
   - Przykład playbooka definiującego konfigurację serwera webowego:
     ```yaml
     ---
     - name: Konfiguracja serwera webowego
       hosts: webservers
       become: yes
       tasks:
         - name: Instalacja Nginx
           apt:
             name: nginx
             state: present

         - name: Uruchomienie i włączenie Nginx
           service:
             name: nginx
             state: started
             enabled: yes

         - name: Konfiguracja pliku Nginx
           template:
             src: nginx.conf.j2
             dest: /etc/nginx/nginx.conf
             notify:
               - Restart nginx

       handlers:
         - name: Restart nginx
           service:
             name: nginx
             state: restarted
     ```

2. **Zarządzanie stanem**:
   - Ansible, dzięki swojej idempotentności, gwarantuje, że każde uruchomienie playbooka doprowadzi do tego samego stanu, niezależnie od początkowej konfiguracji systemu.
   - Przykład zadania zapewniającego zgodność pliku konfiguracyjnego:
     ```yaml
     - name: Zapewnienie zgodności pliku konfiguracyjnego
       file:
         path: /etc/myconfig.conf
         state: file
         owner: root
         group: root
         mode: '0644'
     ```

3. **Monitoring i audyt**:
   - Regularne uruchamianie playbooków do weryfikacji stanu i konfiguracji, umożliwiając szybkie wykrywanie i naprawianie odchyleń.
   - Używanie zadań ad-hoc do monitorowania konfiguracji:
     ```bash
     ansible webservers -m shell -a "cat /etc/nginx/nginx.conf" -i inventory
     ```

### Podsumowanie
Ansible to potężne narzędzie do zarządzania konfiguracją i stanem infrastruktury IT. Dzięki swojej prostocie, idempotentności i możliwości automatyzacji, Ansible przyczynia się do większej stabilności, bezpieczeństwa i przewidywalności w zarządzaniu infrastrukturą.

### Co dalej?
W kolejnych dniach będziemy eksplorować zaawansowane funkcje Ansible, takie jak integracja z systemami CI/CD, automatyzacja skomplikowanych scenariuszy wdrażania oraz monitorowanie i audytowanie konfiguracji na dużą skalę. Zachęcamy do dalszego eksperymentowania z Ansible, aby w pełni wykorzystać jego potencjał w codziennej pracy z infrastrukturą.

Podziel się swoimi doświadczeniami i strategiami zarządzania konfiguracją z Ansible! Jakie wyzwania napotkaliście i jakie rozwiązania okazały się skuteczne? Czekamy na Wasze komentarze i sugestie.
