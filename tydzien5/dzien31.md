# Tydzień 5 - "Monitoring & Logging & Backup"

## Dzień 31: Powiadomienia z Gotify 📲

### Wprowadzenie do Gotify
W 31. dniu serii "100 dni do DevOps" przyglądamy się **Gotify**, prostemu serwerowi i klientowi do wysyłania i odbierania powiadomień za pośrednictwem HTTP. Gotify umożliwia deweloperom i zespołom DevOps łatwe wdrożenie systemu powiadomień, co jest nieocenione dla monitorowania stanu aplikacji i infrastruktury.

### Dlaczego Gotify?
- **Prostota**: Łatwa konfiguracja i zarządzanie.
- **Elastyczność**: Możliwość integracji z różnymi systemami i aplikacjami.
- **Real-time**: Natychmiastowe dostarczanie powiadomień.

### Konfiguracja Gotify:
```yaml
version: '3.3'
services:
  gotify:
    image: gotify/server
    container_name: gotify
    volumes:
      - /home/ubuntu/docker/gotify:/app/data
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    networks:
      proxy:
    environment:
      - TZ=Europe/London
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.gotify.entrypoints=http"
      - "traefik.http.routers.gotify.rule=Host(`gotify.yourdomain.com`)"
      - "traefik.http.middlewares.gotify-https-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.gotify.middlewares=gotify-https-redirect"
      - "traefik.http.routers.gotify-secure.entrypoints=https"
      - "traefik.http.routers.gotify-secure.rule=Host(`gotify.yourdomain.com`)"
      - "traefik.http.routers.gotify-secure.tls=true"
      - "traefik.http.routers.gotify-secure.service=gotify"
      - "traefik.http.services.gotify.loadbalancer.server.port=80"
      - "traefik.docker.network=proxy"

networks:
  proxy:
    external: true
```

### Podsumowanie
Gotify to świetne narzędzie do zarządzania powiadomieniami w ekosystemie DevOps, zapewniające szybką informację zwrotną o ważnych zdarzeniach w systemie.

