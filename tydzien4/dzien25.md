# Tydzień 4 - "Budowanie Bezpiecznej Infrastruktury z Dockerem"

## Dzień 25: Wprowadzenie do Authelia 🛡️

### Wprowadzenie do Authelia
Dzień 25. naszej podróży przez "100 dni do DevOps" poświęcamy na **Authelia**, narzędzie do jednolitego uwierzytelniania i autoryzacji, zapewniające warstwę bezpieczeństwa dla aplikacji i usług webowych. Authelia pozwala na łatwą implementację uwierzytelniania dwuskładnikowego, Single Sign-On (SSO) oraz zaawansowanej kontroli dostępu.

### Dlaczego Authelia?
- **Bezpieczeństwo**: Wzmocnione uwierzytelnianie dwuskładnikowe i Single Sign-On.
- **Elastyczność**: Możliwość dostosowania do różnych środowisk i stosów technologicznych.
- **Kontrola dostępu**: Zaawansowane zarządzanie dostępem do aplikacji i danych.

### Konfiguracja Authelia:
```yaml
version: '3'

services:
  authelia:
    image: authelia/authelia
    container_name: authelia
    volumes:
      - /home/ubuntu/docker/authelia/config:/config
    networks:
      - proxy
    security_opt:
      - no-new-privileges:true
    labels:
      - 'traefik.enable=true'
      - 'traefik.http.routers.authelia.rule=Host(`auth.jimsgarage.co.uk`)'
      - 'traefik.http.routers.authelia.entrypoints=https'
      - 'traefik.http.routers.authelia.tls=true'
      - 'traefik.http.middlewares.authelia.forwardAuth.address=http://authelia:9091/api/verify?rd=https://auth.jimsgarage.co.uk'
      - 'traefik.http.middlewares.authelia.forwardAuth.trustForwardHeader=true'
      - 'traefik.http.middlewares.authelia.forwardAuth.authResponseHeaders=Remote-User,Remote-Groups,Remote-Name,Remote-Email'
      - 'traefik.http.middlewares.authelia-basic.forwardAuth.address=http://authelia:9091/api/verify?auth=basic'
      - 'traefik.http.middlewares.authelia-basic.forwardAuth.trustForwardHeader=true'
      - 'traefik.http.middlewares.authelia-basic.forwardAuth.authResponseHeaders=Remote-User,Remote-Groups,Remote-Name,Remote-Email'
      - 'traefik.http.services.authelia.loadbalancer.server.port=9091'
    ports:
      - 9091:9091
    restart: unless-stopped
    environment:
      - TZ=Europe/London
    healthcheck:
      disable: true

  redis:
    image: redis:alpine
    container_name: redis
    volumes:
      - /home/ubuntu/docker/redis:/data
    networks:
      - proxy
    expose:
      - 6379
    restart: unless-stopped
    environment:
      - TZ=Europe/London


networks:
  proxy:
    external: true
```

### Podsumowanie
Authelia to kluczowe narzędzie do ochrony Twoich aplikacji i usług webowych, zapewniające silne uwierzytelnianie i elastyczną kontrolę dostępu.

