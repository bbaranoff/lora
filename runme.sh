#!/bin/bash
if [ $USER != "root" ]; then echo "run as root" && exit; fi
sudo apt update && sudo apt upgrade -y
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
#run from git folder
mkdir /root/LoRaHandle
cp -r * /root/LoRaHandle
mkdir -p ~/.mytb-data && sudo chown -R 799:799 ~/.mytb-data
mkdir -p ~/.mytb-logs && sudo chown -R 799:799 ~/.mytb-logs
mkdir /etc/caddy
HAVE_DOMAIN_NAME="Y"
read -p "Having Domain Name ? Y/n " HAVE_DOMAIN_NAME
read -p "Using Cloudflare ? Y/n " MYVAR
if [ $MYVAR != "n" ];
echo $PWD
then
    read -p "CloudFlare API ? " CLOUD_VAR
    sed -i -e 's/CLOUD_VAR/'$CLOUD_VAR'/g' /root/LoRaHandle/Caddyfile
    read -p "Nom de Domaine ? " DOMAIN_NAME
    sed -i -e 's/DOMAIN_NAME/'$DOMAIN_NAME'/g' /root/LoRaHandle/Caddyfile
    read -p "Nom de Sous-Domaine ? " SUBDOMAIN
    sed -i -e 's/SUBDOMAIN/'$SUBDOMAIN'/g' /root/LoRaHandle/Caddyfile
    read -p "IP PUBLIQUE DU SERVEUR DERRIERE LE REVERSE PROXY ? " MON_IP_PUBLIQUE
    sed -i -e 's/MON_IP_PUBLIQUE/'$MON_IP_PUBLIQUE'/g' /root/LoRaHandle/Caddyfile
    cp /root/LoRaHandle/Caddyfile /etc/caddy/Caddyfile
else
    read -p "Nom de Domaine ? " DOMAIN_NAME
    sed -i -e 's/DOMAIN_NAME/'$DOMAIN_NAME'/g' /root/LoRaHandle/Caddyfile2
    read -p "Nom de Sous-Domaine ? " SUBDOMAIN
    sed -i -e 's/SUBDOMAIN/'$SUBDOMAIN'/g' /root/LoRaHandle/Caddyfile2
    read -p "IP PUBLIQUE DU SERVEUR DERRIERE LE REVERSE PROXY ? " MON_IP_PUBLIQUE
    sed -i -e 's/MON_IP_PUBLIQUE/'$MON_IP_PUBLIQUE'/g' /root/LoRaHandle/Caddyfile2
    cp /root/LoRaHandle/Caddyfile2 /etc/caddy/Caddyfile
fi


sudo apt install docker.io docker-compose -y
bash /root/LoRaHandle/remove-all-from-docker.sh
sudo chmod 755 -R /root/LoRaHandle/
cd /root/LoRaHandle
rm -r /root/LoRaHandle/chirpstack
git clone https://github.com/brocaar/chirpstack-docker.git
mv chirpstack-docker chirpstack
cd /root/LoRaHandle/chirpstack
sudo docker-compose up -d
cd ..

cd /root/LoRaHandle/thingsboard
sudo docker-compose up -d
cd ..

# Add this to your .profile, .bashrc or .bash_profile
# then logout & login
export GOROOT=/usr/local/go
export PATH=$PATH:/usr/local/go/bin
go version

sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https -y
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/xcaddy/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-xcaddy-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/xcaddy/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-xcaddy.list
sudo apt update
sudo apt install xcaddy -y

xcaddy build --with github.com/caddy-dns/cloudflare@latest
cp /root/LoRaHandle/caddy /usr/local/bin
if ($HAVE_DOMAIN_NAME != "n");then
    (crontab -l 2>/dev/null; echo "@reboot sudo /root/LoRaHandle/myscript.sh") | crontab -
else
    (crontab -l 2>/dev/null; echo "@reboot sudo /root/LoRaHandle/myscript_2.sh") | crontab -
fi
read -p "DONE ! $DOMAIN_NAME and $SUBDOMAIN.$DOMAIN_NAME public_ip:8080 public_ip:8888 should be available after reboot ! Reboot Y/n" REBOOT
if ($REBOOT != "n");then
    sudo reboot
fi
