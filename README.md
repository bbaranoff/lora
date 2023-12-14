L'objet de ce projet est d'automatiser l'installation de ChirpStack (Gestion des Trames LoRaWAN) et de ThingsBoard 
(Gestion des données reçu par les objets connectés ou les mesures faites par divers Laboratoires ou entités en exprimant le besoin)
Le script d'installation offre la possibilité d'accéder à ces même serveurs de trois manières soit directement sur l'ip publique,
soit sur un nom de domaine et un sous domaine, soit toujours un nom de domaine et un sous domaine appartenant à ce même domaine encore une fois
mais en y ajoutant un reverse proxy de CloudFlare.

Installation :  

[![Watch the video](https://raw.githubusercontent.com/bbaranoff/lora/main/my.gif)](https://www.youtube.com/watch?v=cwH5qIvN_4E)

Set it up :  

[![Watch the video](https://raw.githubusercontent.com/bbaranoff/lora/main/my2.gif)](https://www.youtube.com/watch?v=2qsGmbTFw6k)


Testé sur un VPS OVH  

Serveurs personnels :  

https://sdr.systems  

https://lora.sdr.systems  

---------------------------
# Installation des serveurs
---------------------------

Dans mon cas j'ai pris un serveur VPS (Une Machine Virtuelle possédant une IP Publique chez OVH ainsi qu'un nom de domaine toujours chez OVH : sdr.systems
et enfin j'ai transféré ma zone DNS chez cloudflare.
De ce fait il est impossible d'accéder au port SSH via ssh ubuntu@sdr.systems mais il faut donc faire ssh@IP_PUBLIQUE_OVH pour avoir l'accès.
J'ai aussi ajouté le fichier id_rsa.pub sur mes certificats SSH de chez OVH. Il est comme ceci si besoin possible de bloquer l'authentification par mot
de passe sur le SSH. L'installation s'est donc faite sur une version Ubuntu 22.04 Jammy d'OVH. Une fois tout ceci fait : Pour accéder à la machine virtuelle de chez OVH on fait

ssh@IP_PUBLIQUE_OVH

et enfin on peut commencer l'installation des serveurs ChirpStack et ThingsBoard.

Dans une fenetre BASH

```bash
git clone https://github.com/bbaranoff/lora
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


