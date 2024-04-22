# Tydzień 8: Argo CD & Jenkins

## Dzień 53: Wdrażanie aplikacji z Argo CD 🚀

### Wdrażanie aplikacji w praktyce z Argo CD
W dniu 53. "100 dni do DevOps" zagłębiamy się w proces wdrażania aplikacji przy użyciu Argo CD. To narzędzie GitOps dla Kubernetes ułatwia automatyczne wdrażanie konfiguracji aplikacji zdefiniowanych w repozytorium Git.

### Dlaczego wdrażanie z Argo CD?
- **Automatyzacja**: Synchronizacja stanu aplikacji w Kubernetes z konfiguracją w Git jest automatyczna.
- **Przejrzystość**: Możliwość przeglądania historii zmian i wdrożeń.
- **Łatwość zarządzania**: Deklaratywne podejście do definicji aplikacji ułatwia ich zarządzanie i skalowanie.

### Krok po kroku z Argo CD:
1. **Tworzenie definicji aplikacji**: Zdefiniuj swoją aplikację w plikach YAML i umieść je w repozytorium Git.

    ```yaml
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: twoja-aplikacja
    spec:
      project: default
      source:
        repoURL: 'https://twoje.repozytorium.git'
        path: ścieżka/do/aplikacji
        targetRevision: HEAD
      destination:
        server: 'https://kubernetes.default.svc'
        namespace: twoja-przestrzeń-nazw
      syncPolicy:
        automated:
          selfHeal: true
          prune: true
    ```

2. **Konfiguracja Argo CD**: Skonfiguruj Argo CD, aby śledziło Twoje repozytorium Git, dodając je przez UI lub CLI.

    ```shell
    argocd repo add https://twoje.repozytorium.git
    ```

3. **Ustawienie polityki synchronizacji**: Określ, jak Argo CD ma zarządzać procesem synchronizacji.

4. **Monitorowanie wdrożeń**: Skorzystaj z panelu użytkownika Argo CD, aby monitorować i zarządzać wdrożeniami.

    Aby uzyskać dostęp do panelu użytkownika Argo CD:

    ```shell
    argocd server --browser
    ```

5. **Zarządzanie wdrożeniami z CLI**: Użyj Argo CD CLI do zarządzania wdrożeniami z wiersza poleceń.

    ```shell
    argocd app list
    argocd app sync twoja-aplikacja
    argocd app get twoja-aplikacja
    ```

### Podsumowanie
Wdrażanie aplikacji z Argo CD wprowadza poziom automatyzacji i przejrzystości, który jest nieosiągalny w tradycyjnych podejściach. Używając Argo CD, możesz łatwiej zarządzać cyklem życia swoich aplikacji, mając pewność, że stan Twojego środowiska jest odzwierciedleniem kodu z repozytorium Git.
