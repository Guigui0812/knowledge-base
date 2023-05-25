---
title: Présentation, installation et configuration d'Ansible
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

### Configuration du serveur Ansible

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

On peut créer des groupes de serveurs en ajoutant des sections dans le fichier `/etc/ansible/hosts`. Par exemple, pour créer un groupe `web` :

```bash
[web]
<ip> <hostname>

[bdd]
<ip> <hostname>
```

Un serveur peut appartenir à plusieurs groupes. Par exemple un groupe `servers` général et un groupe `web` plus spécifique. Ceci est utile pour exécuter des commandes sur un groupe de serveurs spécifique (par exemple pour déployer une application web sur les serveurs du groupe `web` et mettre à jour les paquets sur tous les serveurs du groupe `servers`).

## Test de la connexion SSH

Pour tester la connexion SSH depuis Ansible vers le serveur cible, on peut exécuter la commande `ansible all -m ping`. Si la connexion fonctionne, on devrait avoir un résultat similaire à celui-ci :

```bash
<ip> | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

## Exécution de commandes

Pour exécuter une commande sur tous les serveurs du groupe `servers`, il faut exécuter la commande `ansible servers -a "<commande>"`. Par exemple, pour mettre à jour tous les serveurs du groupe `servers` :

```bash
ansible servers -a "apt update && apt upgrade -y"
```

## Exécution de playbooks

Un playbook est un fichier YAML qui contient une liste de tâches à exécuter. Pour exécuter un playbook, il faut utiliser la commande `ansible-playbook <playbook>.yml`. Par exemple, pour exécuter le playbook `test.yml` :

```bash
ansible-playbook test.yml
```

Cependant, il peut être nécessaire d'avoir des droits `sudo` pour exécuter certaines tâches. Pour cela, il faut ajouter `become: yes` dans le playbook. Par exemple :

De plus, un mot de passe peut être demandé pour exécuter certaines tâches. Pour cela, il faut ajouter `become_method: sudo` dans le playbook. Par exemple :

```yaml
- name: Test
  hosts: servers
  become: yes
  become_method: sudo
  tasks:
    - name: Test
      command: apt update && apt upgrade -y
```

Dans ce cas, il faut exécuter la commande `ansible-playbook <playbook>.yml --ask-become-pass`.

#### Liens et ressources

- [Ansible Documentation](https://docs.ansible.com/)
- [Install Docker on Debian with Ansible](https://yasha.solutions/install-docker-on-debian-with-ansible/)
- 