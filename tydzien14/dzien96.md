# Tydzień 14: Kubernetes & IaC

## Dzień 96: Automatyzacja deploymentów w Kubernetes 🚀

### Ułatwienie procesów wdrożeniowych
W dniu 96. "100 dni do DevOps" skupiamy się na automatyzacji procesów deploymentu w Kubernetes, co jest kluczowe dla zapewnienia szybkości, spójności i niezawodności w dostarczaniu aplikacji.

### Dlaczego automatyzacja deploymentów jest ważna?
- **Szybkość wdrożeń**: Automatyzacja pozwala na szybkie i niezawodne rozmieszczanie aplikacji, minimalizując czas potrzebny na manualne interwencje.
- **Spójność**: Zapewnia, że każde wdrożenie jest dokładnie takie samo, co eliminuje "problem działa u mnie" (works on my machine).
- **Skalowalność**: Umożliwia łatwe zarządzanie większą liczbą wdrożeń wraz ze wzrostem złożoności środowisk i aplikacji.

### Implementacja automatyzacji w Kubernetes:
- **CI/CD**: Integracja Kubernetes z narzędziami CI/CD, takimi jak Jenkins, GitLab CI lub GitHub Actions, do automatyzacji testów, budowania i wdrażania aplikacji.
  - Przykład integracji z GitHub Actions:
    ```
    name: CI/CD Pipeline

    on:
      push:
        branches:
          - main

    jobs:
      build:
        runs-on: ubuntu-latest

        steps:
        - name: Checkout code
          uses: actions/checkout@v2

        - name: Set up Kubernetes
          uses: azure/setup-kubectl@v1
          with:
            version: 'v1.20.0'

        - name: Deploy to Kubernetes
          run: kubectl apply -f deployment.yaml
    ```
- **Helm**: Wykorzystanie Helm do zarządzania pakietami aplikacji Kubernetes, ułatwiające zarządzanie wersjami i konfiguracją.
  - Przykład użycia Helm:
    ```
    # Inicjalizacja Helm
    helm repo add stable https://charts.helm.sh/stable
    helm repo update

    # Instalacja aplikacji z użyciem Helm
    helm install my-app stable/nginx
    ```
- **GitOps**: Stosowanie praktyk GitOps do zarządzania infrastrukturą i aplikacjami za pomocą kodu i pull requestów, co zapewnia dodatkową warstwę kontroli i audytu.
  - Przykład konfiguracji GitOps z Argo CD:
    ```
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: my-app
      namespace: argocd
    spec:
      project: default
      source:
        repoURL: 'https://github.com/my-org/my-repo.git'
        targetRevision: HEAD
        path: path/to/kubernetes/configs
      destination:
        server: 'https://kubernetes.default.svc'
        namespace: default
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
    ```

### Podsumowanie
Automatyzacja deploymentów w Kubernetes otwiera nowe możliwości dla zespołów DevOps, umożliwiając im szybkie i efektywne dostarczanie aplikacji z zachowaniem wysokiego poziomu kontroli i spójności. Dzięki narzędziom takim jak CI/CD, Helm i GitOps, można zautomatyzować cały cykl życia aplikacji, od testów po wdrożenie, zapewniając spójność i niezawodność w zarządzaniu infrastrukturą Kubernetes.

