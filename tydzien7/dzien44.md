# Tydzień 7: Github Actions

## Dzień 44: Testy aplikacji Docker z GitHub Actions 🐳

### Wprowadzenie do testowania aplikacji Docker
W 44. dniu naszej serii "100 dni do DevOps" skupiamy się na wykorzystaniu **GitHub Actions do testowania aplikacji Docker**. Automatyczne testowanie aplikacji konteneryzowanych jest kluczowym elementem zapewnienia jakości i niezawodności w procesie CI/CD.

### Dlaczego testowanie aplikacji Docker jest ważne?
- **Jakość**: Zapewnia wysoką jakość i stabilność kodu.
- **Bezpieczeństwo**: Umożliwia wczesne wykrywanie potencjalnych problemów i luk bezpieczeństwa.
- **Szybkość**: Przyspiesza proces developmentu i wdrażania zmian.

### Testowanie aplikacji Docker z GitHub Actions:
Aby przetestować aplikację Docker, potrzebujesz odpowiedniego workflow, który buduje obraz Docker, uruchamia kontener i wykonuje testy. Poniżej znajdziesz przykładową konfigurację pliku `.github/workflows/docker-test.yml`:

~~~yaml
name: Testy Docker

on:
  push:
    branches:
      - main

jobs:
  build_and_test:
    runs-on: ubuntu-latest
    services:
      redis:
        image: redis
        ports:
          - 6379/tcp
    steps:
    - uses: actions/checkout@v2
    - name: Budowanie obrazu Docker
      run: docker build -t moja-aplikacja .
    - name: Uruchomienie kontenera
      run: docker run -d --name test-container -p 5000:5000 moja-aplikacja
    - name: Wykonanie testów
      run: docker exec test-container pytest
    - name: Zbieranie logów
      if: failure()
      run: docker logs test-container
    - name: Sprzątanie
      if: always()
      run: docker stop test-container && docker rm test-container
~~~

### Najlepsze praktyki dla testów w kontenerach:
- **Wykorzystanie serwisów zewnętrznych**: Użyj usług takich jak Redis czy PostgreSQL jako zewnętrznych serwisów w swoim workflow, aby upewnić się, że testy odzwierciedlają rzeczywiste warunki użytkowania.
- **Oddzielenie zależności**: Zapewnij, że każdy test jest niezależny przez odpowiednie zarządzanie stanem aplikacji i baz danych.
- **Automatyczne sprzątanie**: Konfiguruj swoje workflow tak, aby po zakończeniu testów, wszystkie zasoby były odpowiednio usuwane.

### Podsumowanie
Automatyzacja testów aplikacji Docker z GitHub Actions to kluczowy krok w zapewnieniu ciągłej jakości i bezpieczeństwa aplikacji w cyklu życia DevOps. Wdrożenie takich testów pozwala na szybką i skuteczną weryfikację funkcjonalności i bezpieczeństwa aplikacji, jednocześnie skracając czas potrzebny na manualne testowanie.
