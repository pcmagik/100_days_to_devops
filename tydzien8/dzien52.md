# Tydzień 8: Argo CD & Jenkins

## Dzień 52: Wprowadzenie do GitOps i Argo CD 🌐

### Podstawy GitOps i wykorzystanie Argo CD
W dniu 52. naszego cyklu "100 dni do DevOps" przyglądamy się bliżej GitOps, metodologii służącej do zarządzania infrastrukturą i aplikacjami, która wykorzystuje system kontroli wersji Git jako źródło prawdy. Argo CD to popularne narzędzie, które implementuje GitOps w środowisku Kubernetes, automatyzując wdrażanie aplikacji.

### Dlaczego GitOps to dobra praktyka?
- **Jedno źródło prawdy**: Git służy jako kanoniczne źródło konfiguracji, co ułatwia śledzenie zmian i audyt.
- **Automatyzacja procesu wdrażania**: Zmiany w repozytorium Git automatycznie wyzwalają aktualizacje w infrastrukturze.
- **Odtwarzalność**: Możliwość szybkiego przywrócenia stanu infrastruktury i aplikacji w przypadku awarii.

### Pierwsze kroki z Argo CD
- Zainstaluj Argo CD na klastrze Kubernetes.
- Skonfiguruj Argo CD do monitorowania wybranego repozytorium Git i automatycznego synchronizowania stanu infrastruktury i aplikacji.
- Zapoznaj się z kluczowymi pojęciami Argo CD, w tym z obiektami Application, Project, i politykami synchronizacji (Sync Policy).

### Instalacja Argo CD
Do zainstalowania Argo CD w klastrze Kubernetes wykonaj poniższe kroki:

1. Utwórz namespace `argocd` w Kubernetes:

    ```shell
    kubectl create namespace argocd
    ```

2. Zainstaluj Argo CD:

    ```shell
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    ```

3. Poczekaj, aż wszystkie pody Argo CD będą miały status `Running`:

    ```shell
    kubectl get pods -n argocd
    ```

4. Zmień usługę Argo CD API Server na typ `LoadBalancer` lub `NodePort`, aby uzyskać do niej dostęp z przeglądarki:

    ```shell
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    ```

### Konfiguracja repozytorium Git w Argo CD
Po instalacji Argo CD musisz skonfigurować dostęp do repozytorium Git:

1. Zaloguj się do Argo CD przy użyciu CLI (nazwa użytkownika: `admin`, hasło: wartość w polu `pod-name` dla poda serwera API Argo CD):

    ```shell
    argocd login <ARGOCD_SERVER>
    ```

2. Dodaj repozytorium Git:

    ```shell
    argocd repo add <REPO_URL> --username <USERNAME> --password <PASSWORD>
    ```

### Definicje aplikacji w Argo CD
Przykład pliku definicji aplikacji, który wskazuje Argo CD na śledzenie repozytorium Git:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: nginx-example
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://github.com/przyklad/nginx-k8s.git'
    targetRevision: HEAD
    path: k8s/overlays/prod
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: prod
  syncPolicy:
    automated: {}
```
### Podsumowanie
GitOps i Argo CD to potężne narzędzia, które transformują sposób zarządzania i wdrażania aplikacji w środowisku Kubernetes. Umożliwiają one zautomatyzowane, powtarzalne i niezawodne procesy wdrażania, które są całkowicie zarządzane przez kod, co jest kluczową praktyką w DevOps.