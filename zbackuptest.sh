#!/bin/bash

# Variables
CONTAINER_NAME="zarthistconf_db_1"
DATABASE_NAME="wordpress"  # Replace with your actual database name
USERNAME="root"  # Replace with your MySQL username
PASSWORD="your_mysql_password"  # Replace with your MySQL password
BACKUP_DIR="./"  # Replace with the directory where you want to save the backup
TIMESTAMP=$(date +%Y%m%d%H%M%S)
TIMESTAMP="1234"
SQL_DUMP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_${TIMESTAMP}.sql"
ZIP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_${TIMESTAMP}.zip"
BACKFILE="${BACKUP_DIR}/${DATABASE_NAME}_${TIMESTAMP}"
# Create backup directory if it doesn't exist
# mkdir -p "$BACKUP_DIR"
# Dump the MySQL database
docker exec -i "$CONTAINER_NAME" mysqldump -u"$USERNAME" -p"$PASSWORD" "$DATABASE_NAME" > "$SQL_DUMP_FILE"
# Compress the SQL dump into a ZIP file
rm -f "$ZIP_FILE"
zip "$ZIP_FILE" "$SQL_DUMP_FILE"
# Optionally, remove the SQL dump file after zipping
# rm "$SQL_DUMP_FILE"
mv -f "$ZIP_FILE" "$BACKFILE"
rm -f "$SQL_DUMP_FILE"
echo "Backup completed: $ZIP_FILE"
bash gitupdate.sh

