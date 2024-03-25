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