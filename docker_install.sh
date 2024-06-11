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
