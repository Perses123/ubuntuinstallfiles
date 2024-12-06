#!/bin/bash

# Definiere das Basis-Verzeichnis für Backups
BASE_BACKUP_DIR="/mnt/backup"

# Hole den Hostnamen der VM (nehmen wir an, dass der Hostname der VM der VM-Name ist)
VM_NAME=$(hostname)

# Erstelle einen Ordner für die VM im Backup-Verzeichnis
BACKUP_DIR="$BASE_BACKUP_DIR/$VM_NAME/$(date +%Y-%m-%d_%H-%M-%S)"
mkdir -p $BACKUP_DIR

# Liste der Docker-Volumes sichern, ohne den Stack herunterzufahren
docker volume ls -q | while read volume; do
  # Erstelle ein Backup jedes Volumes und speichere es im VM-spezifischen Ordner
  docker run --rm -v $volume:/volume -v $BACKUP_DIR:/backup alpine \
    tar czf /backup/${volume}.tar.gz -C /volume .
done

echo "Backup abgeschlossen"

# Füge den Cron-Job hinzu, um das Skript jede Stunde auszuführen (nur, wenn der Cron-Job noch nicht existiert)
CRON_JOB="0 * * * * /path/to/your/backup_script.sh"

# Überprüfe, ob der Cron-Job bereits existiert
(crontab -l | grep -v -F "$CRON_JOB"; echo "$CRON_JOB") | crontab -

echo "Cron-Job für stündliche Ausführung hinzugefügt."
