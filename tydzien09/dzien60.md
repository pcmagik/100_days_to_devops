# Tydzień 9: Packer & Proxmox

## Dzień 60: Zarządzanie maszynami wirtualnymi i kontenerami w Proxmox 🛠️

### Podnosimy poprzeczkę z Proxmox
W dniu 60. "100 dni do DevOps" skupiamy się na zaawansowanym zarządzaniu maszynami wirtualnymi (VM) i kontenerami przy użyciu Proxmox VE, potężnej platformy do wirtualizacji i konteneryzacji.

### Dlaczego Proxmox dla VM i kontenerów?
- **Wszechstronność**: Proxmox umożliwia zarówno wirtualizację opartą na KVM jak i konteneryzację z LXC.
- **Zarządzanie przez interfejs webowy**: Proxmox oferuje intuicyjne, graficzne środowisko zarządzania, które upraszcza zarządzanie zasobami.
- **Klastry i wysoka dostępność**: Możliwość budowania sklastrowanych rozwiązań z redundancją i migracją maszyn wirtualnych na żywo.

### Praktyczne zarządzanie w Proxmox:
1. **Tworzenie nowych maszyn wirtualnych**:
   - Użyj panelu Proxmox VE do szybkiego konfigurowania i uruchamiania nowych VM. Przykładowa komenda do tworzenia VM z CLI:
     ```bash
     qm create 100 --name myvm --memory 2048 --net0 virtio,bridge=vmbr0
     ```
   - Dodaj dysk twardy i zainstaluj system operacyjny:
     ```bash
     qm set 100 --ide2 local-lvm:iso/myiso.iso --bootdisk ide2 --boot c
     ```

2. **Konfiguracja i zarządzanie kontenerami LXC**:
   - Stwórz nowy kontener LXC za pomocą webowego interfejsu użytkownika Proxmox lub przez CLI:
     ```bash
     pct create 101 local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz --storage local-lvm --cores 2 --memory 2048 --swap 2048 --net0 name=eth0,bridge=vmbr0,ip=dhcp
     ```

3. **Implementacja backupów i strategii odzyskiwania**:
   - Skonfiguruj i zarządzaj backupami dla VM i kontenerów przy użyciu wbudowanych narzędzi Proxmox:
     ```bash
     vzdump 100 --mode snapshot --storage backupstorage
     ```

4. **Wykorzystanie funkcji klastrów Proxmox**:
   - Skonfiguruj klaster Proxmox, aby zwiększyć dostępność i umożliwić migrację maszyn wirtualnych między węzłami:
     ```bash
     pvecm add 192.168.1.2
     ```

### Podsumowanie
Proxmox VE jest kompleksowym rozwiązaniem, które znacząco ułatwia zarządzanie wirtualizacją i konteneryzacją, oferując elastyczne środowisko dla aplikacji i usług. Dzięki zaawansowanym funkcjom, takim jak klasterowanie, wysoka dostępność i skuteczne zarządzanie backupami, Proxmox VE jest idealnym wyborem dla każdego administratora systemu, który dąży do optymalizacji i automatyzacji swojej infrastruktury.

### Co dalej?
Zachęcam do eksperymentowania z różnymi funkcjami Proxmox VE, aby dostosować i zoptymalizować swoje środowisko wirtualne. Praktyczne wykorzystanie tych narzędzi pozwoli ci lepiej zrozumieć, jak maksymalnie wykorzystać potencjał tej platformy.
