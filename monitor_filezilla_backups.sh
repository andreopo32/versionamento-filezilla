#!/bin/bash

WATCH_DIR="$HOME/filezilla_temp"
BACKUP_BASE_DIR="$HOME/filezilla_backups"
LOG_FILE="$BACKUP_BASE_DIR/backup.log"

mkdir -p "$BACKUP_BASE_DIR"

echo "=== Monitor FileZilla iniciado em $(date) ===" >> "$LOG_FILE"

process_files() {
    local DIR="$1"
    find "$DIR" -type f | while read FILE; do
        BASENAME=$(basename "$FILE")
        DATE_DIR=$(date +"%Y-%m-%d")
        BACKUP_DIR="$BACKUP_BASE_DIR/$DATE_DIR"
        mkdir -p "$BACKUP_DIR"

        # Cria backup apenas se o conteúdo mudou
        if ! cmp -s "$FILE" "$BACKUP_DIR/latest_$BASENAME" 2>/dev/null; then
            TIMESTAMP=$(date +"%H-%M-%S")
            cp "$FILE" "$BACKUP_DIR/${TIMESTAMP}_$BASENAME"
            cp "$FILE" "$BACKUP_DIR/latest_$BASENAME"
            echo "$(date +"%Y-%m-%d %H:%M:%S") Backup criado: $BASENAME em $DATE_DIR" >> "$LOG_FILE"
            echo "Backup criado: $BACKUP_DIR/${TIMESTAMP}_$BASENAME"
        fi
    done
}

while true; do
    process_files "$WATCH_DIR"
    sleep 5
done
