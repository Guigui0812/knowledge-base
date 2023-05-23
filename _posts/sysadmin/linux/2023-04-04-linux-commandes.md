---
title: Les commandes et outils à connaître sous Linux
date: 2023-03-30 00:00:00
categories: [sysadmin, linux]
tags: [sysadmin, linux, commandes, shell, terminal]
---

Notes sur les commandes et outils à connaître sous Linux.

# Les commandes de fichier  

## Rechercher une ligne dans un fichier

```bash
grep <motif> <fichier>
```

**Exemple :**

```bash
grep docker /etc/group
```

# La gestion des groupes et utilisateurs

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
- 