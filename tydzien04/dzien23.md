# Tydzień 4 - "Budowanie Bezpiecznej Infrastruktury z Dockerem"

## Dzień 23: Integracja z Tailscale 🌐

### Wprowadzenie do Tailscale
W dniu 23. naszej serii "100 dni do DevOps" skupiamy się na **Tailscale** - sieci VPN opartej na WireGuard, która umożliwia łatwą i bezpieczną komunikację między urządzeniami. Tailscale upraszcza proces tworzenia bezpiecznych sieci VPN, co jest kluczowe dla zespołów rozproszonych i zdalnych środowisk pracy.

### Dlaczego Tailscale?
- **Szybka konfiguracja**: Tailscale można skonfigurować w ciągu kilku minut, bez potrzeby skomplikowanej konfiguracji sieci.
- **Automatyczne szyfrowanie**: Wszystkie połączenia są automatycznie szyfrowane za pomocą WireGuard.
- **Łatwa skalowalność**: Tailscale umożliwia łatwe dodawanie nowych urządzeń do sieci.

### Konfiguracja Tailscale:
```yaml
version: "3.7"
services:
  tailscale-nginx:
    image: tailscale/tailscale:latest
    hostname: tailscale-nginx
    environment:
      - TS_AUTHKEY=tskey-client-notAReal-OAuthClientSecret1Atawk
      - TS_EXTRA_ARGS=--advertise-tags=tag:container
      - TS_STATE_DIR=/var/lib/tailscale
      - TS_USERSPACE=false
    volumes:
      - ${PWD}/tailscale-nginx/state:/var/lib/tailscale
      - /dev/net/tun:/dev/net/tun
    cap_add:
      - net_admin
      - sys_module
    restart: unless-stopped
  nginx:
    image: nginx
    depends_on:
      - tailscale-nginx
    network_mode: service:tailscale-nginx```
```
### Podsumowanie
Tailscale to potężne narzędzie dla każdego inżyniera DevOps, które upraszcza budowanie bezpiecznych sieci VPN, niezbędnych w dzisiejszych zdecentralizowanych i zdalnych środowiskach pracy.

