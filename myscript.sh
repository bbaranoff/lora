cd /root/LoRaHandle/chirpstack && sudo docker-compose up -d
cd /root/LoRaHandle/thingsboard && sudo docker-compose up -d
sudo caddy run --config /etc/caddy/Caddyfile
