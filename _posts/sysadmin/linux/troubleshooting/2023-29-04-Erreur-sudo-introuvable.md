---
title: Erreur sudo introuvable
date: 2023-03-30 00:00:00
categories: [sysadmin, linux, troubleshooting]
tags: [sysadmin, linux, troubleshooting, sudo, shell, terminal]
---

Cette erreur peut survenir lorsqu'on tente d'exécuter une commande avec sudo, par exemple :

```bash
sudo apt update
```

La commande `sudo` permet d'exécuter une commande en tant que super-utilisateur (root). Elle est très utile pour exécuter des commandes qui nécessitent des privilèges administrateur.

Cette erreur peut être causée par le fait que le paquet `sudo` n'est pas installé sur la machine. Pour l'installer, il suffit d'exécuter la commande suivante :

```bash
apt install sudo
```

Il faut ajouter l'utilisateur au fichier `/etc/sudoers` :

```bash
su -c "echo '<username> ALL=(ALL) ALL' >> /etc/sudoers"
```

Il faut ensuite ajouter l'utilisateur courant au groupe sudo :

```bash
su -
usermod -aG sudo <username>
```

Il faut ensuite se déconnecter et se reconnecter pour que les changements soient pris en compte.

#### Liens utiles

- [Comment modifier le fichier Sudoers](https://www.digitalocean.com/community/tutorials/how-to-edit-the-sudoers-file-fr)