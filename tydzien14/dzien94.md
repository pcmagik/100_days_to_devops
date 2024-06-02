# Tydzień 14: Kubernetes & IaC

## Dzień 94: Wprowadzenie do Infrastruktury jako Kod (IaC) z Kubernetes 🌐

### Eksploracja IaC w świecie Kubernetes
W dniu 94. "100 dni do DevOps" zagłębiamy się w koncepcję Infrastruktury jako Kod (IaC) i jej zastosowanie w Kubernetes, otwierając nowe możliwości w zakresie automatyzacji i zarządzania infrastrukturą.

### Dlaczego IaC z Kubernetes?
- **Automatyzacja**: IaC pozwala na automatyczne tworzenie i zarządzanie infrastrukturą, co jest kluczowe w środowiskach Kubernetes.
- **Spójność i powtarzalność**: Dzięki IaC każda instancja infrastruktury jest tworzona w sposób spójny i powtarzalny, redukując ryzyko błędów ludzkich.
- **Łatwa skalowalność i zarządzanie zmianami**: IaC ułatwia skalowanie i aktualizację infrastruktury bez konieczności ręcznej interwencji.

### Wprowadzenie do narzędzi IaC w Kubernetes:
- **Helm**: Menedżer pakietów dla Kubernetes, który ułatwia zarządzanie aplikacjami przez pakiety zwane chartami.
  - Przykład instalacji Helm:
    ```
    # Instalacja Helm
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

    # Inicjalizacja Helm w klastrze
    helm repo add stable https://charts.helm.sh/stable
    helm repo update
    ```
  - Przykład użycia Helm do wdrożenia aplikacji:
    ```
    # Instalacja aplikacji z użyciem Helm
    helm install my-release stable/nginx
    ```
- **Kustomize**: Narzędzie do dostosowywania konfiguracji aplikacji w Kubernetes bez konieczności edycji plików YAML bezpośrednio.
  - Przykład użycia Kustomize:
    ```
    # Struktura katalogów Kustomize
    my-app/
    ├── kustomization.yaml
    ├── deployment.yaml
    └── service.yaml

    # Plik kustomization.yaml
    apiVersion: kustomize.config.k8s.io/v1beta1
    kind: Kustomization
    resources:
      - deployment.yaml
      - service.yaml

    # Wdrożenie konfiguracji za pomocą Kustomize
    kubectl apply -k my-app/
    ```
- **Terraform**: Może być używany do zarządzania infrastrukturą Kubernetes, oferując zintegrowane podejście do zarządzania zasobami w chmurze i na miejscu.
  - Przykład konfiguracji Terraform dla Kubernetes:
    ```
    provider "kubernetes" {
      config_path = "~/.kube/config"
    }

    resource "kubernetes_namespace" "example" {
      metadata {
        name = "example-namespace"
      }
    }

    resource "kubernetes_deployment" "nginx" {
      metadata {
        name      = "example-nginx"
        namespace = kubernetes_namespace.example.metadata[0].name
      }

      spec {
        replicas = 2

        selector {
          match_labels = {
            app = "nginx"
          }
        }

        template {
          metadata {
            labels = {
              app = "nginx"
            }
          }

          spec {
            container {
              image = "nginx:1.14.2"
              name  = "nginx"
              port {
                container_port = 80
              }
            }
          }
        }
      }
    }
    ```
### Podsumowanie
Wykorzystanie IaC w kontekście Kubernetes otwiera drzwi do bardziej efektywnego i spójnego zarządzania infrastrukturą, umożliwiając szybkie dostosowanie się do zmieniających się potrzeb i wymagań aplikacji. Narzędzia takie jak Helm, Kustomize i Terraform znacząco ułatwiają proces automatyzacji, skalowania i zarządzania zasobami w środowiskach Kubernetes.

