---
title: Linux : concepts et généralités
date: 2023-03-30 00:00:00
categories: [devops, linux]
tags: [sysadmin, linux]
---

Linux est un système d'exploitation libre et open-source. Il est basé sur le noyau Linux et est utilisé dans de nombreux domaines : serveurs, téléphones, tablettes, ordinateurs, etc. 

Linux est multi-utilisateurs et multi-tâches. Il permet de faire fonctionner plusieurs programmes en même temps et de gérer plusieurs utilisateurs. Il est également multi-plateformes et peut fonctionner sur de nombreuses architectures : x86, x86_64, ARM, Itanium, PowerPC, etc.

Il existe de nombreuses distributions Linux. Les plus connues sont : Ubuntu, Debian, Fedora, CentOS, etc. On peut les classer en 3 grandes familles : Debian, Red Hat et SUSE. On peut également citer Arch Linux qui est une distribution très légère et personnalisable (mais qui nécessite des connaissances avancées).

# Les différentes familles et distributions

## Red Hat Enterprise Linux (RHEL)

- Famille la plus utilisée dans le monde professionnel
- Basée sur le système de paquets RPM (Red Hat Package Manager)
- Utilise le système de gestion de paquets YUM (Yellowdog Updater Modified)
- Distributions les plus connues : Red Hat Enterprise Linux (RHEL), CentOS, Fedora, Oracle Linux, etc.
- Fedora est la distribution communautaire de Red Hat: utilisée pour tester les nouvelles fonctionnalités qui seront intégrées dans RHEL et par les développeurs pour tester leurs applications.
- Support des architectures x86_64, AARM, Itanium et PowerPC (architectures de processeurs les plus utilisées dans les serveurs du monde professionnel)

**Remarque** : Pour un usage personnel, il est recommandé d'utiliser CentOS qui est une distribution gratuite et open-source basée sur RHEL. Cependant, CentOS 8 n'est plus maintenue par Redhat depuis 2021. Il est donc préférable d'utiliser CentOS Stream 8 qui est une distribution en amont de RHEL.

## Debian

- Famille la plus utilisée dans le monde personnel
- Basée sur le système de paquets DEB (Debian Package Manager)
- Utilise le système de gestion de paquets APT (Advanced Package Tool)
- Distributions les plus connues : Debian, Ubuntu, Linux Mint, etc.
- Debian est la distribution communautaire Open Source. 
- Ubuntu est la distribution la plus utilisée et est elle même basée sur Debian. Elle est donc très utilisée pour des usages personnels et à destination des débutants.

**Remarque** : Entre un système Debian et un système Ubuntu, il n'y a pas de différence majeure. Cependant, Debian sera considérée comme plus stable et plus sécurisée. Ubuntu sera considérée comme plus simple à utiliser et plus adaptée aux débutants. Debian vient également avec moins de logiciels pré-installés.

# Généralités et concepts de Linux

## Notions clés

**Le noyau (Kernel)** : c'est le coeur du système d'exploitation. Il est responsable de la gestion des ressources matérielles et de l'interaction avec les logiciels. Il est responsable de la gestion des processus, de la mémoire, des périphériques, des systèmes de fichiers, etc. Il est également responsable de la sécurité du système. Linux est le noyau utilisé dans les systèmes d'exploitation Linux. Il est développé par Linus Torvalds et est open-source.

**Distribution** : c'est un ensemble de logiciels qui sont installés sur un système d'exploitation. Il existe de nombreuses distributions Linux. Elles sont basées sur le noyau Linux et sont composées de logiciels libres et open-source. Elles sont généralement composées d'un système de paquets qui permet de gérer les logiciels installés sur le système.

**Boot loader** : c'est un logiciel qui permet de démarrer le système d'exploitation. Il est généralement installé sur le disque dur et est lancé au démarrage de l'ordinateur. Il permet de charger le noyau Linux et de lancer le système d'exploitation. Les plus connus sont GRUB et ISOLINUX.

