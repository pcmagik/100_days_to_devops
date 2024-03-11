# Tydzień 2: Docker & Homelab 🚀

## Dzień 11: Docker Compose dla WordPressa 📝

### Tworzymy środowisko WordPress z Docker Compose!

Dzisiaj skonfigurujemy pełne środowisko dla WordPressa, wykorzystując `docker-compose`. W naszym zestawieniu znajdzie się WordPress, baza danych MySQL oraz phpMyAdmin do zarządzania bazą danych.

### Plik `docker-compose.yml`:

```yaml
version: '3.1'

services:
  wordpress:
    image: wordpress:latest
    ports:
      - "8000:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wordpress_data:/var/www/html
    restart: always

  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: somewordpress
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
    restart: always

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    ports:
      - "8080:80"
    environment:
      PMA_HOST: db
      MYSQL_ROOT_PASSWORD: somewordpress
    depends_on:
      - db
    restart: always

volumes:
  wordpress_data:
  db_data:
```


Po zdefiniowaniu pliku docker-compose.yml, wystarczy uruchomić komendę docker-compose up w katalogu z tym plikiem, aby rozpocząć działanie środowiska WordPress.