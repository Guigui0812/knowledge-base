---
title: Sécuriser un VPS Debian
date: 2023-03-19 00:00:00  
categories: [sysadmin, securite]
tags: [sysadmin, securite, debian, vps, ssh, fail2ban, iptables]
---

Plusieurs manipulations sont nécessaires pour sécuriser un VPS Debian. Il est possible de sécuriser un VPS Debian avec Fail2ban, SSH, iptables et un pare-feu.

## Changer le port SSH

Il est important de changer le port SSH par défaut pour éviter les attaques par force brute. Il est possible de changer le port SSH par défaut sous Debian avec la commande `sudo nano /etc/ssh/sshd_config`. Il faut ensuite modifier la ligne `Port 22` en `Port <port>`. Enfin, il faut redémarrer le service SSH avec la commande `sudo systemctl restart ssh`.

## Utiliser l'authentification par clé SSH

Voir l'article à ce sujet [Générer et utiliser une clé SSH](./2023-19-03-Generer-et-utiliser-une-cle-ssh-pour-serveur.md).

## Créer un utilisateur dédié et l'ajouter au groupe sudo

Une mauvaise pratique commune est l'utilisation du root en toute circonstance. Il ne faut surtout pas utiliser le super-utilisateur tous le temps, de même que l'utilisation de `sudo -i` est vivement déconseillé. En effet, une mauvaise manipulation peut vite arriver. 

Les commandes à exécuter sont les suivantes :

```bash
sudo adduser <utilisateur>
sudo usermod -aG sudo <utilisateur>
```

Lors de la création de l'utilisateur, il est possible de lui attribuer un mot de passe. Il est possible de le désactiver en utilisant l'option `-p ""`.

## Désactiver l'authentification par mot de passe

Il est possible de désactiver l'authentification par mot de passe pour SSH. Pour cela, il faut modifier le fichier de configuration SSH avec la commande `sudo nano /etc/ssh/sshd_config`. Il faut ensuite modifier la ligne `PasswordAuthentication yes` en `PasswordAuthentication no`. Enfin, il faut redémarrer le service SSH avec la commande `sudo systemctl restart ssh`.

## Désactiver l'authentification root

Il est possible de désactiver l'authentification root pour SSH. Pour cela, il faut modifier le fichier de configuration SSH avec la commande `sudo nano /etc/ssh/sshd_config`. Il faut ensuite modifier la ligne `PermitRootLogin yes` en `PermitRootLogin no`. Enfin, il faut redémarrer le service SSH avec la commande `sudo systemctl restart ssh`.

## Installer un pare-feu

### Iptables

Iptables est un pare-feu interne qui permet de bloquer les attaques par force brute. Il est possible d'installer iptables sous Debian avec la commande `sudo apt install iptables`. Il faut ensuite modifier le fichier de configuration `/etc/iptables/rules.v4` pour activer le filtrage SSH. Il faut ensuite redémarrer le service iptables avec la commande `sudo systemctl restart iptables`.

Avec`sudo iptables -L -v`, il est possible de voir les règles actives.

### UFW

Voir l'article à ce sujet [Déployer un pare-feu-UFW](./2023-19-03-Deployer-un-pare-feu-ufw.md).

## Fail2ban

Fail2ban est un outil qui permet de bloquer les attaques par force brute. Il est possible d'installer Fail2ban sous Debian avec la commande `sudo apt install fail2ban`. Il faut ensuite modifier le fichier de configuration `/etc/fail2ban/jail.conf` pour activer le filtrage SSH. Il faut ensuite redémarrer le service Fail2ban avec la commande `sudo systemctl restart fail2ban`. 

Pour vérifier que Fail2ban fonctionne, utiliser la commande `sudo systemctl status fail2ban`.

## Utiliser SFTP

SFTP est normalement activé par défaut. Il est important de l'utiliser à la place de FTP pour éviter les attaques par force brute. Il est possible de l'utiliser avec FileZilla.

## Installer un antivirus

[Antivirus ClamAV sous Debian](./2023-19-03-Antivirus-ClamAV-sous-Debian.md)

## Mettre à jour le système

Il est important de mettre à jour le système régulièrement pour éviter les failles de sécurité. Il est possible de mettre à jour le système sous Debian avec la commande `sudo apt update && sudo apt upgrade`.

#### Liens utiles :

- [How to change ssh port vps - Hostinger](https://www.hostinger.com/tutorials/how-to-change-ssh-port-vps)
- [Getting Started with vps hosting - Hostinger](https://www.hostinger.com/tutorials/getting-started-with-vps-hosting)
- [VPS Security - Hostinger](https://www.hostinger.com/tutorials/vps-security)