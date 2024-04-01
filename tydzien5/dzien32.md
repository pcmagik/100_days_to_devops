# Tydzień 5 - "Monitoring & Logging & Backup"

## Dzień 32: Automatyczne aktualizacje z Watchtower 🔄

### Wprowadzenie do Watchtower
W 32. dniu naszej serii "100 dni do DevOps" skupiamy się na **Watchtower**, narzędziu, które automatycznie aktualizuje obrazy Docker, uruchomione kontenery oraz usługi w środowisku Docker. Watchtower monitoruje uruchomione kontenery i ich obrazy w poszukiwaniu zmian, a następnie automatycznie aktualizuje je do najnowszych wersji, zapewniając, że nasze środowisko jest zawsze aktualne i bezpieczne.

### Dlaczego Watchtower?
- **Automatyzacja**: Automatyczne aktualizacje kontenerów bez konieczności manualnej interwencji.
- **Bezpieczeństwo**: Szybkie wdrażanie aktualizacji bezpieczeństwa.
- **Łatwość w zarządzaniu**: Utrzymywanie aktualnego i czystego środowiska pracy.

### Konfiguracja Watchtower:
```yaml
version: '3.8'
services:
  watchtower:
    image: containrrr/watchtower
    container_name: watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped
    networks:
      - proxy

networks:
  proxy:
    external: true
```

### Podsumowanie
Watchtower to nieocenione narzędzie dla każdego, kto chce automatyzować proces aktualizacji w środowiskach Docker, minimalizując ryzyko i zwiększając efektywność operacyjną.

