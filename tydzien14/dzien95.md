# Tydzień 14: Kubernetes & IaC

## Dzień 95: Zaawansowane zarządzanie zasobami w Kubernetes 🌟

### Rozwijanie umiejętności zarządzania zasobami
W dniu 95. "100 dni do DevOps" skupiamy się na zaawansowanych technikach zarządzania zasobami w Kubernetes, aby zapewnić optymalne wykorzystanie infrastruktury i wysoką dostępność usług.

### Dlaczego zaawansowane zarządzanie zasobami jest ważne?
- **Optymalizacja wykorzystania zasobów**: Zapewnia, że zasoby są wykorzystywane efektywnie, co przekłada się na lepszą wydajność i niższe koszty.
- **Wysoka dostępność**: Poprawne zarządzanie zasobami pomaga utrzymać usługi w działaniu nawet w przypadku awarii czy szczytów obciążenia.
- **Elastyczność**: Umożliwia szybkie dostosowanie infrastruktury do zmieniających się potrzeb aplikacji.

### Kluczowe aspekty zaawansowanego zarządzania zasobami:
- **Limitowanie zasobów**: Konfiguracja limitów CPU i pamięci RAM dla podów, aby zapobiec nadmiernemu zużyciu zasobów przez pojedyncze aplikacje.
  - Przykład pliku YAML z limitami zasobów:
    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: resource-limited-pod
    spec:
      containers:
      - name: my-container
        image: nginx
        resources:
          requests:
            memory: "64Mi"
            cpu: "250m"
          limits:
            memory: "128Mi"
            cpu: "500m"
    ```
- **Autoskalowanie**: Wykorzystanie Horizontal Pod Autoscaler (HPA) do automatycznego skalowania liczby podów w zależności od obciążenia.
  - Przykład konfiguracji HPA:
    ```
    apiVersion: autoscaling/v1
    kind: HorizontalPodAutoscaler
    metadata:
      name: my-hpa
    spec:
      scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: my-deployment
      minReplicas: 2
      maxReplicas: 10
      targetCPUUtilizationPercentage: 80
    ```
- **Affinity i anti-affinity**: Definiowanie reguł, które kontrolują, na jakich węzłach mogą być rozmieszczane pody, co umożliwia optymalne rozmieszczenie i redundancję usług.
  - Przykład konfiguracji affinity:
    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: affinity-pod
    spec:
      containers:
      - name: my-container
        image: nginx
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: disktype
                operator: In
                values:
                - ssd
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                app: nginx
            topologyKey: "kubernetes.io/hostname"
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                app: nginx
            topologyKey: "kubernetes.io/hostname"
    ```
- **Taints i tolerations**: Stosowanie taintów do węzłów i tolerancji w podach, aby kontrolować, które pody mogą być rozmieszczone na określonych węzłach.
  - Przykład konfiguracji taints i tolerations:
    ```
    # Dodanie tainta do węzła
    kubectl taint nodes node1 key=value:NoSchedule

    # Definiowanie tolerancji w pliku YAML poda
    apiVersion: v1
    kind: Pod
    metadata:
      name: tolerant-pod
    spec:
      containers:
      - name: my-container
        image: nginx
      tolerations:
      - key: "key"
        operator: "Equal"
        value: "value"
        effect: "NoSchedule"
    ```

### Podsumowanie
Zaawansowane zarządzanie zasobami w Kubernetes to klucz do budowania wydajnych, skalowalnych i odpornych na awarie systemów, które mogą dynamicznie reagować na zmieniające się warunki. Dzięki technikom takim jak limitowanie zasobów, autoskalowanie, affinity i anti-affinity oraz tainty i toleracje, można zapewnić optymalne wykorzystanie infrastruktury i utrzymanie wysokiej dostępności usług.
