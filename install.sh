git pull
if [ ! -e "/swapfile" ]; then
    sudo fallocate -l 4G /swapfile
    ls -anp /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
fi
sudo apt update -y
sudo apt install zip unzip screen iftop mtr net-tools python3 python3-pip apt-transport-https ca-certificates curl gnupg lsb-release docker-compose docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo lsb_release -a
sudo docker ps -a
sudo python3 -m pip install --upgrade pip
sudo pip install --upgrade pip
sudo pip install python-wordpress-xmlrpc
sudo apt-get update -y
sudo apt install python3 python3-pip -y
sudo apt-get install imagemagick -y
sudo pip install --upgrade python-tgpt
sudo pip install gtts
ls -lh /root/zarthistweb
sudo chown -R www-data:www-data /root/zarthistweb/
sudo chown www-data:www-data /root/zarthistweb/
ls -lh /root/zarthistweb

