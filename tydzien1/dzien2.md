# Tydzień 1: DevOps & Git 🚀

## Dzień 2: Środowiska Testowe i Automatyzacja 🖥️

### Wybór środowisk testowych
W dniu 2. "100 dni do DevOps" koncentrujemy się na wyborze odpowiednich środowisk testowych oraz automatyzacji zadań za pomocą skryptów Bash, co jest kluczowe dla efektywnego testowania i izolacji aplikacji.

### Dlaczego różnorodne środowiska testowe są ważne?
- **Izolacja**: Zapewniają bezpieczne środowisko do testowania aplikacji bez wpływu na produkcję.
- **Różnorodność**: Umożliwiają testowanie w różnych konfiguracjach, co zwiększa zaufanie do wdrożeń.
- **Automatyzacja**: Skrypty Bash umożliwiają szybkie i powtarzalne tworzenie środowisk testowych.

### Wybór narzędzi:
- **Proxmox 🖥️**: Platforma do wirtualizacji i zarządzania maszynami wirtualnymi.
- **Docker 🐳**: Narzędzie do konteneryzacji, które umożliwia izolację aplikacji.
- **Oracle Free Tier ☁️**: Dostęp do zasobów chmurowych dla dodatkowych testów i zasobów.

### Automatyzacja z Bash 🚀
#### Tworzenie skryptów Bash dla:
- **Cloud-init**: Szybkie tworzenie i konfiguracja VM w Proxmox.
- **Instalacja Dockera**: Automatyczne ustawienie Dockera na nowych maszynach.

### Zadania:

#### Proxmox 🖥️
- **VM Setup**: Utworzenie skryptu cloud-init dla szybkiego rozruchu VM.
- **Automatyzacja**: Skrypt `proxmox-vm-setup.sh` do tworzenia i konfiguracji VM.

#### Docker 🐳
- **Instalacja**: Skrypt `install-docker.sh` do automatycznego ustawienia Dockera.
- **Konfiguracja**: Ustawienie środowiska Docker dla izolacji aplikacji.

#### Oracle Free Tier ☁️
- **Konfiguracja chmury**: Utworzenie instancji i konfiguracja sieci w Oracle Cloud.
- **Integracja**: Skrypt `oracle-cloud-setup.sh` dla automatycznej konfiguracji.

### Kroki implementacji:

#### Proxmox VM Setup:
```
scripts/debian-ubuntu-cloudinit-proxmox-vm-setup.sh
```

#### Instalacja Dockera:
```
scripts/ubuntu-install-docker.sh
```

### Podsumowanie
Te narzędzia i skrypty pozwalają szybko przygotować środowisko do testowania i izolacji aplikacji, co jest kluczowe w procesie DevOps.

🎉 Gratulacje! Kolejny krok w Twojej podróży DevOps zakończony sukcesem!
