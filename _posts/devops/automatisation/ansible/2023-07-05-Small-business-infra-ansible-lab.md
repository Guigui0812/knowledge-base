---
title: Ansible automation lab - Small business infrastructure
date: 2023-22-08 00:00:00  
categories: [devops, automatisation, ansible]
tags: [sysadmin, automatisation, ansible, devops, infrastructure]
---

Dans un précédent article, j'avais expliqué la [création d'un laboratoire virtuel pour SysAdmin](../../2023-05-04-Creation-lab-virtuel-sysadmin.md) qui permet de représenter l'infrastructure d'une petite entreprise : DHCP, DNS, LDAP, serveur de fichiers, serveur NFS et firewall. Dans cet article, je vais refaire ce laboratoire, mais cette fois-ci avec Ansible et Vagrant.

Mon réseau sera composé de 4 machines virtuelles :
- Un pare-feu (Firewall) pfSense
- Un serveur DNS/DHCP
- Un serveur LDAP/NFS
- Un client pour les tests

Pour Ansible et Vagrant, j'ai décidé d'utiliser mon WSL2 sous Windows 10 afin de pouvoir tester les playbooks sur mon ordinateur portable.

## Prerequisites

Firstly, we need to install the different tools we will use.

## Vagrant

Depending of the OS you use, the installation process can be different.

As I use WSL2 with Debian 11, I will install Vagrant with the following commands:

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant
```

It is the same procedure for ubuntu. 

For other distributions, you can find the installation instructions [here](https://www.vagrantup.com/docs/installation).

As we need to use Vagrant with VirtualBox, we need to set some environment variables. Depending the shell you use, you need to add some lines in your `.bashrc` or `.zshrc` file :

```bash
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/mnt/c/Users/<user>"
```

In case of issues, you can find more informations [here](https://www.vagrantup.com/docs/other/wsl).

## Installation d'Ansible

Dans un premier temps, il faut installer Ansible sur le serveur qui va orchestrer les tâches. Il faut également paramétrer les serveurs cibles pour qu'ils soient accessibles en SSH depuis le serveur Ansible.

Pour cela, il faut suivre [cet article](../../2023-05-05-Ansible-Setup.md) qui explique les étapes d'installation et de configuration d'Ansible.

## Configuration du serveur DNS/DHCP

Il est possible de configurer de nombreux services avec Ansible. Dans un premier temps je vais commencer par le serveur DNS/DHCP.

Il y a plusieurs manières d'utiliser ***Ansible*** pour configurer un serveur. Mon choix est de créer un playbook par service. Cela permet de séparer les tâches et de pouvoir les réutiliser plus facilement. Chaque playbook est lié à un répertoire dans lequel sont présents certains fichiers de configuration qu'il faut copier sur le serveur cible.

## Déployer un serveur DHCP





#### Usefull links and resources
