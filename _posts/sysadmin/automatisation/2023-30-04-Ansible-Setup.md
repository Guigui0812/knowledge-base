---
title: Installer et configurer Ansible
date: 2023-05-05 00:00:00  
categories: [sysadmin, automatisation, ansible]
tags: [sysadmin, automatisation, ansible, devops]
---

## Présentation

Ansible est un outil d'automatisation open-source qui permet de déployer des applications, de gérer des configurations et d'orchestrer des tâches.

## Installation

L'installation d'Ansible peut être un peu particulière selon la distribution Linux utilisée. Pour Debian, il ne suffit pas d'exécuter la commande `apt install ansible`. Il faut ajouter le dépôt `ppa:ansible/ansible` et installer le paquet `ansible` :

```bash
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

Il est important de suivre cette étape, car sinon il n'y aura pas les fichiers de configuration nécessaires à Ansible dans `/etc/ansible`.

## Configuration

Pour utiliser Ansible, il faut à minima : 

- Un serveur Ansible (appelé *control node*)
- Un ou plusieurs serveurs cibles (appelés *managed nodes*)

Pour que Ansible puisse se connecter aux serveurs cibles, il faut que les serveurs cibles soient accessibles en SSH depuis le serveur Ansible. Il faut donc que les serveurs cibles aient un serveur SSH installé et configuré. Il faut également mettre en place une paire de clés SSH pour chaque serveur cible et les ajouter au serveur Ansible.

**Rappel** : Pour générer une paire de clés SSH, il faut exécuter la commande `ssh-keygen` sur le serveur Ansible. Pour mettre la clé publique sur le serveur cible, il faut exécuter la commande `ssh-copy-id <user>@<ip>` sur le serveur Ansible.

Lorsque les clés sont ajoutées, il faut tester la connexion SSH depuis le serveur Ansible vers le serveur cible :

```bash
ssh <user>@<ip>
```

Si la clé fonctionne, on peut ajouter le serveur cible dans le fichier `/etc/ansible/hosts`. Pour cela, on utilise `sudo nano /etc/ansible/hosts`.
```

Il faut ajouter le serveur cible dans la section `[servers]` :

```bash
[servers]
<ip>
```
