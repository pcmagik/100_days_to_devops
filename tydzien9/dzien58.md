# Tydzień 9: Packer & Proxmox

## Dzień 58: Budowanie obrazów maszyn wirtualnych z Packer 🖥️

### Zanurzenie w budowanie obrazów VM
W dniu 58. naszej serii "100 dni do DevOps" skupiamy się na praktycznym zastosowaniu Packera do budowania spersonalizowanych obrazów maszyn wirtualnych. Dzięki Packer, można szybko przygotować i skalować infrastrukturę, zwiększając efektywność operacji IT.

### Korzyści z budowania obrazów VM z Packer:
- **Spójność**: Packer zapewnia spójność konfiguracji, eliminując różnice między środowiskami dzięki jednolitym obrazom.
- **Przenośność**: Obrazy przygotowane przez Packer można łatwo przenosić i wdrażać na różnych platformach i hipernadzorcach, takich jak AWS, VMware, Azure, czy Proxmox.
- **Optymalizacja**: Skrócenie czasu potrzebnego na konfigurację i wdrażanie nowych instancji VM dzięki automatycznemu procesowi budowania.

### Krok po kroku budowanie obrazów VM:
1. **Przygotowanie szablonu Packera**:
   Utwórz szablon Packer, który definiuje system operacyjny, oprogramowanie oraz zależności, które mają być zainstalowane na maszynie wirtualnej.

    ```hcl
    source "qemu" "example" {
      accelerator = "kvm"
      disk_size   = 10000
      format      = "qcow2"
      http_directory = "http"
      iso_checksum  = "md5:xxxxxxxxxxxx"
      iso_url       = "http://releases.ubuntu.com/20.04/ubuntu-20.04.1-live-server-amd64.iso"
      ssh_username  = "ubuntu"
    }

    build {
      sources = ["source.qemu.example"]

      provisioner "shell" {
        inline = [
          "sleep 30",
          "sudo apt-get update",
          "sudo apt-get install -y nginx"
        ]
      }
    }
    ```

2. **Budowanie obrazu**:
   Uruchom proces budowania za pomocą Packer, który automatycznie skonfiguruje system, zainstaluje potrzebne oprogramowanie i przygotuje obraz do użycia.

    ```bash
    packer build template.pkr.hcl
    ```

3. **Testowanie obrazu**:
   Przed wdrożeniem obrazu w produkcji, przetestuj go w izolowanym środowisku, aby upewnić się, że wszystkie składniki działają prawidłowo.

### Podsumowanie
Packer jest nieocenionym narzędziem w arsenale każdego inżyniera DevOps, które znacznie upraszcza i przyspiesza proces przygotowania obrazów maszyn wirtualnych. Umożliwia on szybkie wdrażanie gotowych do użytku, spójnych i optymalnie skonfigurowanych środowisk, co jest kluczowe dla efektywnego zarządzania infrastrukturą wirtualną.

### Co dalej?
Zachęcamy do eksplorowania zaawansowanych opcji konfiguracji Packera i integracji z różnymi narzędziami automatyzacji, takimi jak Ansible, Chef, lub Puppet, co może dalej zoptymalizować i usprawnić procesy wdrażania.
