sudo rm -f /home/adrian/zarthistweb/zwordpressdb
sudo docker exec -t $(sudo docker ps -a | grep 'mysql:5.7' | awk '{print $1}') mysqldump -uwordpress -pyour_wordpress_password wordpress > ./wordpress_db_backup.sql && sudo zip --password sudodockerpsexectgrepawkmysqldumpword /home/adrian/zarthistweb/zwordpressdb ./wordpress_db_backup.sql && rm ./wordpress_db_backup.sql
sudo mv -f /home/adrian/zarthistweb/zwordpressdb.zip /home/adrian/zarthistweb/zwordpressdb
cd /home/adrian/zarthistweb/
sudo bash gitupdate.sh

