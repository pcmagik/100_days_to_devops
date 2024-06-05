# Tydzień 14: Kubernetes & IaC

## Dzień 97: Monitoring i logowanie w Kubernetes 📊

### Podnoszenie jakości nadzoru
W dniu 97. "100 dni do DevOps" skupiamy się na znaczeniu i implementacji monitoringu oraz logowania w ekosystemie Kubernetes, co jest niezbędne dla utrzymania zdrowia i wydajności klastrów oraz aplikacji.

### Dlaczego monitoring i logowanie są kluczowe?
- **Wgląd w system**: Monitoring dostarcza niezbędnych informacji na temat stanu klastrów, podów i aplikacji, umożliwiając szybką reakcję na potencjalne problemy.
- **Analiza problemów**: Logowanie pozwala na głęboką analizę zdarzeń i identyfikację przyczyn problemów, co jest kluczowe dla ich szybkiego rozwiązywania.
- **Optymalizacja wydajności**: Regularne monitorowanie i analiza logów umożliwia optymalizację wydajności klastrów i aplikacji.

### Implementacja w Kubernetes:
- **Prometheus i Grafana**: Wykorzystanie Prometheus do zbierania metryk oraz Grafana do wizualizacji danych, co razem oferuje potężne narzędzie do monitoringu klastrów Kubernetes.
  - Przykład konfiguracji Prometheus:
    ```
    apiVersion: monitoring.coreos.com/v1
    kind: Prometheus
    metadata:
      name: k8s
      namespace: monitoring
    spec:
      serviceAccountName: prometheus-k8s
      serviceMonitorSelector:
        matchLabels:
          team: frontend
    ```
  - Przykład konfiguracji Grafana:
    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: grafana
      namespace: monitoring
    spec:
      containers:
      - name: grafana
        image: grafana/grafana:latest
        ports:
        - containerPort: 3000
    ```
- **Elasticsearch, Logstash, Kibana (ELK)**: Stosowanie stosu ELK do agregacji, przechowywania i analizy logów z klastrów i aplikacji działających w Kubernetes.
  - Przykład konfiguracji Logstash:
    ```
    input {
      beats {
        port => 5044
      }
    }

    output {
      elasticsearch {
        hosts => ["http://elasticsearch:9200"]
      }
    }
    ```
  - Przykład konfiguracji Kibana:
    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: kibana
      namespace: monitoring
    spec:
      containers:
      - name: kibana
        image: kibana:latest
        ports:
        - containerPort: 5601
    ```
- **Alerting**: Konfiguracja alertów na podstawie metryk z Prometheus lub innych narzędzi monitoringu, aby zapewnić szybką reakcję na krytyczne problemy.
  - Przykład konfiguracji alertu w Prometheus:
    ```
    groups:
    - name: example
      rules:
      - alert: HighMemoryUsage
        expr: node_memory_Active_bytes / node_memory_MemTotal_bytes * 100 > 90
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: "High memory usage detected"
          description: "Memory usage is above 90% for more than 2 minutes."
    ```

### Podsumowanie
Zaawansowane monitoring i logowanie w Kubernetes są fundamentem dla zapewnienia stabilności, wydajności i bezpieczeństwa środowisk kontenerowych, oferując jednocześnie cenne wglądy w działanie aplikacji. Dzięki narzędziom takim jak Prometheus, Grafana i ELK, zespoły DevOps mogą efektywnie monitorować, analizować i reagować na wszelkie problemy w klastrach Kubernetes.
 