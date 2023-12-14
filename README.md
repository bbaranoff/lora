Testé sur un VPS OVH

Serveurs personnels :

https://sdr.systems  

https://lora.sdr.systems  

#LoRa
=====

Dans une fenetre BASH

A partir de la racine de ce ZIP téléchargé à partir de github

```bash
sudo chmod +x runme.sh
sudo ./runme.sh
```

-----------------------------------------------

Préparation de la plateforme d'objets connectés

-----------------------------------------------

Offre choisie pour le serveurd'IoT (Machine virtuelle hebergée par OVH)  

[![text](https://raw.githubusercontent.com/bbaranoff/lora/main/VPS_Offre_OVH.png)](https://www.ovhcloud.com/fr/vps/limited-edition/)  


Echange de clef entre le client (mon laptop) et le serveur (le VPS d'OVH)  

[![text](https://raw.githubusercontent.com/bbaranoff/lora/main/ssh_key.png)](https://www.ovh.com/manager/#/dedicated/billing/autorenew/ssh)  

--------------------------------------------------------------------------------------
Optionel - Début
--------------------------------------------------------------------------------------

On transfert la zone DNS d'OVH vers cloudflare  

[![text](https://raw.githubusercontent.com/bbaranoff/lora/main/ovh_to_cloudflare_dns.jpg)](https://www.ovh.com)  

On fait pointer les champs DNS de cloudflare vers la machine virtuelle que constitue notre serveur

[![text](https://raw.githubusercontent.com/bbaranoff/lora/main/dns_cloudflare.jpg)](https://www.cloudflare.com)  

On voit le VPS OVH et l'IP associée  

![text](https://raw.githubusercontent.com/bbaranoff/lora/main/vps_ovh.jpg)  

On voit que l'on ping sur l'IP de cloudflare et non pas d'OVH  

![text](https://raw.githubusercontent.com/bbaranoff/lora/main/ping_sdr_systems.jpg)  

Si l'on accède à l'IP du ping le site bloque la connection que ce soit via navigateur  

![text](https://raw.githubusercontent.com/bbaranoff/lora/main/direct_ip_ban.jpg)  

Ou SSH  

![text](https://raw.githubusercontent.com/bbaranoff/lora/main/ssh_proxied_direct.jpg)  

Le reverse proxy est bien en place le port ssh n'est pas accessible à partir du nom de domaine et nécessite la connaissance de l'IP réelle du site


