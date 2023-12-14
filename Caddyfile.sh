read -p "Using Cloudflare ? Y/n " MYVAR
if [ $MYVAR != "n" ];
echo $PWD
then
    read -p "CloudFlare API ? " CLOUD_VAR
    sed -i -e 's/CLOUD_VAR/'$CLOUD_VAR'/g' Caddyfile
    read -p "Nom de Domaine ? " DOMAIN_NAME
    sed -i -e 's/DOMAIN_NAME/'$DOMAIN_NAME'/g' Caddyfile
    read -p "Nom de Sous-Domaine ? " SUBDOMAIN
    sed -i -e 's/SUBDOMAIN/'$SUBDOMAIN'/g' Caddyfile
    read -p "IP PUBLIQUE DU SERVEUR DERRIERE LE REVERSE PROXY ? " MON_IP_PUBLIQUE
    sed -i -e 's/MON_IP_PUBLIQUE/'$MON_IP_PUBLIQUE'/g' Caddyfile
    cp /root/LoRaHandle/Caddyfile /usr/caddy
else
    read -p "Nom de Domaine ? " DOMAIN_NAME
    sed -i -e 's/DOMAIN_NAME/'$DOMAIN_NAME'/g' Caddyfile2
    read -p "Nom de Sous-Domaine ? " SUBDOMAIN
    sed -i -e 's/SUBDOMAIN/'$SUBDOMAIN'/g' Caddyfile2
    read -p "IP PUBLIQUE DU SERVEUR DERRIERE LE REVERSE PROXY ? " MON_IP_PUBLIQUE
    sed -i -e 's/MON_IP_PUBLIQUE/'$MON_IP_PUBLIQUE'/g' Caddyfile2
    cp /root/LoRaHandle/Caddyfile2 /usr/caddy/Caddyfile
fi
