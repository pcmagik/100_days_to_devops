# Tydzień 4 - "Budowanie Bezpiecznej Infrastruktury z Dockerem"

## Dzień 26: Tworzenie własnego Dashboardu 📊

### Wprowadzenie do Dashboardów
Dzień 26. naszej serii "100 dni do DevOps" poświęcamy na tworzenie **własnych dashboardów**. Dashboardy są kluczowym narzędziem dla DevOps, pozwalającym na monitorowanie kluczowych wskaźników wydajności (KPIs), stanu systemów i usług w czasie rzeczywistym.

### Dlaczego Dashboardy?
- **Przejrzystość**: Zapewniają natychmiastowy wgląd w stan infrastruktury i aplikacji.
- **Reaktywność**: Umożliwiają szybką reakcję na potencjalne problemy lub anomalie.
- **Dostosowanie**: Można je łatwo dostosować do specyficznych potrzeb i preferencji zespołu.

### Tworzenie Dashboardu:
docker-compose.yaml
```yaml
version: "3.3"
services:
  homepage:
    image: ghcr.io/benphelps/homepage:latest
    container_name: homepage
    # uncomment if you do not want to run as root
    #user: 1000:1000
    # uncomment if you are not using a reverse proxy
    #ports:
    #  - 3000:3000
    volumes:
      - /home/ubuntu/docker/homepage/config:/app/config # Make sure your local config directory exists
      - /var/run/docker.sock:/var/run/docker.sock # (optional) For docker integrations
    networks:
      proxy:
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.homepage.entrypoints=http"
      - "traefik.http.routers.homepage.rule=Host(`homepage.jimsgarage.co.uk`)"
      - "traefik.http.routers.homepage.middlewares=default-whitelist@file"
      - "traefik.http.middlewares.homepage-https-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.homepage.middlewares=homepage-https-redirect"
      - "traefik.http.routers.homepage-secure.entrypoints=https"
      - "traefik.http.routers.homepage-secure.rule=Host(`homepage.jimsgarage.co.uk`)"
      - "traefik.http.routers.homepage-secure.tls=true"
      - "traefik.http.routers.homepage-secure.service=homepage"
      - "traefik.http.services.homepage.loadbalancer.server.port=3000"
     # - "traefik.http.routers.homepage-secure.middlewares=default-whitelist@file" # uncomment if you want to use a Traefik whitelist to restrict access
     # - "traefik.http.routers.homepage-secure.middlewares=authelia@docker" # uncomment if you want to use authelia
     # - "traefik.docker.network=proxy"
    security_opt:
      - no-new-privileges:true

networks:
  proxy:
    external: true
```


services.yaml
```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/en/configs/services

- My First Group:
    - My First Service:
        href: http://localhost/
        description: Homepage is awesome

    - Traefik:
        icon: traefik.png
        href: "http://traefik.jimsgarage.co.uk"
        description: Reverse Proxy
        server: my-docker # The docker server that was configured
        container: traefik # The name of the container you'd like to connect
        widget:
          type: traefik
          url: https://traefik.jimsgarage.co.uk
          username: admin
          password: gT8ni3iX6QkKreWfAdYKe4xqVsaMRUQ4GG7xn59Q

    - PiHole:
        icon: pi-hole.png
        href: "http://pihole.jimsgarage.co.uk"
        description: DNS Ad Blocker
        server: my-docker # The docker server that was configured
        container: pihole # The name of the container you'd like to connect
        widget:
          type: pihole
          url: http://192.168.8.2
          key: 73T8oBs9MFKLVAC3mAs2KQbWSsqA7oe2PN9r9H4TQWg2TXNAdq4ZPzvy8oEv

- My Second Group:
    - My Second Service:
        href: http://localhost/
        description: Homepage is the best

- My Third Group:
    - My Third Service:
        href: http://localhost/
        description: Homepage is 😎
```

### Podsumowanie
Własne dashboardy to potężne narzędzie w rękach zespołu DevOps, umożliwiające efektywne monitorowanie i zarządzanie infrastrukturą IT.

