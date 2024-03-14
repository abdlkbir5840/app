#!/bin/bash

# Définir les paramètres de connexion à la base de données MySQL
DB_USER="laravel_user"
DB_PASS="Lar@vel_User_P@ssword"
DB_NAME="laravel_docker"
DB_HOST="mysql_db" # Nom du service du conteneur Docker MySQL

# Chemin de sauvegarde
BACKUP_DIR="/var/www/html/backups"

# Nom du fichier de sauvegarde avec la date actuelle
BACKUP_FILE="$BACKUP_DIR/backup-$(date +%Y-%m-%d_%H-%M-%S).sql"

# Créer le répertoire de sauvegarde s'il n'existe pas
mkdir -p "$BACKUP_DIR"

# Effectuer la sauvegarde de la base de données MySQL avec mysqldump
docker exec mysql_db mysqldump -u"$DB_USER" -p"$DB_PASS" -h"$DB_HOST" "$DB_NAME" > "$BACKUP_FILE"

# Vérifier si la sauvegarde a réussi
if [ $? -eq 0 ]; then
    echo "Sauvegarde de la base de données $DB_NAME effectuée avec succès : $BACKUP_FILE"
else
    echo "Erreur lors de la sauvegarde de la base de données $DB_NAME"
fi

