# Tydzień 7: Github Actions

## Dzień 47: Lokalne testy GitHub Actions z Act 🛠️

### Wprowadzenie do Act
Dzisiaj, w 47. dniu naszej serii "100 dni do DevOps", eksplorujemy **Act**, narzędzie umożliwiające lokalne testowanie i debugowanie GitHub Actions na Twoim komputerze, bez potrzeby wysyłania zmian do repozytorium na GitHubie. Act symuluje środowisko GitHub Actions, co pozwala na szybsze cykle iteracji i oszczędność czasu.

### Dlaczego lokalne testowanie GitHub Actions jest ważne?
- **Szybkość**: Dzięki lokalnemu testowaniu, można znacząco przyspieszyć proces tworzenia i debugowania GitHub Actions.
- **Efektywność**: Zmniejsza to potrzebę tworzenia wielu testowych commitów oraz uruchamiania workflow na GitHubie, co jest korzystne zarówno dla wydajności, jak i kosztów.
- **Rozwój**: Act umożliwia łatwe eksperymentowanie i testowanie różnych konfiguracji i scenariuszy w kontrolowanym, lokalnym środowisku.

### Jak rozpocząć z Act?
1. **Instalacja**: Act można zainstalować na większości systemów operacyjnych. W zależności od Twojej platformy, proces instalacji może się nieznacznie różnić.
- **Na systemach macOS**:
  ~~~bash
  brew install act
  ~~~
- **Na Windows** (z użyciem Chocolatey):
  ~~~bash
  choco install act-cli
  ~~~
- **Na Linuxie**:
  ~~~bash
  # Instalacja za pomocą skryptu
  sudo curl -sL https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
  ~~~


2. **Konfiguracja**: Aby używać Act, musisz mieć plik `workflow.yml` w katalogu `.github/workflows` swojego repozytorium. Act użyje tych plików do symulacji GitHub Actions.
3. **Uruchamianie**: Aby uruchomić Act, otwórz terminal w katalogu projektu i wpisz `act`. Możesz przekazać różne opcje, aby symulować specyficzne zachowania, np. `act -j nazwa_joba` uruchomi tylko określone joby.

### Źródła i dodatkowe materiały:
- Oficjalna strona Act: [Act GitHub](https://github.com/nektos/act)
- Dokumentacja Act: [Dokumentacja Act](https://github.com/nektos/act#readme)
- Przykłady użycia Act w projektach: [Act w użyciu](https://github.com/nektos/act#examples)

### Podsumowanie
Act jest nieocenionym narzędziem dla deweloperów i specjalistów DevOps, które umożliwia efektywne tworzenie, testowanie i debugowanie GitHub Actions bezpośrednio na lokalnym komputerze. Dzięki Act, można znacząco skrócić czas potrzebny na rozwój i utrzymanie skomplikowanych workflow.
