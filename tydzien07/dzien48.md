# Tydzień 7: Github Actions

## Dzień 48: Zabezpieczenia i tajne klucze w Github Actions 🔐

### Wprowadzenie do bezpieczeństwa w Github Actions
W dniu 48. naszej serii "100 dni do DevOps" skupiamy się na bezpieczeństwie w Github Actions. W tym kontekście koncentrujemy się szczególnie na zarządzaniu tajnymi kluczami oraz zmiennymi środowiskowymi, które są fundamentem dla bezpiecznego przechowywania i używania poufnych danych. Zapewnienie bezpieczeństwa tych informacji jest kluczowe dla ochrony naszych projektów i środowisk operacyjnych.

### Dlaczego zarządzanie tajnymi kluczami jest ważne?
- **Bezpieczeństwo**: Ochrona poufnych danych, takich jak hasła, klucze API, tokeny dostępu i certyfikaty, jest niezbędna do zabezpieczania aplikacji i danych.
- **Dostępność**: Tajne klucze muszą być łatwo dostępne dla uprawnionych workflowów, lecz zarazem skutecznie chronione przed nieautoryzowanym dostępem.
- **Zgodność**: Przestrzeganie standardów zgodności, takich jak GDPR czy HIPAA, wymaga stosowania najlepszych praktyk w zarządzaniu poufnymi danymi.

### Implementacja bezpieczeństwa w Github Actions:
- **Korzystanie z Secrets**: Github Actions umożliwia definiowanie tajnych kluczy w ustawieniach repozytorium, które mogą być używane w workflowach bez bezpośredniego ujawniania ich wartości.
- **Ograniczanie dostępu**: Można określić, które workflowe i jakie kroki mają dostęp do tajnych kluczy, co pomaga ograniczyć ryzyko nieautoryzowanego dostępu.
- **Najlepsze praktyki**: Stosowanie zasad minimalnego przywileju, zaszyfrowanie poufnych danych przy użyciu bezpiecznych metod oraz regularne rotowanie kluczy to kluczowe praktyki w zarządzaniu tajnymi danymi.

### Przykład użycia Secrets w Github Actions:
Poniższy przykład demonstruje, jak bezpiecznie używać tajnych kluczy w workflowie do autentykacji w usłudze zewnętrznej.

~~~yaml
name: Przykładowy Workflow

on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v2

      - name: Logowanie do AWS
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: 'eu-central-1'

      - name: Deploy na AWS
        run: ./deploy.sh
~~~

### Podsumowanie
Zarządzanie tajnymi kluczami w Github Actions pozwala na bezpieczne i efektywne zarządzanie poufnymi danymi, zapewniając ochronę naszych projektów i automatyzacji.

