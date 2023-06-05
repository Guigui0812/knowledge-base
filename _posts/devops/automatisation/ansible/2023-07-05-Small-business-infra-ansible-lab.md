---
title: Projet Ansible - Automatisation de la mise en place d'une infrastructure pour une petite entreprise
date: 2023-05-05 00:00:00  
categories: [devops, automatisation, ansible]
tags: [sysadmin, automatisation, ansible, devops, infrastructure, entreprise]
---

Dans un précédent article, j'avais expliqué la [création d'un laboratoire virtuel pour SysAdmin](../../2023-05-04-Creation-lab-virtuel-sysadmin.md) qui permet de représenter l'infrastructure d'une petite entreprise : DHCP, DNS, LDAP, serveur de fichiers, serveur NFS et firewall. Dans cet article, je vais refaire ce laboratoire, mais cette fois-ci avec Ansible.

Mon réseau sera composé de 4 machines virtuelles :
- Un pare-feu (Firewall) pfSense
- Un serveur DNS/DHCP
- Un serveur LDAP/NFS
- Un client pour les tests

Pour Ansible, j'ai décidé d'utiliser mon WSL2 sous Windows 10. Cependant, il est possible d'utiliser n'importe quelle machine Linux, notamment une machine virtuelle supplémentaire.

## Prérequis

Dans un premier temps, il faut installer Ansible sur le serveur qui va orchestrer les tâches. Il faut également paramétrer les serveurs cibles pour qu'ils soient accessibles en SSH depuis le serveur Ansible.

Pour cela, il faut suivre [cet article](../../2023-05-05-Ansible-Setup.md) qui explique les étapes d'installation et de configuration d'Ansible.

## Configuration du serveur DNS/DHCP

Il est possible de configurer de nombreux services avec Ansible. Dans un premier temps je vais commencer par le serveur DNS/DHCP.

Il y a plusieurs manières d'utiliser ***Ansible*** pour configurer un serveur. Mon choix est de créer un playbook par service. Cela permet de séparer les tâches et de pouvoir les réutiliser plus facilement. Chaque playbook est lié à un répertoire dans lequel sont présents certains fichiers de configuration qu'il faut copier sur le serveur cible.

## Déployer un serveur DHCP



