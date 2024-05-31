# Tydzień 14: Kubernetes & IaC

## Dzień 92: Wprowadzenie do Kubernetes 🚢

### Pierwszy dzień z Kubernetes
W dniu 92. "100 dni do DevOps" rozpoczynamy naszą podróż z Kubernetes, otwierając drzwi do świata orkiestracji kontenerów i zarządzania aplikacjami na dużą skalę.

### Dlaczego Kubernetes?
- **Orkiestracja kontenerów**: Automatyzuje rozmieszczanie, skalowanie i operacje na kontenerach aplikacji.
- **Wysoka dostępność**: Zapewnia nieprzerwaną dostępność aplikacji poprzez mechanizmy samonaprawy i load balancing.
- **Skalowalność**: Umożliwia łatwe skalowanie aplikacji w górę lub w dół w zależności od potrzeb.

### Pierwsze kroki z Kubernetes:
1. **Zrozumienie podstawowych koncepcji**:
   - **Klaster**: Zbiór węzłów (node) zarządzanych przez Kubernetes.
   - **Węzeł (Node)**: Pojedynczy serwer w klastrze, może być fizyczny lub wirtualny.
   - **Pod**: Najmniejsza jednostka wdrożenia w Kubernetes, która może zawierać jeden lub więcej kontenerów.
   - **Usługa (Service)**: Abstrakcja definiująca zestaw podów i sposób ich dostępu.
   - **Deployment**: Abstrakcja zarządzająca replikacją podów i ich aktualizacjami.

2. **Instalacja narzędzi**:
   - **Minikube**: Narzędzie do uruchamiania lokalnych klastrów Kubernetes.
     ```
     # Instalacja Minikube
     curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
     sudo install minikube-linux-amd64 /usr/local/bin/minikube
     ```
   - **kubectl**: Interfejs linii poleceń do zarządzania klastrami Kubernetes.
     ```
     # Instalacja kubectl
     curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
     sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
     ```
   
3. **Tworzenie pierwszego deploymentu**:
   - **Uruchomienie Minikube**:
     ```
     # Uruchomienie Minikube
     minikube start
     ```
   - **Tworzenie i wdrażanie deploymentu**:
     ```
     # Tworzenie pliku deployment.yaml
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: nginx-deployment
     spec:
       replicas: 3
       selector:
         matchLabels:
           app: nginx
       template:
         metadata:
           labels:
             app: nginx
         spec:
           containers:
           - name: nginx
             image: nginx:1.14.2
             ports:
             - containerPort: 80
     ```
     ```
     # Wdrażanie deploymentu
     kubectl apply -f deployment.yaml
     ```
   - **Sprawdzanie statusu**:
     ```
     # Sprawdzenie statusu podów
     kubectl get pods
     ```
   
### Podsumowanie
Wprowadzenie do Kubernetes otwiera nowe możliwości w zakresie elastycznego i efektywnego zarządzania aplikacjami w kontenerach, umożliwiając budowanie skalowalnych i odpornych systemów.

