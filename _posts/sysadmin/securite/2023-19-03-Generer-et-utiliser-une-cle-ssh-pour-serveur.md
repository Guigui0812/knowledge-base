---
title: Générer et utiliser une clé SSH pour accéder à un serveur
date: 2023-03-24 00:00:00
categories: [sysadmin, securite]
tags: [sysadmin, securite, ssh, cle, serveur]
---

Une clé SSH permet d'accéder à un serveur sans avoir à saisir un mot de passe. Il est possible de la générer sur son ordinateur et de l'ajouter au serveur pour pouvoir s'y connecter sans avoir à saisir de mot de passe.

## Générer une clé SSH

Pour générer une clé SSH, il faut utiliser la commande `ssh-keygen`. Cette commande va générer une paire de clés : une clé privée et une clé publique. La clé privée doit être conservée secrète et ne doit pas être partagée. La clé publique peut être partagée et utilisée pour accéder à un serveur.

Il est possible de générer une clé SSH avec une passphrase. Une passphrase est une phrase de passe qui permet de protéger la clé privée. Il est possible de générer une clé SSH sans passphrase en utilisant l'option `-N ""`.

Il est possible de spécifier le type de clé SSH à générer en utilisant l'option `-t`. Il est possible de générer une clé SSH de type RSA, DSA, ECDSA ou ED25519. De plus, il est possible de spécifier la taille de la clé en utilisant l'option `-b`. Par défaut, la taille de la clé est de 2048 bits.

Enfin, on peut préciser le fichier dans lequel la clé privée sera enregistrée en utilisant l'option `-f`. Par défaut, la clé privée est enregistrée dans le fichier `~/.ssh/id_rsa` et la clé publique dans le fichier `~/.ssh/id_rsa.pub`.

### Exemple : 

```bash
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
```

## Ajouter une clé SSH au serveur

Pour ajouter une clé SSH au serveur, il faut utiliser la commande `ssh-copy-id`. Cette commande va ajouter la clé publique au fichier `authorized_keys` du serveur.

Exemple : 

```bash
ssh-copy-id -i ~/.ssh/mykey user@host
```

Cependant, si le fichier `authorized_keys` n'existe pas, il faut le créer. Pour cela, il faut utiliser suivre les étapes suivantes : 

- Ouvrir un terminal sur la machine locale.
- Taper `cat ~/.ssh/id_rsa.pub` et appuyer sur Entrée pour afficher la clé publique.
- Copier l'intégralité de la sortie de la commande dans le presse-papiers.
- Se connecter au serveur à l'aide d'un client SSH.
- Accéder au répertoire utilisateur sur le serveur en tapant `cd ~`.
- Créer un répertoire `.ssh` s'il n'existe pas déjà en tapant `mkdir -p ~/.ssh`.
- Modifier les permissions du répertoire .ssh en tapant `chmod 700 ~/.ssh`.
- Créer un fichier nommé `authorized_keys` dans le répertoire `.ssh` en tapant `touch ~/.ssh/authorized_keys`.
- Modifier les permissions du fichier `authorized_keys` en tapant `chmod 600 ~/.ssh/authorized_keys`.
- Ouvrir le fichier `authorized_keys` dans un éditeur de texte en tapant `nano ~/.ssh/authorized_keys`.
- Coller le contenu de la clé publique copiée depuis la machine locale dans l'éditeur de texte et enregistrer le fichier.
- Fermer l'éditeur de texte et se déconnecter du serveur.
- Se reconnecter au serveur en utilisant le client SSH. Il est désormais possible de s'authentifier sur le serveur en utilisant la nouvelle paire de clés SSH.

De même, si le serveur est paramétrer pour n'accepter que les connexions par clé SSH, il faut copier la clé générée sur le PC local dans le fichier `authorized_keys` du serveur afin de pouvoir s'y connecter depuis le PC local.

## Désactiver la connexion par mot de passe pour un utilisateur

Il est possible de désactiver la connexion par mot de passe pour un utilisateur. Pour cela, il faut modifier le fichier `/etc/ssh/sshd_config` et remplacer la ligne `PasswordAuthentication yes` par `PasswordAuthentication no`.

Enfin, pour que les modifications soient prises en compte, il faut redémarrer le service SSH avec la commande `sudo systemctl restart ssh`.

#### Liens utiles :

- [How to set up ssh keys - Hostinger ](https://www.hostinger.com/tutorials/ssh/how-to-set-up-ssh-keys)
- [How to use ssh keys with a VPS - Hostinger](https://support.hostinger.com/en/articles/4792364-how-to-use-ssh-keys-at-vps)
- [SSH Academy](https://www.ssh.com/academy/ssh/copy-id#copy-the-key-to-a-server)