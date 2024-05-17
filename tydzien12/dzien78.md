# Tydzień 12: Ansible & Automations

## Dzień 78: Wprowadzenie do Ansible 🚀

### Pierwsze kroki z Ansible
W dniu 78. "100 dni do DevOps" rozpoczynamy naszą przygodę z Ansible, narzędziem do automatyzacji IT, które umożliwia zarządzanie konfiguracją, wdrażanie aplikacji i orkiestrację zadań. Ansible jest popularnym narzędziem wśród inżynierów DevOps ze względu na swoją prostotę i efektywność.

### Dlaczego Ansible?
- **Prostota**: Ansible wykorzystuje język YAML do definiowania zadań automatyzacyjnych, co sprawia, że jest łatwy w nauce i czytelny. Jego składnia jest intuicyjna, co ułatwia tworzenie i zarządzanie playbookami.
- **Agentless**: Ansible nie wymaga instalacji agentów na zarządzanych serwerach, co upraszcza konfigurację i zarządzanie. Komunikacja odbywa się za pomocą SSH, co redukuje dodatkowe obciążenie i komplikacje.
- **Idempotentność**: Ansible zapewnia, że playbooki mogą być uruchamiane wielokrotnie, a system osiągnie ten sam pożądany stan bez niepożądanych efektów ubocznych. To kluczowa cecha dla stabilności i powtarzalności procesów automatyzacji.

### Pierwsze kroki z Ansible:
1. **Instalacja Ansible na stacji kontrolnej**:
   - Ansible można łatwo zainstalować na systemach Linux, macOS, a nawet Windows (za pomocą WSL).
     ```bash
     sudo apt update
     sudo apt install ansible
     ```
2. **Konfiguracja pliku inventory**:
   - Inventory to plik, który definiuje hosty i grupy hostów, którymi zarządza Ansible.
     - Przykład prostego pliku `inventory`:
       ```ini
       [webservers]
       web1.example.com
       web2.example.com

       [dbservers]
       db1.example.com
       db2.example.com
       ```
3. **Uruchomienie pierwszych ad-hoc poleceń Ansible**:
   - Ad-hoc polecenia umożliwiają szybkie wykonywanie zadań bez konieczności tworzenia playbooków.
     - Sprawdzenie dostępności hostów:
       ```bash
       ansible all -m ping -i inventory
       ```
     - Wykonanie komendy na grupie hostów:
       ```bash
       ansible webservers -m shell -a "uptime" -i inventory
       ```

### Podsumowanie
Ansible stanowi potężne narzędzie do zarządzania infrastrukturą i automatyzacji zadań, wprowadzając efektywność i skalowalność do procesów DevOps. Dzięki swojej prostocie, agentless architecture oraz idempotentności, Ansible jest idealnym rozwiązaniem dla zespołów IT dążących do automatyzacji i optymalizacji swoich operacji.

### Co dalej?
W następnych dniach będziemy zgłębiać bardziej zaawansowane funkcje Ansible, takie jak playbooki, role i integracja z innymi narzędziami DevOps. Zachęcamy do eksperymentowania z Ansible, aby lepiej zrozumieć jego możliwości i jak może pomóc w codziennej pracy z infrastrukturą.

Podziel się swoimi doświadczeniami i pierwszymi krokami z Ansible! Jakie wyzwania napotkaliście i jakie sukcesy odnieśliście? Czekamy na Wasze komentarze i sugestie.
