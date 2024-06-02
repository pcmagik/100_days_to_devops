# Tydzień 6: Security

## Dzień 37: Implementacja SSL/TLS w Docker 🐳

### Wprowadzenie do SSL/TLS
Dzień 37 "100 dni do DevOps" poświęcamy na zagłębienie się w zarządzanie certyfikatami SSL/TLS - kluczowym elemencie w zabezpieczaniu komunikacji w naszych aplikacjach, zwłaszcza gdy działają w kontenerach Docker.

### Dlaczego SSL/TLS jest Kluczowy?
- **Poufność**: Szyfrowanie połączeń chroni przed przechwyceniem wrażliwych danych.
- **Autentyczność**: Weryfikuje, czy komunikujesz się z prawdziwym serwerem.
- **Integralność**: Gwarantuje, że dane nie zostały zmienione w trakcie transmisji.

### Implementacja SSL/TLS w Docker:
1. **Generowanie Certyfikatów**:
    - Użycie narzędzi takich jak Let's Encrypt do automatycznego generowania certyfikatów SSL/TLS dla naszych usług.
    ```bash
    sudo docker run -it --rm --name certbot -v "/etc/letsencrypt:/etc/letsencrypt" certbot/certbot certonly --standalone -d twojadomena.com
    ```
2. **Konfiguracja Serwera Webowego w Kontenerze**:
    - Przykład konfiguracji Nginx z certyfikatem SSL w Dockerfile:
    ```dockerfile
    FROM nginx:alpine
    COPY ./default.conf /etc/nginx/conf.d/default.conf
    COPY /home/ubuntu/certs:/etc/ssl/certs
    EXPOSE 443
    ```
3. **Automatyzacja Odnowień**:
    - Implementacja skryptów automatyzujących proces odnowienia certyfikatów, aby uniknąć wygaśnięcia.

### Najlepsze Praktyki:
- **Automatyzacja**: Wykorzystaj narzędzia do automatycznego odnawiania certyfikatów.
- **Segregacja**: Przechowuj certyfikaty w bezpiecznym miejscu, najlepiej poza kontenerami.
- **Monitoring**: Regularnie sprawdzaj ważność certyfikatów i szybko reaguj na ewentualne problemy.

### Podsumowanie
Zarządzanie certyfikatami SSL/TLS w środowisku Docker jest niezbędne do zabezpieczenia komunikacji między kontenerami oraz między kontenerami a użytkownikami. Dzięki tym praktykom zapewnimy wysoki poziom bezpieczeństwa naszych aplikacji działających w kontenerach.
