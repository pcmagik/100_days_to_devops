# Tydzień 8: Argo CD & Jenkins

## Dzień 50: Wprowadzenie do CI/CD z Jenkins 🚀

### Znaczenie CI/CD w DevOps
W dniu 50. naszej serii "100 dni do DevOps", eksplorujemy Continuous Integration (CI) i Continuous Delivery (CD) z wykorzystaniem Jenkinsa. Jenkins nie tylko automatyzuje fazy budowania i testowania kodu, ale również umożliwia szybkie wdrażanie zmian na produkcję w kontrolowany sposób.

### Dlaczego Jenkins?
- **Elastyczność**: Jenkins wspiera różnorodne języki programowania i narzędzia, co sprawia, że jest doskonałym wyborem dla zespołów poliglotycznych.
- **Rozszerzalność**: Dzięki bogatemu ekosystemowi wtyczek, Jenkins może być dostosowany do specyficznych potrzeb twojego workflow.
- **Społeczność**: Jenkins cieszy się wsparciem szerokiej społeczności deweloperów, która nieustannie pracuje nad nowymi wtyczkami i ulepszeniami.

### Pierwsze kroki z Jenkins:
1. **Instalacja Jenkinsa**: Możesz zainstalować Jenkinsa na serwerze lub uruchomić w kontenerze Docker. Poniżej znajduje się przykład konfiguracji `docker-compose` dla Jenkinsa.
2. **Konfiguracja projektu**:
   - Utwórz nowy job w Jenkinsie.
   - Skonfiguruj źródło kodu, np. z GitHub za pomocą webhooków.
   - Ustawienie zadań budowania i testowania zgodnie z wymaganiami projektu.
3. **Automatyzacja**:
   - Konfiguracja Jenkinsa do automatycznego uruchamiania procesów CI/CD przy każdym commitcie.
   - Użycie Jenkins Pipeline do zdefiniowania kroków procesu CI/CD, które mogą obejmować budowanie, testowanie, i wdrażanie aplikacji.

### Zastosowanie w praktyce
- **Integracja z Dockerem**: Jenkins może budować obrazy Docker bezpośrednio z Jenkins Pipeline, używając wtyczki Docker Pipeline.
- **Przykład skonfigurowania Jenkins Pipeline**:
  ```groovy
  pipeline {
      agent any
      stages {
          stage('Build') {
              steps {
                  script {
                      docker.build("moj-aplikacja:${env.BUILD_ID}")
                  }
              }
          }
          stage('Test') {
              steps {
                  script {
                      docker.image("moj-aplikacja:${env.BUILD_ID}").inside {
                          sh 'make test'
                      }
                  }
              }
          }
          stage('Deploy') {
              steps {
                  script {
                      sh 'echo Deploying...'
                  }
              }
          }
      }
  }
  ```
- **Monitorowanie i logowanie**: Konfiguracja Jenkinsa do monitorowania wykonania zadań i logowania wyników, co jest kluczowe dla utrzymania stabilności i reaktywności systemu.

### Podsumowanie
Jenkins jest kluczowym narzędziem w ekosystemie DevOps, zapewniając elastyczność i skalowalność niezbędną do efektywnego zarządzania cyklami życia oprogramowania. Z jego pomocą zespoły mogą lepiej reagować na potrzeby biznesowe i utrzymywać ciągłość dostaw w dynamicznie zmieniających się środowiskach produkcyjnych.

### Docker Compose dla Jenkins
```yaml
version: '3.8'
services:
  jenkins:
    image: jenkins/jenkins:lts
    privileged: true
    user: root
    ports:
      - 8082:8080
      - 50000:50000
    container_name: jenkins
    volumes:
      - /home/pcmagik/docker/jenkins:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/local/bin/docker:/usr/local/bin/docker
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.jenkins.entrypoints=http"
      - "traefik.http.routers.jenkins.rule=Host(`jenkins.twojadomena.pl`)"
      - "traefik.http.middlewares.jenkins-https-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.jenkins.middlewares=jenkins-https-redirect"
      - "traefik.http.routers.jenkins-secure.entrypoints=https"
      - "traefik.http.routers.jenkins-secure.rule=Host(`jenkins.twojadomena.pl`)"
      - "traefik.http.routers.jenkins-secure.tls=true"
      - "traefik.http.routers.jenkins-secure.tls.certresolver=cloudflare"
      - "traefik.http.services.jenkins.loadbalancer.server.port=8080"
networks: 
  proxy:
    external: true
```

### Przykładowa konfiguracja dla Jenkins Pipeline oraz integracja z Dockerem pokazują, jak można efektywnie zarządzać procesami CI/CD w nowoczesnych środowiskach DevOps.
