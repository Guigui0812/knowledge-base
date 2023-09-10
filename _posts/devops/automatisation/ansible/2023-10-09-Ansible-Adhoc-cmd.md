---
title: Les commandes adhoc d'Ansible
date: 2023-09-10 00:00:00  
categories: [devops, automatisation, ansible]
tags: [sysadmin, automatisation, ansible, devops]
---

Si la configuration d'Ansible est un peu longue, il est possible d'utiliser des commandes adhoc pour effectuer des tâches simples. Cela permet de gagner du temps et de ne pas avoir à créer un playbook pour une tâche simple.

Typiquement, on va pouvoir créer des utilisateurs, leur octroyer des droits, générer des clés SSH, etc. L'intérêt c'est de configurer plusieurs serveurs en même temps avec une seule commande.

Pour facilier la configuration, on va toujours utiliser l'utilisateur `root` pour se connecter aux serveurs dans un premier temps. Ensuite, on pourra créer un utilisateur avec les droits sudo qui sera utilisé par `ansible` pour les commandes adhoc et les playbooks.

## Créer un utilisateur

Pour créer un utilisateur, il faut exécuter la commande suivante :

```bash
ansible -i <inventory> -m user -a 'name=<user_name> state=present groups="sudo,<user_name>" append=yes' --become --ask-become-pass -u <default_user> --ask-pass <group>
```

Ici, nous avons créer un utilisateur `user_name` qui appartient au groupe `sudo` et à son propre groupe. Il faut bien penser à ajouter l'utilisateur au groupe `sudo` pour qu'il puisse utiliser la commande `sudo` lors de l'exécution des playbooks.

## Générer une clé SSH

Afin de générer une clé SSH et la copier sur un ensemble de serveurs qui seront administrés par Ansible, il faut d'abord générer une clé SSH sur le serveur Ansible avec la commande suivante :

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/<key_name>
```

Lorsqu'elle est générée, il faut copier la clé publique sur les serveurs cibles avec l'aide d'Ansible :

```bash
ansible -i <inventory> -m authorized_key -a 'user=<user_name> key="{{ lookup("file", "~/.ssh/<key_name>.pub") }}"' --become --ask-become-pass -u <default_user> --ask-pass <group>
```

Grâce à cette commande adhoc, on peut copier la clé publique sur tous les serveurs cibles en une seule commande.

#### Sources et liens utiles

- [Introduction to ad hoc commands - Ansible Doc](https://docs.ansible.com/ansible/latest/command_guide/intro_adhoc.html)
- - [Utilisez Ansible pour automatiser vos tâches de configuration - OpenClassrooms](https://openclassrooms.com/fr/courses/2035796-utilisez-ansible-pour-automatiser-vos-taches-de-configuration)