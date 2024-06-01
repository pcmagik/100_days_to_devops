# Tydzień 14: Kubernetes & IaC

## Dzień 93: Podstawy konfiguracji i zarządzania klastrami Kubernetes 🛠️

### Budowanie fundamentów w Kubernetes
W dniu 93. "100 dni do DevOps" skupiamy się na podstawach konfiguracji i zarządzania klastrami Kubernetes, kluczowych umiejętnościach dla każdego inżyniera DevOps pracującego z kontenerami.

### Kluczowe aspekty zarządzania klastrami:
- **Klaster Kubernetes**: Zrozumienie, jak składają się na niego węzły master i worker oraz jak są one ze sobą połączone.
  - **Węzeł master**: Odpowiada za zarządzanie klastrem, w tym harmonogramowanie podów, zarządzanie stanem klastra oraz przetwarzanie informacji o zdarzeniach.
  - **Węzeł worker**: Uruchamia pody i zapewnia zasoby obliczeniowe dla aplikacji.
- **Pods**: Podstawowa jednostka w Kubernetes, grupująca jeden lub więcej kontenerów, które są razem uruchamiane na węźle.
  - Przykład pliku YAML dla poda:
    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: my-pod
    spec:
      containers:
      - name: my-container
        image: nginx
        ports:
        - containerPort: 80
    ```
- **Services**: Definiowanie stałych punktów dostępu do podów, umożliwiające komunikację między różnymi częściami aplikacji oraz z zewnętrznym światem.
  - Przykład pliku YAML dla usługi:
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-service
    spec:
      selector:
        app: my-app
      ports:
      - protocol: TCP
        port: 80
        targetPort: 80
      type: LoadBalancer
    ```
- **Deployments**: Zarządzanie stanem pożądanym aplikacji, w tym wersjonowaniem i aktualizacjami.
  - Przykład pliku YAML dla deploymentu:
    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my-deployment
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: my-app
      template:
        metadata:
          labels:
            app: my-app
        spec:
          containers:
          - name: my-container
            image: nginx
            ports:
            - containerPort: 80
    ```

### Narzędzia i praktyki:
- **kubectl**: Interfejs linii poleceń do interakcji z klastrem, umożliwiający zarządzanie zasobami i obserwację stanu klastra.
  - Przykładowe polecenia:
    ```
    # Sprawdzenie statusu klastra
    kubectl cluster-info

    # Wyświetlenie listy podów
    kubectl get pods

    # Wdrażanie zasobu z pliku YAML
    kubectl apply -f my-deployment.yaml
    ```
- **Minikube i Kubernetes Dashboard**: Narzędzia ułatwiające lokalny rozwój i monitorowanie klastrów Kubernetes.
  - **Minikube**: Uruchomienie lokalnego klastra:
    ```
    minikube start
    ```
  - **Kubernetes Dashboard**: Dostęp do interfejsu graficznego:
    ```
    minikube dashboard
    ```
- **YAML**: Format definiowania zasobów Kubernetes, takich jak pods, services, i deployments. YAML jest czytelny i prosty do edytowania, co ułatwia zarządzanie konfiguracjami.

### Podsumowanie
Opanowanie podstaw konfiguracji i zarządzania klastrami Kubernetes jest kluczowe dla skutecznego wdrażania i skalowania aplikacji w środowiskach kontenerowych. Dzięki znajomości podstawowych zasobów i narzędzi, takich jak kubectl, Minikube oraz YAML, można efektywnie zarządzać infrastrukturą Kubernetes.

