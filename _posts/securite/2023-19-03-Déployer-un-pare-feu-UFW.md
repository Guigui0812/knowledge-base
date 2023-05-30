---
title: Mettre en place un pare-feu avec UFW sous Debian
date: 2023-03-19 00:00:00
categories: [securite]
tags: [sysadmin, securite, pare-feu, ufw, debian]
---

UFW est une interface de configuration pour le pare-feu iptables. Il est disponible sous Debian et peut être installé avec la commande `sudo apt install ufw`. Elle permet de configurer le pare-feu de manière simple et rapide.

## Installation de UFW

Sous debian, installer le paquet avec la commande `sudo apt install ufw`.

## Configuration du pare-feu

La configuration dépend du type de serveur. Par défaut, il est recommandé de refuser toutes les connexions entrantes ou sortantes. Il faut ensuite autoriser manuellement certaiens connexions. 

Pour refuser toutes les connexions par défaut, saisissez les lignes suivantes :

```bash
$ sudo ufw default deny incoming
$ sudo ufw default allow outgoing
```

Grâce à ces lignes, le serveur refusera toutes les connexions. Cependant, il est nécessaires d'autoriser certaines connexions comme le SSH pour gérer le serveur à distance ou le HTTP/HTTPS pour afficher des pages web. 

Pour autoriser le SSH : `sudo ufw allow ssh`. Cette commande fonctionne dans le cas où le port SSH est configuré par défaut. Si le port a été modifié, il faut utiliser : `sudo ufw allow <port>`.

Pour autoriser le traf HTTP/HTTPS, il faut utiliser la commande `sudo ufw allow http` et `sudo ufw allow https`. Si le port a été changé, il faut utiliser `sudo ufw allow <port>` comme pour le SSH.

## Activer le pare-feu

Lorsque le pare-feu est configuré, il faut l'activer avec la commande `sudo ufw enable`.

## Vérifier le pare-feu

Pour vérifier le pare-feu, il faut utiliser la commande `sudo ufw status`. Cette commande affiche les règles du pare-feu et l'état du pare-feu.

#### Liens utiles :
- [UFW - Debian Wiki](https://wiki.debian.org/fr/UncomplicatedFirewall)
- [Digital Ocean - How To Set Up a Firewall with UFW on Debian](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-debian-9)
- [How to configure firewall on ubuntu using UFW](https://www.hostinger.com/tutorials/how-to-configure-firewall-on-ubuntu-using-ufw/)