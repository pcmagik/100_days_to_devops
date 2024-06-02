# Tydzień 8: Argo CD & Jenkins

## Dzień 51: Praktyczne budowanie i testowanie aplikacji z Jenkins 🛠️

### Wprowadzenie do wykorzystania Jenkinsa

W 51. dniu naszego cyklu "100 dni do DevOps" skupimy się na praktycznych aspektach wykorzystania Jenkinsa do automatyzacji procesów budowania i testowania aplikacji. Dzięki przykładom gotowych konfiguracji, czytelnicy będą mogli samodzielnie zaimplementować i przetestować proponowane rozwiązania w swoich projektach.

### Dlaczego warto automatyzować budowanie i testowanie z Jenkins?

- **Spójność**: Automatyzacja gwarantuje jednolite procedury budowania i testowania.
- **Szybkość identyfikacji problemów**: Wczesne wykrywanie i naprawianie błędów.
- **Oszczędność czasu**: Redukcja czasochłonnych zadań manualnych.

### Przykładowa konfiguracja Jenkinsa

Poniżej znajdują się dwa oddzielne przykłady: pierwszy dotyczy budowania i wysyłania obrazu Nginx do rejestru Docker, a drugi dotyczy wdrażania Nginx na klastrze Kubernetes.

#### Jenkinsfile dla Docker

```yaml
pipeline {
  agent any
  environment {
    DOCKER_IMAGE = 'nginx-example'
  }
  stages {
      stage('Clone repository') {
          steps {
              git 'https://github.com/przyklad/nginx-docker.git'
          }
      }
      stage('Build Docker image') {
          steps {
              script {
                  sh 'docker build -t ${DOCKER_IMAGE} .'
              }
          }
      }
      stage('Push Docker image') {
          steps {
              script {
                  sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                  sh 'docker push ${DOCKER_IMAGE}'
              }
          }
      }
  }
  post {
      success {
          echo 'Build and Push successful!'
      }
      failure {
          echo 'Error encountered during Build or Push!'
      }
  }
}
```
Jenkinsfile dla Kubernetes

```yaml
pipeline {
  agent any
  environment {
    KUBECONFIG = '/path/to/kubeconfig'
  }
  stages {
      stage('Deploy to Kubernetes') {
          steps {
              script {
                  sh 'kubectl apply -f nginx-k8s-deployment.yaml'
              }
          }
      }
  }
  post {
      success {
          echo 'Deployment successful!'
      }
      failure {
          echo 'Error encountered during Deployment!'
      }
  }
}
```
Plik konfiguracyjny nginx-k8s-deployment.yaml dla Kubernetes
    
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
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
        image: nginx-example:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
```
### Jak uruchomić przykład

Aby uruchomić przykład dla Docker:
1. Upewnij się, że Jenkins ma dostęp do Docker.
2. Zdefiniuj zmienne środowiskowe `DOCKER_USERNAME` i `DOCKER_PASSWORD` dla autentykacji w Docker Registry.

Aby uruchomić przykład dla Kubernetes:
1. Upewnij się, że Jenkins ma dostęp do klastra Kubernetes i dostęp do pliku `kubeconfig`.

### Podsumowanie

Prezentowane konfiguracje Jenkinsa umożliwiają natychmiastowe przetestowanie i zastosowanie w praktyce. Dostarczają one bezpośrednie rozwiązania, które mogą wprowadzić do swoich projektów, zwiększając ich efektywność i jakość w procesie CI/CD.
