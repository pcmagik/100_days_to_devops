# Tydzień 2: Docker & Homelab 🚀

## Dzień 10: Wstep do Dockerfile i Docker Compose 🐳

### Odkrywamy moc konteneryzacji! 🌐

Dzień 6 naszej podróży "100 dni do DevOps" poświęcamy na zgłębienie tematu konteneryzacji, skupiając się na Dockerze.

### Co to jest Konteneryzacja?

Konteneryzacja to technologia, która pozwala na izolację aplikacji w kontenerach, ułatwiając ich wdrażanie i skalowanie.

### Pierwsze Kroki z Dockerem:

1. **Instalacja Docker**: Zacznij od zainstalowania Docker na swoim systemie.
2. **Tworzenie Dockerfile**: Użyj `Dockerfile` do zdefiniowania środowiska dla Twojej aplikacji.
    ```Dockerfile
    FROM node:14
    WORKDIR /app
    COPY . /app
    RUN npm install
    EXPOSE 3000
    CMD ["npm", "start"]
    ```
3. **Budowanie Obrazu**: Użyj `docker build` do stworzenia obrazu z Twojego `Dockerfile`.
    ```bash
    docker build -t moja-aplikacja .
    ```
4. **Uruchamianie Kontenera**: Uruchom kontener używając `docker run`.
    ```bash
    docker run -d -p 3000:3000 moja-aplikacja
    ```

### Orkiestracja z Docker Compose:

Użyj Docker Compose do definiowania i uruchamiania wielokontenerowych aplikacji Docker.

```yaml
version: '3'
services:
  web:
    build: .
    ports:
      - "3000:3000"
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: example
