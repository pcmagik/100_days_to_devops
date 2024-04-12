# Tydzień 7: Github Actions

## Dzień 43: Wprowadzenie do GitHub Actions 🚀

### Co to jest GitHub Actions?
GitHub Actions to zaawansowane narzędzie do automatyzacji wszystkich etapów tworzenia oprogramowania bezpośrednio w GitHubie. Umożliwia implementację Continuous Integration (CI) i Continuous Delivery (CD) z minimalnym wysiłkiem, umożliwiając automatyczne testowanie, budowanie, pakowanie, a także wdrażanie aplikacji.

### Dlaczego warto używać GitHub Actions?
- **Zintegrowane środowisko**: Dzięki bezpośredniej integracji z GitHubem, GitHub Actions ułatwia automatyzację procesów bez potrzeby korzystania z zewnętrznych narzędzi.
- **Elastyczność i dostosowanie**: Możliwość tworzenia złożonych procesów (workflowów) z użyciem języka YAML, co pozwala na precyzyjne dopasowanie do potrzeb projektu.
- **Społeczność i gotowe rozwiązania**: Dostęp do setek akcji udostępnionych przez społeczność, które można łatwo zintegrować z własnymi projektami.

### Jak zacząć z GitHub Actions?
1. **Tworzenie pierwszego workflow**: Utwórz plik `.github/workflows/main.yml` w swoim repozytorium. Może on wyglądać tak:

~~~yaml
name: Przykładowy Workflow

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Uruchom skrypt
      run: echo "GitHub Actions działa!"
~~~

2. **Konfiguracja zdarzeń wyzwalających**: Workflow można skonfigurować tak, aby uruchamiał się na różne zdarzenia, np. `push` lub `pull request` do określonych gałęzi. Przykład powyżej uruchamia się przy każdym `pushu`.

3. **Monitoring i analiza**: GitHub Actions oferuje zintegrowane narzędzia do monitorowania i analizy wykonania akcji, dostępne bezpośrednio z poziomu GitHuba.

### Automatyczna aktualizacja spisu treści przy użyciu GitHub Actions i Pythona
Jeśli często dodajesz nowe treści do swojego repozytorium, warto zautomatyzować proces aktualizacji spisu treści. Oto prosty skrypt Pythona, który możesz uruchomić jako część swojego workflow:

~~~python
import os
import re

# Lokalizacja bazowa, w której znajdują się foldery 'tydzienY'
base_folder_path = os.getcwd()

# Ścieżka do pliku README.md
readme_path = os.path.join(base_folder_path, 'README.md')

# Zmienna do przechowywania nowo wygenerowanego spisu treści
generated_toc = "\n\n## Spis treści\n\n"

# Regex do wyszukiwania tematów dni
pattern = re.compile(r'^## Dzień (\d+): (.*)')

# Słownik do przechowywania wpisów tematów z numerami dni jako kluczami
topics_dict = {}

# Przeszukiwanie folderów 'tydzienY' w poszukiwaniu plików 'dzienX.md'
for tydzien_num in range(1, 16):  # 15 tygodni, z czego ostatni ma 2 dni
    tydzien_folder_name = f"tydzien{tydzien_num}"
    tydzien_folder_path = os.path.join(base_folder_path, tydzien_folder_name)
    
    dni_w_tygodniu = 7 if tydzien_num < 15 else 2  # Dla tygodnia 15, sprawdzamy tylko 2 dni
    for dzien_num in range(1, dni_w_tygodniu + 1):
        dzien_file_name = f"dzien{dzien_num + (tydzien_num - 1) * 7}.md"
        dzien_file_path = os.path.join(tydzien_folder_path, dzien_file_name)

        if os.path.isfile(dzien_file_path):
            with open(dzien_file_path, 'r', encoding='utf-8') as dzien_file:
                for line in dzien_file:
                    match = pattern.match(line)
                    if match:
                        day_number = int(match.group(1))
                        topic = match.group(2).strip()
                        # Utworzenie linku względnego do pliku dzienX.md
                        relative_path = os.path.join(tydzien_folder_name, dzien_file_name)
                        link = f"[Dzień {day_number}: {topic}]({relative_path})"
                        topics_dict[day_number] = f"{link}\n"

# Dodanie posortowanych tematów do wygenerowanego spisu treści
for day_number in sorted(topics_dict):
    generated_toc += topics_dict[day_number] + "\n"

# Odczytanie istniejącego README.md i podmiana wygenerowanego spisu treści
with open(readme_path, 'r', encoding='utf-8') as readme_file:
    content = readme_file.read()

# Wyszukanie znaczników spisu treści i ich indeksów
toc_start = content.find("<!-- spis_tresci_start -->")
toc_end = content.find("<!-- spis_tresci_end -->")

# Zabezpieczenie przed sytuacją, gdy znaczniki nie zostaną znalezione
if toc_start != -1 and toc_end != -1:
    # Wygenerowanie nowej zawartości README.md
    new_content = content[:toc_start + len("<!-- spis_tresci_start -->")] + generated_toc + "\n" + content[toc_end:]
else:
    # Jeśli znaczniki nie zostaną znalezione, po prostu dołączamy spis na końcu pliku
    new_content = content + generated_toc

# Zapisanie nowej zawartości do README.md
with open(readme_path, 'w', encoding='utf-8') as readme_file:
    readme_file.write(new_content)
~~~

Dodaj powyższy skrypt do swojego repozytorium i zaktualizuj workflow, aby uruchamiał ten skrypt przy każdym commicie. Oto przykład, jak można to zrobić:

~~~yaml
name: Update README

on:
  push:
    branches:
      - main

permissions:
  contents: write  # Uprawnienia umożliwiające zapis do repozytorium

jobs:
  update-readme:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          persist-credentials: false  # Uniknięcie potencjalnych problemów z domyślnym GITHUB_TOKEN

      - name: Setup Python
        uses: actions/setup-python@v3
        with:
          python-version: '3.x'

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install GitPython

      - name: Update README
        run: |
          python update_readme.py

      - name: Configure Git
        run: |
          git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
          git config --local user.name "github-actions[bot]"
          git remote set-url origin https://x-access-token:${{ secrets.GITHUB_TOKEN }}@github.com/${{ github.repository }}

      - name: Commit changes
        run: |
          git add README.md
          git commit -m "Aktualizacja README" || echo "No changes to commit"

      - name: Push changes
        run: git push origin HEAD:main

~~~

### Podsumowanie
GitHub Actions oferuje szerokie możliwości automatyzacji procesów CI/CD, znacznie upraszczając życie zespołów developerskich. Dzięki łatwej integracji z GitHubem i wsparciu społeczności, można szybko wprowadzać zaawansowane workflowy, przyspieszając rozwój projektu. Dodatkowo, wykorzystanie prostych skryptów, jak pokazany przykład z Pythonem, może dalej zautomatyzować i ulepszyć procesy pracy z kodem.
