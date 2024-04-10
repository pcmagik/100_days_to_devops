# Tydzień 6: Security

## Dzień 39: Przegląd podatności i narzędzi do ich wykrywania 🕵️‍♂️

### Wprowadzenie do praktycznego zastosowania narzędzi
W dniu 39. naszej podróży "100 dni do DevOps", skupiamy się na bezpośrednim zastosowaniu narzędzi do identyfikacji podatności. Przyjrzymy się, jak przy użyciu konkretnych komend można efektywnie wykorzystać popularne narzędzia do wykrywania i zarządzania podatnościami w infrastrukturze IT.

### Dlaczego identyfikacja podatności jest ważna?
- **Minimalizacja ryzyka**: Wczesne wykrywanie podatności pozwala na ich szybką naprawę, zanim zostaną wykorzystane przez atakujących.
- **Zgodność z regulacjami**: Wiele standardów i przepisów wymaga regularnych kontroli bezpieczeństwa i zarządzania podatnościami.
- **Utrzymanie zaufania użytkowników**: Zapewnienie, że systemy i aplikacje są bezpieczne, buduje zaufanie klientów i użytkowników.

### Narzędzia do wykrywania podatności:
- **Skanery podatności**: Narzędzia takie jak Nessus, OpenVAS, i Qualys pomagają w automatycznym wykrywaniu znanych podatności.
- **Analiza kodu źródłowego**: Narzędzia takie jak SonarQube i Fortify analizują kod pod kątem potencjalnych podatności.
- **Dynamiczne testy aplikacji**: Narzędzia takie jak OWASP ZAP i Burp Suite umożliwiają testowanie aplikacji webowych pod kątem podatności w czasie rzeczywistym.


### Skanery podatności

#### Nessus
- **Instalacja**: Najpierw pobierz i zainstaluj Nessus z oficjalnej strony. Po zakończeniu instalacji uruchom serwis Nessus.
- **Uruchomienie skanu**: Aby rozpocząć, zaloguj się do interfejsu webowego Nessus za pomocą przeglądarki, następnie stwórz nowe zadanie skanowania, wybierając odpowiedni profil. Użyj poniższej komendy do rozpoczęcia skanu:
```bash
nessuscli scan new --name "Nazwa Twojego Skanu" --targets 192.168.1.1
```

#### OpenVAS
- **Instalacja**: OpenVAS jest częścią większego pakietu o nazwie GVM. Zainstaluj GVM za pomocą menedżera pakietów swojego systemu.
- **Uruchomienie skanu**: Po instalacji i konfiguracji GVM, uruchom OpenVAS Scanner i Greenbone Security Assistant. Następnie, przez interfejs webowy, dodaj nowe zadanie skanowania, wskazując cel i typ skanowania.

### Analiza kodu źródłowego

#### SonarQube
- **Instalacja**: Pobierz SonarQube z oficjalnej strony i rozpakuj archiwum. Uruchom SonarQube za pomocą skryptu `StartSonar`.
- **Analiza projektu**: Aby przeskanować projekt, musisz najpierw zainstalować odpowiedniego skanera dla swojego środowiska programistycznego. Dla projektu Maven użyj komendy:
```
  mvn sonar:sonar -Dsonar.projectKey=NazwaProjektu -Dsonar.host.url=http://localhost:9000 -Dsonar.login=admin -Dsonar.password=twoje_haslo
```

#### Fortify
- **Instalacja**: Fortify jest komercyjnym produktem, więc po zakupie licencji pobierz i zainstaluj oprogramowanie zgodnie z instrukcją dostawcy.
- **Analiza projektu**: Użyj poniższej komendy do przeskanowania kodu źródłowego aplikacji Java:
```
sourceanalyzer -b NazwaProjektu -clean -scan -f wynikFPR.fpr
```

### Dynamiczne testy aplikacji

#### OWASP ZAP
- **Instalacja**: Pobierz i zainstaluj OWASP ZAP z oficjalnej strony.
- **Uruchomienie skanu**: Możesz rozpocząć skanowanie z linii komend używając:
```bash
  zap-cli -p 8090 start
  zap-cli -p 8090 open-url http://adres.twojej.aplikacji
  zap-cli -p 8090 spider http://adres.twojej.aplikacji
  zap-cli -p 8090 active-scan http://adres.twojej.aplikacji
  zap-cli -p 8090 alerts
```

#### Burp Suite
- **Instalacja**: Pobierz i zainstaluj Burp Suite z oficjalnej strony.
- **Uruchomienie skanu**: Po uruchomieniu Burp Suite, skonfiguruj przeglądarkę do pracy z lokalnym serwerem proxy Burp. Następnie, w sekcji "Proxy" -> "Intercept" włącz przechwytywanie, aby rozpocząć monitorowanie ruchu z aplikacji webowej.

### Podsumowanie
Zaprezentowane przykłady komend dają podstawowy wgląd w to, jak można wykorzystać różnorodne narzędzia do wykrywania podatności w różnych aspektach infrastruktury IT i kodu aplikacji. Pamiętaj, że dla osiągnięcia najlepszych wyników, kluczowe jest regularne stosowanie tych narzędzi, dostosowywanie ustawień do specyficznych potrzeb środowiska oraz ciągła aktualizacja wiedzy na temat nowych zagrożeń i technik obrony.