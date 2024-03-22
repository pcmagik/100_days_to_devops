# Tydzień 4 - "Budowanie Bezpiecznej Infrastruktury z Dockerem"

## Dzień 22: Wdrażanie Nextcloud 🌥️

### Wprowadzenie do Nextcloud
Dzień 22. w naszej serii "100 dni do DevOps" poświęcamy na **Nextcloud** - platformę do przechowywania i udostępniania plików, która stanowi świetną alternatywę dla komercyjnych usług chmurowych. Nextcloud zapewnia kontrolę nad danymi, integrację z istniejącymi narzędziami oraz elastyczność w zarządzaniu zasobami.

### Dlaczego Nextcloud?
- **Prywatność i kontrola**: Pełna kontrola nad danymi bez zależności od zewnętrznych dostawców chmury.
- **Elastyczność**: Łatwa integracja z innymi usługami i narzędziami DevOps.
- **Współpraca**: Narzędzia do współpracy i komunikacji zespołowej w ramach platformy.

### Konfiguracja Nextcloud:
```yaml
version: "2.1"
services:
  nextcloud:
    image: lscr.io/linuxserver/nextcloud:latest
    container_name: nextcloud
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
    volumes:
      - /home/ubuntu/docker/nextcloud/appdata:/config
      - /home/ubuntu/docker/nextcloud/data:/data
    # ports:
    #  - 443:443
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.nextcloud.entrypoints=http"
      - "traefik.http.routers.nextcloud.rule=Host(`nextcloud.jimsgarage.co.uk`)"
      - "traefik.http.middlewares.nextcloud-https-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.nextcloud.middlewares=nextcloud-https-redirect"
      - "traefik.http.routers.nextcloud-secure.entrypoints=https"
      - "traefik.http.routers.nextcloud-secure.rule=Host(`nextcloud.jimsgarage.co.uk`)"
      - "traefik.http.routers.nextcloud-secure.tls=true"
      - "traefik.http.routers.nextcloud-secure.service=nextcloud"
      - "traefik.http.services.nextcloud.loadbalancer.server.port=80"
      - "traefik.docker.network=proxy"
    networks:
      proxy:

networks:
  proxy:
    external: true
```

### Podsumowanie
Nextcloud to doskonałe rozwiązanie dla zespołów DevOps szukających bezpiecznej i elastycznej platformy do przechowywania danych, która wspiera współpracę i integrację z innymi narzędziami.

