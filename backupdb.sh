sudo rm -f /root/zarthistweb/zwordpressdb
sudo docker exec -t $(sudo docker ps -a | grep 'mysql:5.7' | awk '{print $1}') mysqldump -uwordpress -pyour_wordpress_password wordpress > ./wordpress_db_backup.sql && sudo zip --password sudodockerpsexectgrepawkmysqldumpword /root/zarthistweb/zwordpressdb ./wordpress_db_backup.sql && rm ./wordpress_db_backup.sql
sudo mv -f /root/zarthistweb/zwordpressdb.zip /root/zarthistweb/zwordpressdb
cd /root/zarthistweb/
sudo bash gitupdate.sh
cd /root/zarthistconf/
sudo bash gitupdate.sh

