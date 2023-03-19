---
title: Utiliser l'antivirus ClamAV sous Debian
date: 2023-03-19 00:00:00  
categories: [sysadmin, securite]
tags: [sysadmin, securite, antivirus, clamav, debian]
---

## Installation de ClamAV

ClamAV est un antivirus open-source. Il est disponible sous Debian et peut être installé avec la commande `sudo apt install clamav`.

## Configuration de ClamAV

ClamAV est configuré par défaut pour scanner les fichiers dans le répertoire `/home`. Il est possible de scanner d'autres répertoires en modifiant le fichier de configuration `/etc/clamav/clamd.conf`. Il faut modifier la ligne `LocalSocket /var/run/clamav/clamd.ctl` en `LocalSocket /var/run/clamav/clamd.ctl /home /var/www`.

## Utilisation de ClamAV

ClamAV peut être utilisé de différentes manières. Il est possible de scanner un fichier ou un répertoire avec la commande `clamscan <fichier ou répertoire>`. Il est également possible de scanner un fichier ou un répertoire en utilisant le daemon ClamAV avec la commande `clamdscan <fichier ou répertoire>`.

Les options `-r` et `-i` permettent de scanner récursivement et d'ignorer les erreurs. De même, l'option `-l` permet de lister les fichiers infectés.

## Mise à jour de la base de données de ClamAV

ClamAV utilise une base de données pour détecter les virus. Il est nécessaire de mettre à jour cette base de données régulièrement. Pour cela, il faut utiliser la commande `freshclam`.

#### Liens utiles :

- [ClamAV - Debian Wiki](https://wiki.debian.org/fr/ClamAV)
- [Comment installer et utiliser ClamAV sur Linux - Malekal](https://www.malekal.com/comment-installer-et-utiliser-clamav-sur-linux/)