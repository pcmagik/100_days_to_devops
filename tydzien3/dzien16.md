# Tydzień 3: Zaawansowane Narzędzia i Praktyki w DevOps 🚀

## Dzień 16: Lokalny DNS Pi-hole z Traefikiem i Cloudflare 🌐

### Wprowadzenie do Pi-hole z Bezpiecznym Dostępem Zewnętrznym 🔒

W dniu szesnastym naszej serii "100 dni do DevOps" implementujemy Pi-hole jako nasz lokalny DNS server, blokujący reklamy i śledzące nas zapytania DNS. Używamy Traefika do zarządzania ruchem sieciowym i Cloudflare do obsługi SSL.

### Dlaczego Pi-hole? 🛡️

Pi-hole zapewnia czystszą i bezpieczniejszą przeglądanie internetu, blokując niechciane reklamy i tracker'y na poziomie DNS.

### Konfiguracja z Traefikiem i Cloudflare: 🔄

Integracja z Traefikiem pozwala na bezpieczne wystawienie Pi-hole na zewnątrz, a Cloudflare zapewnia zarządzanie SSL i domeną.

### Przykładowy plik `docker-compose.yml`:

Utwórz plik `docker-compose.yml` w swoim projekcie z poniższą konfiguracją:

```yaml
version: "3.6"

# More info at https://github.com/pi-hole/docker-pi-hole/ and https://docs.pi-hole.net/
services:
  cloudflared:
    container_name: cloudflared
    # Restart on crashes and on reboots
    restart: unless-stopped
    image: cloudflare/cloudflared:latest
    command: proxy-dns
    environment:
      - "TUNNEL_DNS_UPSTREAM=https://1.1.1.1/dns-query,https://1.0.0.1/dns-query,https://9.9.9.9/dns-query,https://149.112.112.9/dns-query"

      # Listen on an unprivileged port
      - "TUNNEL_DNS_PORT=5053"

      # Listen on all interfaces
      - "TUNNEL_DNS_ADDRESS=0.0.0.0"

    # Attach cloudflared only to the private network
    networks:
      pihole_internal:
        ipv4_address: 172.70.9.2
    security_opt:
      - no-new-privileges:true


  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "67:67/udp"
      - "500:80/tcp"
    #  - "443:443/tcp"
    networks:
      pihole_internal:
        ipv4_address: 172.70.9.3
      proxy:
    environment:
      TZ: 'Europe/London'
      WEBPASSWORD: 'password'
      PIHOLE_DNS_: '172.70.9.2#5053'
      DNSMASQ_LISTENING: 'all'
      VIRTUAL_HOST: pihole.yourdomain.com
    # Volumes store your data between container upgrades
    volumes:
      - '/home/ubuntu/docker/pihole/:/etc/pihole/'
      - '/home/ubuntu/docker/pihole/etc-dnsmasq.d/:/etc/dnsmasq.d/'
    # Recommended but not required (DHCP needs NET_ADMIN)
    #   https://github.com/pi-hole/docker-pi-hole#note-on-capabilities
    #cap_add:
    #  - NET_ADMIN
    restart: unless-stopped
    depends_on:
      - cloudflared
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.pihole.entrypoints=http"
      - "traefik.http.routers.pihole.rule=Host(`pihole.yourdomain.com`)"
      - "traefik.http.middlewares.pihole-https-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.pihole.middlewares=pihole-https-redirect"
      - "traefik.http.routers.pihole-secure.entrypoints=https"
      - "traefik.http.routers.pihole-secure.rule=Host(`pihole.yourdomain.com`)"
      - "traefik.http.routers.pihole-secure.tls=true"
      - "traefik.http.routers.pihole-secure.service=pihole"
      - "traefik.http.services.pihole.loadbalancer.server.port=80"
      - "traefik.docker.network=proxy"

networks:
  pihole_internal:
     ipam:
       config:
         - subnet: 172.70.9.0/29
     name: pihole_internal
  proxy:
    external: true
```


## run these commands to fix port bind error
```
sudo sed -r -i.orig 's/#?DNSStubListener=yes/DNSStubListener=no/g' /etc/systemd/resolved.conf

sudo sh -c 'rm /etc/resolv.conf && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf'

systemctl restart systemd-resolved
```

```
labels:
  - "traefik.enable=true" 
    # Informuje Traefika, że ten kontener powinien być uwzględniony w procesie routingu. 

  - "traefik.http.routers.pihole.entrypoints=http"
    # Definiuje router 'pihole' dla Traefika, który nasłuchuje na punkcie wejścia 'http'. Używane do routingu ruchu HTTP.

  - "traefik.http.routers.pihole.rule=Host(`pihole.yourdomain.com`)"
    # Określa regułę dla routera 'pihole', aby dopasować ruch na podstawie Hosta. W tym przypadku, ruch do 'pihole.yourdomain.com' będzie przekierowany do tego kontenera.

  - "traefik.http.middlewares.pihole-https-redirect.redirectscheme.scheme=https"
    # Tworzy middleware o nazwie 'pihole-https-redirect', który przekierowuje cały ruch HTTP na HTTPS.

  - "traefik.http.routers.pihole.middlewares=pihole-https-redirect"
    # Przypisuje wcześniej utworzony middleware do routera 'pihole', zapewniając, że cały ruch HTTP będzie przekierowany do HTTPS.

  - "traefik.http.routers.pihole-secure.entrypoints=https"
    # Definiuje bezpieczny router 'pihole-secure', który nasłuchuje na punkcie wejścia 'https', przeznaczony do obsługi ruchu HTTPS.

  - "traefik.http.routers.pihole-secure.rule=Host(`pihole.yourdomain.com`)"
    # Podobnie jak w przypadku routera 'pihole', definiuje regułę dla 'pihole-secure', aby obsługiwać ruch do 'pihole.yourdomain.com', ale dla połączeń HTTPS.

  - "traefik.http.routers.pihole-secure.tls=true"
    # Włącza obsługę TLS (SSL) dla routera 'pihole-secure', zapewniając bezpieczne połączenia.

  - "traefik.http.routers.pihole-secure.service=pihole"
    # Określa, że router 'pihole-secure' ma korzystać z usługi 'pihole' (definiowanej poniżej) do obsługi ruchu przekierowanego przez tego routera.

  - "traefik.http.services.pihole.loadbalancer.server.port=80"
    # Definiuje usługę 'pihole' dla Traefika, wskazując, że ruch powinien być przekierowywany na port 80 tego kontenera.

  - "traefik.docker.network=proxy"
    # Informuje Traefika, by użył sieci 'proxy' dla tego kontenera. Ważne, gdy kontenery działają w ramach wielu sieci Docker.
```
