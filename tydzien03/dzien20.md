# Tydzień 3 - "Zaawansowane Homelab i Zarządzanie Usługami" 🚀

## Dzień 20: Bezpieczne VPN z WG-Easy 🛡️

### Wprowadzenie do WG-Easy
W dniu 20. naszej serii "100 dni do DevOps" eksplorujemy **WG-Easy**, przyjazny użytkownikowi interfejs dla WireGuard VPN. WG-Easy upraszcza proces konfiguracji VPN, czyniąc go dostępnym nawet dla mniej doświadczonych użytkowników, przy jednoczesnym zachowaniu zaawansowanych funkcji i bezpieczeństwa WireGuard.

### Dlaczego WG-Easy?
- **Łatwość użytkowania**: WG-Easy oferuje prosty interfejs, który ułatwia konfigurację i zarządzanie VPN.
- **Bezpieczeństwo**: Korzystając z zaawansowanego szyfrowania WireGuard, WG-Easy zapewnia wysoki poziom bezpieczeństwa.
- **Elastyczność**: Możliwość łatwego dodawania i zarządzania klientami VPN.

### Konfiguracja WG-Easy:
```bash
version: "3.8"
services:
  wg-easy:
    environment:
      # ⚠️ Required:
      # Change this to your host's public address
      - WG_HOST=mydomain.com # The public hostname of your VPN server.

      # Optional:
      # - PASSWORD=foobar123 # When set, requires a password when logging in to the Web UI.
      # - WG_PORT=51820 # The public UDP port of your VPN server. WireGuard will always listen on 51820 inside the Docker container.
      # - WG_DEFAULT_ADDRESS=10.8.0.x # Clients IP address range.
      # - WG_DEFAULT_DNS=1.1.1.1 # DNS server clients will use.
      # - WG_MTU=1420 # The MTU the clients will use. Server uses default WG MTU.
      # - WG_ALLOWED_IPS=192.168.15.0/24, 10.0.1.0/24 # Allowed IPs clients will use.
      # - WG_PRE_UP=echo "Pre Up" > /etc/wireguard/pre-up.txt
      # - WG_POST_UP=echo "Post Up" > /etc/wireguard/post-up.txt
      # - WG_PRE_DOWN=echo "Pre Down" > /etc/wireguard/pre-down.txt
      # - WG_POST_DOWN=echo "Post Down" > /etc/wireguard/post-down.txt
      
    image: weejewel/wg-easy
    container_name: wg-easy
    volumes:
      - /home/ubuntu/docker/wireguard:/etc/wireguard
    ports:
      - "51820:51820/udp"
      - "51821:51821/tcp"
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    sysctls:
      - net.ipv4.ip_forward=1
      - net.ipv4.conf.all.src_valid_mark=1
```

### Podsumowanie
WG-Easy to doskonałe rozwiązanie dla każdego, kto szuka łatwego w użyciu, ale bezpiecznego VPN. Integracja WG-Easy z WireGuard zapewnia solidne fundamenty dla bezpiecznej komunikacji w infrastrukturze IT.

