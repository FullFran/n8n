#!/bin/bash

# Ruta de destino del backup dentro del contenedor
BACKUP_DIR="/backups"
CONTAINER_NAME="n8n"

# Crear carpeta local si no existe
mkdir -p ./backups

# Nombre del archivo de backup con fecha
BACKUP_FILE="n8n-$(date +%F).tar.gz"

echo "📦 Realizando backup de datos de n8n..."

# Ejecutar el backup desde el contenedor
docker exec $CONTAINER_NAME tar czf $BACKUP_DIR/$BACKUP_FILE /home/node/.n8n

# Copiar el backup del contenedor a la máquina local
docker cp $CONTAINER_NAME:$BACKUP_DIR/$BACKUP_FILE ./backups/

echo "✅ Backup guardado en ./backups/$BACKUP_FILE"
