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

## Ajouter un utilisateur à un groupe

```bash
usermod -aG <groupe> <utilisateur>
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

https://www.hostinger.com/tutorials/linux-commands
https://www.pierre-giraud.com/shell-bash/redirection-gestion-flux/
[How to Install and Use dig and nslookup Commands in Linux](https://www.tecmint.com/install-dig-and-nslookup-in-linux/)