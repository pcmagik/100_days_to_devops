## Dzień 5: Planowanie Struktury Laboratorium DevOps 🏗️

### Optymalizacja naszego laboratorium DevOps! 🛠️

Z uwzględnieniem naszego głównego serwera **Ryzen 7 5700X** z **128GB RAM** i **2TB m.2 NVMe SSD** w RAID 0, dostosowujemy wymagania sprzętowe do bardziej realistycznych potrzeb.

### VM Serwer Zarządzania:
- **Zastosowanie**: Centralne zarządzanie narzędziami DevOps.
- **Specyfikacja**: 8 rdzeni CPU, 8 GB RAM, 128 GB SSD.

### VM Klastry Kontenerów - Kubernetes:
- **Węzeł Menedżera**: 3x (2 rdzenie CPU, 8 GB RAM, 64 GB SSD.)
- **Węzły Pracownicze**: 3x (2 rdzenie CPU, 4 GB RAM, 64 GB SSD).

### VM Serwery Baz Danych:
- Zintegrowane z serwerem docker.
- **Specyfikacja**: 4 rdzeni CPU, 8 GB RAM, 64 GB SSD.

### VM Serwer CI/CD:
- **Zastosowanie**: Automatyzacja procesów CI/CD, wykorzystując główny serwer.
- **Specyfikacja**: 4 rdzenie CPU, 8 GB RAM, 64 GB SSD.

### VM Monitoring i Logowanie:
- Zintegrowane z serwerem docker.

### Backup:
- **Proxmox Backup Server**: Dedykowana jednostka.
- **Specyfikacja**: 4 rdzenie CPU, 8 GB RAM, 500 GB SSD RAID 1.

### Storage:
- **TrueNAS**: Osobna jednostka.
- **Specyfikacja**: 4 rdzenie CPU, 8 GB RAM, 500 GB SSD RAID 1.

### Sieć i Bezpieczeństwo 🔒:
- **VLANy**: HOME (10), IoT (20), GUEST (30), SERWIS (40), HackLab (50).
- **VPN**: Tailscale i WireGuard na OPNsense.
- **Przełącznik**: Ubiquiti USW PRO.

Struktura ta zapewnia elastyczność, bezpieczeństwo i wydajność, przy jednoczesnym minimalizmie zasobów. 🌟
