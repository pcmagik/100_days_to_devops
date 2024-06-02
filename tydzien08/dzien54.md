# Tydzień 8: Argo CD & Jenkins

## Dzień 54: Integracja Jenkins z Argo CD 🔄

### Połączenie mocy Jenkins i Argo CD
Dzień 54. "100 dni do DevOps" poświęcamy na odkrywanie, jak integrować Jenkins, nasze centrum operacji CI/CD, z Argo CD, aby wykorzystać GitOps do automatycznego wdrażania w Kubernetes.

### Dlaczego warto integrować Jenkins z Argo CD?
- **Automatyzacja end-to-end**: Pełen przepływ pracy od integracji i dostarczania w Jenkinsie po wdrażanie w Kubernetes przez Argo CD.
- **Spójność i kontrola**: Zapewnienie spójności konfiguracji poprzez wersjonowanie w Git.
- **Złożone workflow**: Integracja Jenkinsa z Argo CD umożliwia obsługę skomplikowanych procesów CI/CD.

### Implementacja integracji:
1. **Skonfiguruj zadanie Jenkins**: Tworzy i testuje kod, a następnie aktualizuje repozytorium Git, które jest monitorowane przez Argo CD.

    ```groovy
    pipeline {
        agent any
        stages {
            stage('Build & Test') {
                steps {
                    // Budowanie i testowanie aplikacji
                }
            }
            stage('Update Git Repository') {
                steps {
                    script {
                        // Skrypty aktualizujące repozytorium Git
                    }
                }
            }
        }
    }
    ```

2. **Wyzwalanie synchronizacji Argo CD**: Użyj webhooka GitHub lub API Argo CD do wyzwalania wdrożeń.

    ```shell
    curl --request POST --url 'http://<argo-cd-server>/api/v1/applications/<app-name>/sync' \
         --header 'Authorization: Bearer <token>'
    ```

3. **Monitoring wdrożeń**: Użyj UI Argo CD lub CLI do monitorowania statusu wdrożeń.

    ```shell
    argocd app list
    argocd app get <app-name>
    ```

### Przykładowy Jenkinsfile z wyzwalaniem Argo CD
Oto przykładowy Jenkinsfile, który po zbudowaniu i przetestowaniu kodu wywoła synchronizację w Argo CD.

    ```groovy
    pipeline {
        agent any
        environment {
            ARGOCD_SERVER = 'http://<argo-cd-server>'
            APP_NAME = '<app-name>'
            ARGOCD_TOKEN = '<token>'
        }
        stages {
            // Przykładowe etapy budowania i testowania
            stage('Deploy to Kubernetes') {
                steps {
                    script {
                        // Wyzwolenie synchronizacji w Argo CD
                        sh "curl --request POST --url '${ARGOCD_SERVER}/api/v1/applications/${APP_NAME}/sync' --header 'Authorization: Bearer ${ARGOCD_TOKEN}'"
                    }
                }
            }
        }
        post {
            success {
                // Log sukcesu
                echo 'Deployment triggered in Argo CD successfully.'
            }
            failure {
                // Log niepowodzenia
                echo 'Deployment to Argo CD failed.'
            }
        }
    }
    ```

### Podsumowanie
Integracja Jenkins z Argo CD umożliwia stworzenie zaawansowanego i automatycznego przepływu pracy dla Twoich aplikacji. Wykorzystując moc obu narzędzi, możesz zbudować wydajne i spójne procesy CI/CD, od kodu źródłowego po produkcję, jednocześnie stosując się do praktyk GitOps.
