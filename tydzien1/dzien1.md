# Tydzień 1: DevOps & Git 🚀

## Dzień 1: Wprowadzenie do DevOps 🛠️

### Podstawy DevOps
W dniu 1. "100 dni do DevOps" wprowadzamy podstawowe koncepcje DevOps, czyli kultury współpracy między zespołami 'development' i 'operations', która ma na celu szybsze i bardziej niezawodne dostarczanie oprogramowania.

### Kluczowe elementy DevOps:
- **Automatyzacja**: Klucz do przyspieszenia procesów i minimalizacji błędów.
- **CI/CD**: Automatyzacja budowania, testowania i wdrażania kodu.
- **Monitorowanie**: Ciągłe monitorowanie systemów w celu szybkiego wykrywania problemów.
- **Współpraca**: Bliska współpraca między zespołami developerskimi i operacyjnymi.
- **Optymalizacja**: Ciągłe doskonalenie procesów i narzędzi.

### Zadania zespołów:

#### Development:
- **Kodowanie**: Tworzenie i testowanie nowych funkcji.
- **CI**: Automatyczne budowanie i testowanie kodu.
- **Wersjonowanie**: Zarządzanie kodem z Git.

#### Operations:
- **Infrastruktura**: Wdrażanie i utrzymanie serwerów i baz danych.
- **Monitorowanie**: Śledzenie wydajności i logów.
- **Bezpieczeństwo**: Ochrona danych i aplikacji.
- **CD**: Automatyzacja wdrażania aplikacji.

### Współpraca w DevOps:
- **Ciągła dostawa**: Od kodowania po wdrożenie.
- **Optymalizacja**: Usprawnianie procesów.
- **Rozwiązywanie problemów**: Szybka reakcja na wyzwania.
- **Innowacje**: Poszukiwanie nowych rozwiązań.

### Korzyści DevOps:
- **Szybsze dostarczanie**: Przyspieszenie cyklu wdrażania.
- **Większa stabilność**: Zmniejszenie liczby błędów.
- **Lepsza jakość produktu**: Poprawa jakości oprogramowania.
- **Większa efektywność**: Zwiększenie produktywności zespołów.
- **Zwiększona satysfakcja klienta**: Lepsze zaspokojenie potrzeb użytkowników.

## Wprowadzenie do Git

Git to narzędzie do wersjonowania kodu, które jest niezbędne w praktykach DevOps, umożliwiające efektywne zarządzanie kodem źródłowym.

### Kroki rozpoczęcia pracy z Git:

#### Instalacja Git:
Pobierz z:
```
https://git-scm.com/downloads
```
lub zainstaluj za pomocą:
```
winget install --id Git.Git -e --source winget
```

#### Konfiguracja Git:
Ustaw swoje dane użytkownika:
```
git config --global user.name "Twoje Imię"
git config --global user.email "twój.email@example.com"
```

#### Utworzenie repozytorium:
```
git init <nazwa-repozytorium>
```

#### Pierwszy commit:
Utwórz plik README.md i dodaj go do repozytorium:
```
echo "# 100 dni do DevOps" >> README.md
git add README.md
git commit -m "Dodaj README.md"
```

#### Pierwszy push:
Dodaj zdalne repozytorium i wypchnij zmiany:
```
git remote add origin <adres_repozytorium>
git push -u origin master
```

🎉 Gratulacje! Rozpocząłeś swoją podróż z Git i DevOps!