**Services** : ce sont des programmes qui s'exécutent en arrière-plan et qui permettent de fournir des fonctionnalités au système d'exploitation. Ils sont généralement lancés au démarrage du système d'exploitation. Ils peuvent être lancés par l'utilisateur ou par le système d'exploitation. Quelques exemples sont : le serveur web Apache, le serveur de base de données MySQL, docker, sshd (serveur SSH), ftpd (serveur FTP), dhcpd (serveur DHCP), named (serveur DNS), httpd (serveur HTTP), etc.

**Systèmes de fichiers** : c'est la manière dont les fichiers sont organisés sur le disque dur. Il existe de nombreux systèmes de fichiers. Les plus connus sont : ext2, ext3, ext4, XFS, Btrfs, NTFS, FAT32, etc. Ces systèmes de fichiers sont généralement utilisés pour les disques durs et définissent la manière dont les fichiers sont stockés sur le disque dur. Il existe également des systèmes de fichiers utilisés pour les systèmes de fichiers réseaux (NFS, SMB, etc.).

**Ligne de commande** : c'est un outil qui permet d'interagir avec le système d'exploitation. Il permet d'exécuter des commandes qui vont interagir avec le système d'exploitation.Il permet de lancer des programmes, de gérer les fichiers, de gérer les utilisateurs, de gérer les services, etc.

**Shell** : c'est un programme qui permet d'interpréter les commandes saisies dans la ligne de commande afin d'exécuter des tâches. Il existe de nombreux shells. Les plus connus sont : bash, zsh, csh, ksh, etc. Le shell le plus utilisé est bash. Il est utilisé par défaut dans la plupart des distributions Linux.

