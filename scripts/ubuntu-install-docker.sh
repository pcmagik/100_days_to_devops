#!/bin/bash

# Aktualizacja indeksu pakietów apt i instalacja pakietów pozwalających apt na korzystanie z repozytorium transportu HTTPS
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Dodanie oficjalnego klucza GPG Dockera
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ustawienie repozytorium Dockera
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Aktualizacja indeksu pakietów apt i instalacja Dockera
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Dodanie obecnego użytkownika do grupy docker, aby unikać konieczności używania sudo z poleceniem docker
if ! getent group docker > /dev/null; then
    sudo groupadd docker
fi
sudo usermod -aG docker $(whoami)

# Sprawdzenie, czy instalacja Dockera przebiegła pomyślnie
docker run hello-world

# Instalacja Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Sprawdzenie, czy instalacja Docker Compose przebiegła pomyślnie
docker-compose --version

echo "Instalacja Dockera i Docker Compose zakończona pomyślnie! Zaloguj się ponownie lub uruchom nową sesję terminala, aby zastosować zmiany w grupie."

# Uruchomienie nowej grupy
newgrp docker
