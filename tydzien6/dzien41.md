# Tydzień 6: Security

## Dzień 41: Automatyzacja testów bezpieczeństwa w CI/CD 🛡️

### Znaczenie testów bezpieczeństwa w CI/CD
W 41. dniu "100 dni do DevOps" skupiamy się na integracji i automatyzacji testów bezpieczeństwa w procesach Continuous Integration i Continuous Delivery (CI/CD), co jest kluczowe dla wczesnego wykrywania podatności.

### Dlaczego automatyzacja testów bezpieczeństwa jest kluczowa?
- **Wczesne wykrywanie**: Automatyczne testy pozwalają na identyfikację podatności już na wczesnym etapie rozwoju oprogramowania.
- **Zmniejszenie ryzyka**: Zautomatyzowane testy zmniejszają ryzyko wprowadzenia podatnego kodu do środowiska produkcyjnego.
- **Zgodność z regulacjami**: Ułatwiają przestrzeganie standardów bezpieczeństwa i regulacji prawnych.

### Przykłady użycia narzędzi do testów bezpieczeństwa w CI/CD:

#### OWASP ZAP
- **Integracja z Jenkins**: Można użyć wtyczki OWASP ZAP Jenkins do automatycznego uruchamiania skanowania ZAP jako część pipeline'ów Jenkins.
```bash
  stage('OWASP ZAP Scan') {
    steps {
      zapHome: '/path/to/ZAP', target: 'http://your.application.url'
    }
  }
  ```

#### SonarQube
- **Integracja z GitLab CI/CD**: Dodaj kroki SonarQube do pliku `.gitlab-ci.yml`, aby automatycznie skanować kod pod kątem podatności.
```bash
  sonarqube_scan:
    script:
      - sonar-scanner -Dsonar.projectKey=your_project_key -Dsonar.sources=.
  ```

#### Snyk
- **Integracja z GitHub Actions**: Użyj akcji Snyk, aby skanować zależności projektu na podatności w każdym pull requeście.
```bash
  - name: Run Snyk to check for vulnerabilities
    uses: snyk/actions/[email protected]
    env:
      SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
    with:
      command: test
  ```

### Podsumowanie
Włączenie zautomatyzowanych testów bezpieczeństwa do procesów CI/CD pozwala na ciągłe monitorowanie podatności i podnoszenie poziomu bezpieczeństwa aplikacji oraz infrastruktury. Implementacja narzędzi takich jak OWASP ZAP, SonarQube i Snyk w pipeline'ach CI/CD jest kluczowa dla utrzymania wysokiej postawy bezpieczeństwa.