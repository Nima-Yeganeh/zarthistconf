#!/bin/bash
# Variables
CONTAINER_NAME="zarthistconf_db_1"
DATABASE_NAME="wordpress"  # Replace with your actual database name
USERNAME="root"  # Replace with your MySQL username
PASSWORD="your_mysql_password"  # Replace with your MySQL password
BACKUP_ZIP="wordpress_1234.zip"  # Replace with the path to your backup ZIP file
BACKUP_FILE="wordpress_1234.sql"
BACKFILE="wordpress_1234"
mv -f $BACKFILE $BACKUP_ZIP
# Copy the ZIP file into the Docker container
# docker cp "$BACKUP_ZIP" "$CONTAINER_NAME:/tmp/backup.zip"
# docker cp "$BACKUP_FILE" "$CONTAINER_NAME:/tmp/"
docker exec -i "$CONTAINER_NAME" ls -anp /tmp/
Extract the SQL dump file from the ZIP archive
unzip -o $BACKUP_ZIP -d ./
# Restore the MySQL database
docker exec -i "$CONTAINER_NAME" mysql -u"$USERNAME" -p"$PASSWORD" "$DATABASE_NAME" < $BACKUP_FILE
# Optionally, clean up extracted files and ZIP file
docker exec -i "$CONTAINER_NAME" rm -f /tmp/$BACKUP_FILE /tmp/$BACKUP_ZIP
docker exec -i "$CONTAINER_NAME" ls -anp /tmp/
rm -f $BACKUP_FILE
mv -f $BACKUP_ZIP $BACKFILE
echo "Restore completed"

