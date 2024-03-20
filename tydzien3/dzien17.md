# Tydzień 3 - "Zaawansowane Homelab i Zarządzanie Usługami" 🚀

## Dzień 17: Wprowadzenie do CrowdSec dla Zwiększenia Bezpieczeństwa Infrastruktury 🛡️

### Co to jest CrowdSec i Jak Działa? 🔍

W dniu siedemnastym naszej serii "100 dni do DevOps", skupiamy się na CrowdSec - nowoczesnym systemie wykrywania intruzów i odpowiedzi, który wykorzystuje podejście społecznościowe do identyfikacji i blokowania zagrożeń w czasie rzeczywistym.

### Dlaczego CrowdSec? 🌍

CrowdSec wykorzystuje siłę społeczności do szybkiej identyfikacji nowych zagrożeń i udostępnia te informacje wszystkim użytkownikom systemu, umożliwiając proaktywną ochronę.

### Konfiguracja CrowdSec z Dockerem i Traefikiem: 🔄

Wprowadzamy CrowdSec jako dodatkową warstwę bezpieczeństwa dla naszych aplikacji webowych, korzystając z Traefika jako reverse proxy.

### Przykładowy plik `docker-compose.yml`:

```yaml
version: '3.8'
services:
  crowdsec:
    image: crowdsecurity/crowdsec:latest
    container_name: crowdsec
    environment:
      GID: "${GID-1000}"
      COLLECTIONS: "crowdsecurity/linux crowdsecurity/traefik"
    volumes:
      - /home/ubuntu/docker/crowdsec/acquis.yaml:/etc/crowdsec/acquis.yaml
      - /home/ubuntu/docker/crowdsec/db:/var/lib/crowdsec/data/
      - /home/ubuntu/docker/crowdsec/config:/etc/crowdsec/
      - /home/ubuntu/docker/traefik/logs:/var/log/traefik/:ro
    networks:
      - proxy
    security_opt:
      - no-new-privileges:true
    restart: unless-stopped

  bouncer-traefik:
    image: docker.io/fbonalair/traefik-crowdsec-bouncer:latest
    container_name: bouncer-traefik
    environment:
      CROWDSEC_BOUNCER_API_KEY: create_a_random_api_key
      CROWDSEC_AGENT_HOST: crowdsec:8080
    networks:
      - proxy
    depends_on:
      - crowdsec
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
networks:
  proxy:
    external: true
```

### Uwagi Końcowe i Wskazówki:

- Po uruchomieniu CrowdSec zacznie analizować logi w poszukiwaniu podejrzanych aktywności, takich jak próby brute force czy skanowanie podatności.
- CrowdSec dynamicznie aktualizuje zasady za pośrednictwem bouncera, blokując ruch od zidentyfikowanych zagrożeń.
- Regularne aktualizacje zasobów CrowdSec i ich konfiguracji są kluczowe dla utrzymania skuteczności w obronie przed nowymi i ewoluującymi zagrożeniami.

W tym wpisie pokazaliśmy, jak łatwo zintegrować CrowdSec z istniejącą infrastrukturą Docker i Traefikiem, aby wzmocnić bezpieczeństwo Twojej infrastruktury IT. CrowdSec jest doskonałym uzupełnieniem dla każdego, kto aspiruje do roli DevOps, dostarczając potężne narzędzie do walki z cyberzagrożeniami w sposób współpracujący i społecznościowy.
