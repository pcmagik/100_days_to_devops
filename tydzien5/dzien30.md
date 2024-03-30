# Tydzień 5 - "Monitoring & Logging & Backup"

## Dzień 30: Monitoring dostępności z Uptime Kuma 🕒

### Wprowadzenie do Uptime Kuma
W dniu 30. naszej serii "100 dni do DevOps" skupiamy się na Uptime Kuma, narzędziu open source służącym do monitorowania dostępności serwisów. Jest to prosty, ale potężny sposób na śledzenie, czy nasze aplikacje i serwisy działają bez zakłóceń.

### Dlaczego Uptime Kuma?
- **Wszechstronność**: Monitorowanie HTTP(S), TCP, HTTP(s) Keywords, Ping, DNS Record, Push, Steam Game Server.
- **Powiadomienia**: Wsparcie dla wielu kanałów powiadomień, takich jak e-mail, Telegram, Discord i inne.
- **Użyteczność**: Łatwa w użyciu i konfiguracji, z przyjaznym interfejsem użytkownika.

### Konfiguracja:
````yaml
version: '3.3'
services:
  uptime-kuma:
    image: louislam/uptime-kuma:1
    container_name: uptime-kuma
    volumes:
      - /home/ubuntu/docker/uptime-kuma:/app/data
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    networks:
      proxy:
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.uptime-kuma.entrypoints=http"
      - "traefik.http.routers.uptime-kuma.rule=Host(`uptime-kuma.yourdomain.com`)"
      - "traefik.http.middlewares.uptime-kuma-https-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.uptime-kuma.middlewares=uptime-kuma-https-redirect"
      - "traefik.http.routers.uptime-kuma-secure.entrypoints=https"
      - "traefik.http.routers.uptime-kuma-secure.rule=Host(`uptime-kuma.yourdomain.com`)"
      - "traefik.http.routers.uptime-kuma-secure.tls=true"
      - "traefik.http.routers.uptime-kuma-secure.service=uptime-kuma"
      - "traefik.http.services.uptime-kuma.loadbalancer.server.port=3001"
      - "traefik.docker.network=proxy"

networks:
  proxy:
    external: true
````

### Podsumowanie
Uptime Kuma to doskonałe narzędzie do dodania do naszego zestawu narzędzi DevOps, umożliwiające proste i efektywne monitorowanie dostępności naszych serwisów i aplikacji.

