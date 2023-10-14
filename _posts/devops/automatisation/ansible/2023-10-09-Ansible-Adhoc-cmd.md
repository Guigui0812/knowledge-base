---
title: Les commandes adhoc d'Ansible
date: 2023-09-10 00:00:00  
categories: [devops, automatisation, ansible]
tags: [sysadmin, automatisation, ansible, devops]
---

Si Ansible est connu pour ses `playbooks` et l'écriture de `roles` réutilisables, il est également possible d'exécuter des commandes directement sur les serveurs. Ces commandes sont appelées `commandes adhoc`. Ces commandes peuvent être utilisées pour effectuer des tâches simples et non récurrentes, ne nécessitant donc pas l'écriture d'un `playbook` ou d'un `role`. Par exemple on va pouvoir utiliser ces commandes pour mettre à jour les serveurs, créer des utilisateurs, etc.

## Les caractéristiques des commandes adhoc

### Idempotence

Les commandes adhoc sont idempotentes. Cela signifie que si on exécute deux fois la même commande, la deuxième fois, la commande ne fera rien. Par exemple, si on exécute la commande `apt update` deux fois, la deuxième fois, la commande ne fera rien car le système est déjà à jour.

### Exécution en parallèle

Les commandes adhoc sont exécutées en parallèle sur tous les serveurs du groupe. Cela permet d'optimiser le temps d'exécution des commandes.

### Possibilité de tester les commandes

Il est possible de tester les commandes avant de les exécuter. Pour cela, il faut ajouter l'option `--check` à la commande. Par exemple, pour tester la commande `apt update` :

```bash
ansible servers -a "apt update" --check
```

Cette fonctionnalité permet de vérifier que la commande fonctionne correctement avant de l'exécuter. Cela est très utile dans le cas de commandes complexes.


## Utilisation des commandes adhoc

L'utilisation des commmandes est très simple. Pour exécuter une commande sur un groupe de serveur <group>, il faut utiliser la commande `ansible <group> -a "<commande>"`. Par exemple, pour exécuter la commande `apt update` sur tous les serveurs du groupe `servers` :

```bash
ansible servers -a "apt update"
```

On peut distinguer deux types de commandes adhoc : les **commandes** et les **modules**.

Pour exécuter une **commande**, on utilise l'option `-a` de la commande `ansible` comme présenté ci-dessus. 

Pour exécuter un **module**, on utilise l'option `-m` de la commande `ansible` :

```bash
ansible servers -m <module> -a "<arguments>"
```

Par exemple, pour installer le paquet `docker` sur tous les serveurs du groupe `servers` :

```bash
ansible servers -b -m apt -a "name=docker state=latest"
```

Parfois, certains **commandes** et **modules** peuvent nécessiter une élévation de privilèges. Pour cela, il faut ajouter l'option `-b` à la commande `ansible`. Par exemple, pour installer le paquet `docker` sur tous les serveurs du groupe `servers` :

```bash
ansible servers -b -m apt -a "name=docker state=latest"
```

Si on souhaite tester la commande sur un hôte précis avant de l'exécuter sur tous les serveurs du groupe, on peut utiliser l'option `-l` de la commande `ansible`. Par exemple, pour tester la commande `apt update` sur le serveur `server1` :

```bash
ansible servers -b -m apt -a "name=docker state=latest" -l server1
```

## Cas d'usage

### Mettre à jour les serveurs

Pour mettre à jour tous les serveurs du groupe `servers`, on peut utiliser la commande `apt update` :

```bash
ansible servers -a "apt update && apt upgrade -y"
```

On peut également mettre à jour tous les paquets installés en utilisant le module `apt` :

```bash
ansible servers -m apt -a "upgrade=yes"
```

### Créer un utilisateur

Pour créer un utilisateur sur tous les serveurs du groupe `servers`, on peut utiliser la commande `useradd` :

```bash
ansible servers -a "useradd -m -s /bin/bash <username>"
```

On peut également utiliser le module `user` :

```bash
ansible servers -m user -a "name=<username> state=present"
```

### Vérifier la connectivité

Pour vérifier la connectivité avec tous les serveurs du groupe `servers`, on peut utiliser le module `ping` :

```bash
ansible servers -m ping
```

#### Sources et liens utiles

- [Introduction to ad hoc commands - Ansible Doc](https://docs.ansible.com/ansible/latest/command_guide/intro_adhoc.html)
- [ansible.builtin.user module - Ansible Doc](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/user_module.html)
- [Utilisez Ansible pour automatiser vos tâches de configuration - OpenClassrooms](https://openclassrooms.com/fr/courses/2035796-utilisez-ansible-pour-automatiser-vos-taches-de-configuration)
- [Ansible Guide: The Ad-Hoc Command](https://www.howtoforge.com/ansible-guide-ad-hoc-command/)