**Tout est fichier** : dans Linux, tout est considéré comme un fichier. Les fichiers sont organisés dans une arborescence. Le fichier racine est `/`. Les fichiers sont organisés dans des dossiers (ou répertoires). Cependant, même un répertorie est considéré comme un fichier. Il existe des fichiers spéciaux qui permettent d'interagir avec les périphériques (disque dur, clavier, souris, etc.). Il existe également des fichiers spéciaux qui permettent d'interagir avec les processus (processus en cours d'exécution, processus en attente, etc.).

## Le processus de démarrage

Les étapes du processus de démarrage sont les suivantes :
- Le BIOS (Basic Input/Output System) est exécuté au démarrage de l'ordinateur. Il permet de vérifier le matériel et de charger le boot loader. Pour cela, il effectue le POST (Power-On Self-Test) qui permet de vérifier le matériel. 
- Le BIOS recherche le boot loader sur les périphériques de stockage bootables (disque dur, clé USB, CD-ROM, etc.) qui sont à sa disposition. Il charge le boot loader dans la mémoire RAM et lui transfère le contrôle. Ce boot loader peut être GRUB ou ISOLINUX.
- Le boot loader charge le noyau Linux dans la mémoire RAM et lui transfère le contrôle.
- Le noyau Linux charge les services et les programmes nécessaires au démarrage du système d'exploitation. Il charge également les pilotes nécessaires au fonctionnement du matériel. Il transfère ensuite le contrôle au processus init (`/sbin/init`). C'est le processus parent et il a le PID 1. 
- Le processus init lance les services et les programmes nécessaires au démarrage du système d'exploitation. Il lance également les processus qui permettent à l'utilisateur de se connecter au système d'exploitation. Il transfère ensuite le contrôle à l'utilisateur.

## Systemd et le processus init

Les services sont gérés par le processus init. Il existe plusieurs implémentations de ce processus. Les plus connues sont : SysVinit, Upstart et Systemd.

C'est systemd qui est utilisé par défaut dans la plupart des distributions Linux. Il est chargé de lancer les services et les programmes nécessaires au démarrage du système d'exploitation. C'est par son intermédiaire qu'il est possible de gérer les services avec la commande `systemctl`.

*Exemples de commandes :* 

```bash	
# Afficher l'état d'un service
systemctl status <service>

# Démarrer un service
systemctl start <service>

# Arrêter un service
systemctl stop <service>

# Redémarrer un service
systemctl restart <service>

# Désactiver un service
systemctl disable <service>

# Activer un service
systemctl enable <service>
```

## Système de fichiers et partitions

### Système de fichiers

**Système de fichiers** : c'est une manière de stocker les fichiers sur un disque dur. Il existe de nombreux systèmes de fichiers. Les plus connus sont : ext2, ext3, ext4, XFS, Btrfs, NTFS, FAT32, etc. Ces systèmes de fichiers sont généralement utilisés pour les disques durs et définissent la manière dont les fichiers sont stockés sur le disque dur. Il existe également des systèmes de fichiers utilisés pour les systèmes de fichiers réseaux (NFS, SMB, etc.).

Les différences entre les systèmes de fichiers sont les suivantes :
- La manière dont le stockage est optimisé (taille des blocs, taille des inodes, etc.)
- La taille que peut faire un fichier (16 To pour ext4)
- La taille maximale du système de fichiers (16 To pour ext4)

Un meilleur système de fichier est synonyme de meileures performances de stockage et de fiabilité. 

### Partitions

**Partition** : c'est une partie d'un disque dur. Un disque dur peut être divisé en plusieurs partitions. Chaque partition peut être formatée avec un système de fichiers différent. Il existe de nombreux types de partitions. Les plus connus sont : MBR (Master Boot Record), GPT (GUID Partition Table), etc.

### Les différences entre Windows et Linux

Selon le système d'exploitation, les partitions et systèmes de fichiers seront différents : 

|     | Windows | Linux |
| --- | ------- | ----- |
| Partition | Disk1 | /dev/sda1 |
| Système de fichiers | NTFS /VFAT | ext4 / XFS |
| Fichier racine | C:\ | / |
| Méthode de montage | Lettre de lecteur | Point de montage |

### La hiérarchie du système de fichiers

De manière générale, le système de fichiers est organisé de la manière suivante :

| Répertoire | Description |
| ---------- | ----------- |
| / | Racine du système de fichiers. Tous les répertoires et fichiers résident dans celui-ci. |
| /bin | Contient les fichiers binaires essentiels et les commandes utilisées par le système et les utilisateurs pour démarrer le système et effectuer des tâches critiques. |
| /boot | Contient les fichiers nécessaires au démarrage du système, tels que les fichiers de configuration de GRUB et les noyaux du système. |
| /dev | Contient les fichiers de périphériques qui représentent des matériels et des périphériques connectés au système. |
| /etc | Contient les fichiers de configuration système et les scripts utilisés par le système et les applications. |
| /home | Répertoire personnel des utilisateurs, où ils stockent leurs fichiers personnels, leurs configurations et leurs données. |
| /lib | Contient les bibliothèques partagées essentielles nécessaires au fonctionnement du système et des applications. |
| /media | Emplacement où les supports amovibles tels que les clés USB, les disques externes sont montés automatiquement. |
| /mnt | Répertoire de montage temporaire pour monter d'autres systèmes de fichiers ou dispositifs. |
| /opt | Contient des logiciels et des packages optionnels, généralement installés par l'utilisateur. |
| /proc | Fournit une interface pour accéder aux informations du noyau en tant que fichiers, permettant aux programmes d'obtenir des données sur l'état du système. |
| /root | Répertoire personnel de l'utilisateur root (administrateur). |
| /run | Contient des fichiers de données volatiles pour les applications en cours d'exécution et d'autres fichiers temporaires. |
| /sbin | Contient les fichiers binaires essentiels pour la gestion et la maintenance du système, généralement réservés à l'administrateur. |
| /srv | Contient des données spécifiques aux services fournis par le système. |
| /sys | Fournit une interface pour interagir avec le noyau Linux, en tant que fichiers, pour accéder aux informations et régler certains paramètres du noyau. |
| /tmp | Répertoire temporaire pour les fichiers temporaires créés par le système et les utilisateurs. |
| /usr | Contient des données pour les programmes et fichiers non essentiels au démarrage du système. |
| /var | Contient des données variables, y compris les fichiers journaux, les bases de données, les courriels, les fichiers spool, etc. |