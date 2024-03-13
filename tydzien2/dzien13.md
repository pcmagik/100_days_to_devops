# Tydzień 2: Docker & Homelab 🚀

## Dzień 13: Hostowanie Aplikacji z pomocą Nginx Proxy Manager 🌍

### Uproszczenie Hostowania Aplikacji Dockerowych 🚀

W trzynastym dniu "100 dni do DevOps" wprowadzamy Nginx Proxy Manager, narzędzie, które umożliwia łatwe zarządzanie proxy HTTP i zarządzanie certyfikatami SSL dla naszych kontenerów Docker.

### Dlaczego Nginx Proxy Manager? 🤔

Nginx Proxy Manager sprawia, że zarządzanie dostępem do aplikacji hostowanych na Dockerze staje się proste i intuicyjne, oferując graficzny interfejs użytkownika dla konfiguracji Nginx.

### Co Zyskujemy? 📈

- **Łatwe Zarządzanie Proxy:** Możemy przekierowywać ruch zewnętrzny do naszych aplikacji Docker bez bezpośredniej edycji plików konfiguracyjnych Nginx.
- **Automatyzacja SSL:** Automatyczne zarządzanie certyfikatami SSL dzięki integracji z Let's Encrypt.
- **Wizualna Konfiguracja:** Zarządzanie ustawieniami przez przyjazny dla użytkownika interfejs webowy.

### Konfiguracja Nginx Proxy Manager:

Aby uruchomić Nginx Proxy Manager, możemy skorzystać z poniższego `docker-compose.yml`:

```yaml
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
```

### Utwórz plik docker-compose.yml i wklej powyższą konfigurację.
Uruchom `docker-compose up -d` w katalogu z tym plikiem.

#### Podsumowanie:
Z Nginx Proxy Manager, hostowanie i zarządzanie dostępem do aplikacji Dockerowych staje się znacznie prostsze i bardziej intuicyjne. To kolejny krok w kierunku zbudowania zaawansowanego środowiska Home Lab z wykorzystaniem Docker.

Dołącz do Naszej Podróży DevOps:
Chcesz więcej? Śledź #100DniDoDevOps, aby kontynuować odkrywanie nowych narzędzi i praktyk w świecie DevOps.