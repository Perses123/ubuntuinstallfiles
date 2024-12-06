#!/bin/bash

# System aktualisieren
sudo apt update

# Notwendige Pakete installieren
sudo apt install ca-certificates curl -y

# Docker GPG-Schlüssel hinzufügen
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Docker-Repository hinzufügen
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# System erneut aktualisieren
sudo apt update

# Docker Compose installieren
sudo apt install docker-compose-plugin -y

# Optional: Docker und Docker Compose Versionen anzeigen
docker --version
docker-compose --version

echo "Docker und Docker Compose wurden erfolgreich installiert!"
