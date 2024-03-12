# Tydzień 2: Docker & Homelab 🚀

## Dzień 12: Budowa Dockerowego Home Lab - Portainer 📊

### Rozpoczynamy Budowę Dockerowego Home Lab! 🚀

W dniu dwunastym naszej serii "100 dni do DevOps" rozpoczynamy przygodę z budową Home Lab opartego na Dockerze, wykorzystując Portainer do zarządzania naszym środowiskiem kontenerów.

### Czemu Portainer? 🤔

Portainer to graficzny interfejs użytkownika dla Docker, który upraszcza zarządzanie kontenerami, obrazami, sieciami i woluminami, czyniąc Docker dostępnym dla każdego, niezależnie od poziomu doświadczenia.

### Cel Dnia:

- **Instalacja Portainera:** Skonfigurujemy Portainera w naszym środowisku Docker za pomocą `docker-compose`, co pozwoli nam zarządzać kontenerami z poziomu przeglądarki.

### Jak zainstalować Portainera:

Uruchomienie Portainera w naszym Home Lab jest proste i wymaga tylko kilku kroków. Oto podstawowa komenda do uruchomienia Portainera w Docker:

```bash
docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
```
### Instalacja za pomocą Docker Compose:

Aby uprościć proces instalacji i zarządzania, użyjemy `docker-compose.yml` do uruchomienia Portainera. Oto jak to zrobić:

1. Stwórz plik `docker-compose.yml` w katalogu swojego projektu:

```yaml
version: '3.7'
services:
  portainer:
    image: portainer/portainer-ce
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    restart: always

volumes:
  portainer_data:
```
W katalogu z tym plikiem uruchom Portainera używając Docker Compose:
```bash
docker-compose up -d
```
Teraz Portainer powinien być dostępny pod adresem http://localhost:9000/, gdzie możesz zalogować się i zacząć zarządzać swoim środowiskiem Docker. 
#### (localhost lub adres IP hosta, jeśli uruchamiasz na zdalnym serwerze)

### Podsumowanie:
Dzięki Portainerowi zaczynamy naszą podróż w budowaniu funkcjonalnego i efektywnego środowiska Home Lab. To narzędzie nie tylko ułatwia zarządzanie Dockerem, ale także jest świetnym punktem wyjścia dla każdego, kto chce zgłębić świat DevOps i konteneryzacji.

Dołącz do Naszej Podróży DevOps:
Jesteś gotowy na więcej? Śledź #100DniDoDevOps, aby kontynuować rozwijanie swoich umiejętności i odkrywać nowe narzędzia w świecie DevOps.