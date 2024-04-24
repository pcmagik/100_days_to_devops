# Tydzień 8: Argo CD & Jenkins

## Dzień 55: Zaawansowane workflow w Argo CD 🌟

### Eksploracja zaawansowanych możliwości Argo CD
Pięćdziesiąty piąty dzień "100 dni do DevOps" poświęcony jest na zaawansowane funkcjonalności Argo CD, które umożliwiają budowanie skomplikowanych workflow wdrażania aplikacji, zgodnie z najlepszymi praktykami GitOps i pełnym wykorzystaniem potencjału Kubernetes.

### Co oferują zaawansowane workflow w Argo CD?
- **Blue/Green Deployment**: Metoda zapewniająca zerowy czas przestoju poprzez przełączanie ruchu między dwiema wersjami aplikacji.
- **Canary Releases**: Technika polegająca na wprowadzaniu nowych wersji aplikacji w kontrolowany sposób, początkowo dla małej grupy użytkowników.
- **Rollbacks**: Funkcjonalność umożliwiająca szybkie przywracanie wcześniejszych stanów aplikacji, gdy najnowsze zmiany nie działają jak oczekiwano.

### Implementacja zaawansowanych funkcji:
1. **Konfiguracja strategii wdrażania w Argo CD**:
   Definiujesz strategie wdrażania bezpośrednio w manifestach aplikacji:

    ```yaml
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: twoja-aplikacja
    spec:
      strategy:
        blueGreen: {}
    ```

2. **Wykorzystanie Custom Resource Definitions (CRD)**:
   Tworzysz niestandardowe definicje zasobów w Kubernetes, które umożliwiają bardziej złożone procesy wdrażania:

    ```yaml
    apiVersion: "argoproj.io/v1alpha1"
    kind: Rollout
    metadata:
      name: canary-rollout
    spec:
      ...
      strategy:
        canary:
          steps:
          - setWeight: 20
          - pause: {duration: 5m}
          - setWeight: 40
          - pause: {duration: 5m}
          ...
    ```

3. **Monitorowanie i analiza wdrożeń**:
   Korzystasz z wbudowanych dashboardów Argo CD do obserwowania stanu wdrożeń i śledzenia metryk.

### Przykładowe użycie Argo CD Rollouts dla Canary Deployment:
Aby zaimplementować Canary Deployment, możesz użyć Argo Rollouts, rozszerzenia Argo CD:

1. Zainstaluj Argo Rollouts w twoim klastrze Kubernetes:

    ```shell
    kubectl create namespace argo-rollouts
    kubectl apply -n argo-rollouts -f https://raw.githubusercontent.com/argoproj/argo-rollouts/stable/manifests/install.yaml
    ```

2. Skonfiguruj manifest aplikacji z Canary Deployment:

    ```yaml
    apiVersion: argoproj.io/v1alpha1
    kind: Rollout
    metadata:
      name: twoja-aplikacja-canary
    spec:
      selector:
        matchLabels:
          app: twoja-aplikacja
      template:
        ...
      strategy:
        canary:
          steps:
          - setWeight: 20
          - pause: {duration: 5m}
          - setWeight: 40
          - pause: {duration: 5m}
          ...
    ```

3. Śledź postęp wdrażania za pomocą CLI Argo Rollouts:

    ```shell
    kubectl argo rollouts get rollout twoja-aplikacja-canary -w
    ```

### Podsumowanie
Zaawansowane workflow w Argo CD dają możliwość dokładnej kontroli nad procesem wdrażania aplikacji, co zwiększa nie tylko efektywność, ale i bezpieczeństwo operacji. Wykorzystanie tych technik pozwala na wprowadzanie zmian w sposób płynny i kontrolowany, co jest kluczowe w dynamicznych środowiskach produkcyjnych.
