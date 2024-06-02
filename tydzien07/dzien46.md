# Tydzień 7: Github Actions

## Dzień 46: Automatyczne podbicie wersji aplikacji z GitHub Actions 🆙

### Wprowadzenie do zarządzania wersjami
W 46. dniu "100 dni do DevOps" koncentrujemy się na **automatycznym podbijaniu wersji aplikacji przy użyciu GitHub Actions**. Prawidłowe zarządzanie wersjami jest kluczowe dla utrzymania porządku w cyklu życia oprogramowania, a automatyzacja tego procesu zwiększa efektywność i spójność.

### Dlaczego automatyzacja wersjonowania jest ważna?
- **Spójność**: Zapewnia jednolite i przewidywalne wersjonowanie w całym projekcie.
- **Automatyzacja**: Zmniejsza ryzyko błędów ludzkich w procesie podbijania wersji.
- **Śledzenie**: Ułatwia śledzenie zmian i zarządzanie wydaniami.

### Automatyczne podbicie wersji z GitHub Actions:
- Konfiguracja workflow GitHub Actions, który podbija wersję aplikacji za każdym razem, gdy do głównej gałęzi dodawane są nowe zmiany.
- Wykorzystanie tagów Git do oznaczania wersji i integracja z systemem wydawniczym.
- Automatyczne generowanie changelogów na podstawie commitów i pull requestów.


### Automatyczne podbicie wersji aplikacji przy użyciu GitHub Actions
```yaml
name: Version Release

on:
  push:
    branches:
      - main

permissions:
  contents: write
  issues: write

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0  # Ważne, aby pobrać całą historię dla semantic-release
      - uses: actions/setup-node@v3
        with:
          node-version: '14'
      - run: npm install
      - run: npx semantic-release
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

#### Przykładowe typy commitów, które mogą wywołać zmianę wersji to:

`feat:` Nowa funkcja dla użytkownika, nie dla buildu skryptu.

`fix:` Naprawa błędu dla użytkownika, nie dla buildu skryptu.

`BREAKING CHANGE:` Zmiana, która powoduje niekompatybilność wsteczną.

#### Przykładowy commit wywołujący zmianę wersji:
```bash
git commit -m "feat: dodanie nowej funkcjonalności ..."
git push origin main
``` 


### Podsumowanie
Automatyzacja wersjonowania z GitHub Actions to nieocenione narzędzie, które zapewnia spójność, precyzję i efektywność w procesie wydawniczym aplikacji.

