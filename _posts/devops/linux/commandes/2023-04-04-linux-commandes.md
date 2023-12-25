---
title: Les commandes et outils à connaître sous Linux
date: 2023-03-30 00:00:00
categories: [devops, linux]
tags: [sysadmin, linux, commandes, shell, terminal]
---

Notes sur les commandes et outils à connaître sous Linux.

## Les commandes de fichier  

De nombreuses commandes permettent de manipuler des fichiers et des répertoires.

| -------- | ----------- | ------- |
| `cat` | Afficher le contenu d'un fichier | `cat /etc/passwd` |
| `cp` | Copier un fichier | `cp ~/test ~/tmp` |
| `mv` | Déplacer un fichier | `mv ~/test /tmp` |
| `rm` | Supprimer un fichier | `rm ~/test` |
| `touch` | Créer un fichier | `touch ~/test` |
| `mkdir` | Créer un répertoire | `mkdir /tmp/test` | 
| `rmdir` | Supprimer un répertoire | `rmdir /tmp/test` |
| `ls` | Lister le contenu d'un répertoire | `ls /tmp` |
| `find` | Rechercher un fichier | `find / -name test.txt` |
| `grep` | Rechercher une ligne dans un fichier | `grep docker /etc/group` |
| `wget` | Télécharger un fichier | `wget https://www.google.com` |

## La gestion des groupes et utilisateurs

En tant que système multi-utilisateurs, Linux permet de créer des groupes et des utilisateurs. Les groupes permettent de regrouper des utilisateurs et de leur donner des droits communs. Les utilisateurs peuvent appartenir à plusieurs groupes.

Quelques commandes parmi les plus utiles pour gérer les groupes et les utilisateurs : 

| Commande | Description | Exemple |
| -------- | ----------- | ------- |
| `useradd` | Créer un nouvel utilisateur | `useradd <utilisateur>` |
| `usermod` | Modifier un utilisateur | `usermod -aG <groupe> <utilisateur>` |
| `passwd` | Changer le mot de passe d'un utilisateur | `passwd <utilisateur>` |
| `mkhomedir_helper` | Créer le répertoire personnel d'un utilisateur | `mkhomedir_helper <utilisateur>` |
| `id` | Obtenir l'UID ou le GID d'un utilisateur | `id -u <utilisateur>` ou `id -g <utilisateur>` |
| `su` | Se connecter en tant qu'utilisateur | `su - <utilisateur>` |
| `groupadd` | Créer un groupe | `groupadd <groupe>` |
| `cat /etc/group` | Lister les groupes | `cat /etc/group` |
| `cat /etc/passwd` | Lister les utilisateurs | `cat /etc/passwd` |
| `grep` | Lister les utilisateurs d'un groupe | `grep <groupe> /etc/group` |
| `groups` | Lister les groupes d'un utilisateur | `groups <utilisateur>` |
| `userdel` | Supprimer un utilisateur | `userdel <utilisateur>` |

## Créer un nouvel utilisateur

```bash
useradd <utilisateur>
```

Cette commande ne crée pas le répertoire personnel de l'utilisateur. Il faut utiliser la commande `mkhomedir_helper` pour le créer.

On peut créer automatiquement le répertoire personnel de l'utilisateur en utilisant l'option `-m` :

```bash
useradd -m <utilisateur>
```

On peut également créer le répertoire personnel de l'utilisateur en utilisant l'option `-m` et en spécifiant son nom :

```bash
useradd -m -d /home/<utilisateur> <utilisateur>
```

## Ajouter un utilisateur à un groupe

```bash
usermod -aG <groupe> <utilisateur>
```

## Changer le mot de passe d'un utilisateur

```bash
passwd <utilisateur>
```

## Créer le répertoire personnel d'un utilisateur

```bash
mkhomedir_helper <utilisateur>
```

Il arrive que le répertoire personnel d'un utilisateur ne soit pas créé lors de la création de l'utilisateur. Dans ce cas, il est possible de le créer avec cette commande. De cette manière, l'utilisateur pourra se connecter en SSH et aura les droits sur son répertoire personnel.

## Obtenir l'UID d'un utilisateur

```bash
id -u <utilisateur>
```

## Obtenir le GID d'un utilisateur

```bash
id -g <utilisateur>
```

Also 

```bash
getent group <utilisateur>
```

## Se connecter en tant qu'utilisateur

```bash
su - <utilisateur>
```

## Créer un groupe

```bash
groupadd <groupe>
```

## Lister les groupes

```bash
cat /etc/group
```

## Lister les utilisateurs

```bash
cat /etc/passwd
```

## Lister les utilisateurs d'un groupe

```bash
grep <groupe> /etc/group
```

## Lister les groupes d'un utilisateur

```bash
groups <utilisateur>
```

# Les commandes de gestion du système

## Changer l'hostname

```bash
hostnamectl set-hostname <hostname>
```

## Monter un disque réseau

```bash
sudo mount -t cifs -o username=<utilisateur>,password=<mot de passe> //<adresse IP>/<partage> /mnt/<point de montage>
```

But this is not persistent. You'll have to modify the `/etc/fstab` file to make it persistent.

Open the file `/etc/fstab` :

```bash
sudo nano /etc/fstab
```

Add the following line :

```bash
//<adresse IP>/<partage> /mnt/<point de montage> cifs username=<utilisateur>,password=<mot de passe> 0 0
```

# Les commandes de gestion du réseau

Pour ces commandes il est nécessaire d'installer plusieurs paquets :

- `net-tools` : pour les commandes `ifconfig` et `netstat`
- `dnsutils` : pour la commande `nslookup`

## Tester la connexion à un hôte

```bash
ping <adresse IP>
```

## Connaitre son adresse IP

Version détaillée :

```bash
ip a
```

Version simplifiée :

```bash
ip -br a
```

## Connaitre sa passerelle

```bash
ip route
```

## Connaitre les ports ouverts

```bash
netstat -tulpn
```

## Tester la résolution DNS

Il est nécessaire d'installer le paquet `dnsutils` :

```bash
nslookup <nom de domaine>
```

# Gestion des paquets

## Installer un paquet

```bash
apt install <paquet>
```

## Mettre à jour la liste des paquets

```bash
apt update
```

## Mettre à jour les paquets

```bash
apt upgrade
```

## Mettre à jour les paquets et le système

```bash
apt full-upgrade
```

## Supprimer un paquet

```bash
apt remove <paquet>
```

#### Liens et ressources

- [Les commandes de base - Hostinger](https://www.hostinger.com/tutorials/linux-commands)
- [Redirection de sorties de commandes](https://www.pierre-giraud.com/shell-bash/redirection-gestion-flux/)
- [How to Install and Use dig and nslookup Commands in Linux](https://www.tecmint.com/install-dig-and-nslookup-in-linux/)
- [Créer un utilisateur et son répertoire personnel](https://linuxopsys.com/topics/create-home-directory-existing-user-linux)
- [Lister les groupes](https://linuxize.com/post/how-to-list-groups-in-linux/)
- [Top 50+ Linux Commands You MUST Know - Digital Ocean](https://www.digitalocean.com/community/tutorials/linux-commands)