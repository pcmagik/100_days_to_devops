# Tydzień 12: Ansible & Automations

## Dzień 83: Integracja Ansible z narzędziami monitoringu i logowania 📊

### Wzmacnianie monitoringu z Ansible
W dniu 83. "100 dni do DevOps" eksplorujemy, jak Ansible może być zintegrowany z narzędziami monitoringu i logowania, aby zapewnić lepszą widoczność i reaktywność na zmiany w infrastrukturze.

### Dlaczego integracja z monitorowaniem jest ważna?
- **Widoczność**: Umożliwia śledzenie skutków zmian wprowadzanych przez Ansible w infrastrukturze w czasie rzeczywistym.
- **Reaktywność**: Ułatwia szybką reakcję na wszelkie anomalie lub problemy wykryte przez systemy monitoringu.
- **Audyt**: Pomaga w dokumentowaniu zmian i zdarzeń dla celów audytu i zgodności.

### Implementacja integracji z Ansible:
1. **Wykorzystanie callback plugins**:
   - Ansible oferuje pluginy callback, które mogą być wykorzystane do wysyłania powiadomień do narzędzi monitorujących po wykonaniu playbooków.
   - Przykład konfiguracji pluginu callback do wysyłania powiadomień do Slacka:
     ```yaml
     # ansible.cfg
     [defaults]
     callback_whitelist = slack

     [callback_slack]
    token = <YOUR_SLACK_TOKEN_HERE>
     channel = #ansible-notifications
     username = AnsibleBot
     ```

2. **Logowanie**:
   - Konfiguracja Ansible do wysyłania logów do centralnych systemów logowania, takich jak ELK Stack (Elasticsearch, Logstash, Kibana) lub Splunk.
   - Przykład konfiguracji logowania do syslog:
     ```yaml
     # ansible.cfg
     [defaults]
     log_path = /var/log/ansible.log

     [loggers]
     keys = root, ansible

     [handlers]
     keys = consoleHandler, fileHandler

     [formatters]
     keys = json

     [logger_root]
     level = DEBUG
     handlers = consoleHandler, fileHandler

     [logger_ansible]
     level = DEBUG
     handlers = fileHandler
     qualname = ansible

     [handler_consoleHandler]
     class = StreamHandler
     level = DEBUG
     formatter = json
     args = (sys.stdout,)

     [handler_fileHandler]
     class = FileHandler
     level = DEBUG
     formatter = json
     args = ('/var/log/ansible.log', 'a')
     ```

3. **Customowe skrypty**:
   - Tworzenie niestandardowych skryptów, które wykorzystują API narzędzi monitorujących, aby zintegrować je z Ansible.
   - Przykład skryptu Python do wysyłania danych do Prometheus:
     ```python
     import requests

     def send_to_prometheus(metric_name, value, labels):
         url = 'http://prometheus-server:9091/metrics/job/ansible'
         data = f'{metric_name}{{{",".join([f"{k}={v}" for k, v in labels.items()])}}} {value}'
         response = requests.post(url, data=data)
         return response.status_code

     send_to_prometheus('ansible_task_duration', 123, {'task': 'deploy_app', 'status': 'success'})
     ```

### Podsumowanie
Integracja Ansible z narzędziami monitoringu i logowania znacznie poprawia zarządzanie infrastrukturą, oferując lepszą widoczność i kontrolę nad środowiskiem IT. Dzięki temu zespoły DevOps mogą szybciej reagować na problemy, zapewniać zgodność z wymaganiami audytu oraz utrzymywać wysoki poziom bezpieczeństwa i niezawodności.

### Co dalej?
W kolejnych dniach będziemy badać zaawansowane integracje Ansible z systemami CI/CD oraz dalszą automatyzację procesów zarządzania infrastrukturą. Zachęcamy do eksperymentowania z integracją narzędzi monitoringu i logowania, aby w pełni wykorzystać potencjał Ansible w codziennej pracy.

Podziel się swoimi doświadczeniami i przykładami integracji Ansible z narzędziami monitoringu! Jakie wyzwania napotkaliście i jakie rozwiązania okazały się skuteczne? Czekamy na Wasze komentarze i sugestie.
