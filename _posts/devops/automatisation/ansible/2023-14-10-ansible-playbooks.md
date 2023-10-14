---
title: Ansible - Les playbooks
date: 2023-09-10 00:00:00  
categories: [devops, automatisation, ansible]
tags: [sysadmin, automatisation, ansible, devops]
---

Les `playbooks` sont des fichiers YAML qui permettent d'automatiser des tâches complexes et récurrentes. Ils sont au coeur d'Ansible et permettent de décrire l'état souhaité des serveurs. 

## Les caractéristiques des playbooks

### Idempotence

Tout comme les commandes `adhoc`, les playbooks sont idempotents. Cela signifie que si on exécute deux fois le même playbook, la deuxième fois, le playbook ne fera rien. L'état de la cible sera le même que l'état souhaité.

### Exécution en parallèle

Les playbooks sont exécutés en parallèle sur tous les serveurs du groupe. Cela permet d'optimiser le temps d'exécution des playbooks.

### Possibilité de tester les playbooks

Il est possible de tester les playbooks avant de les exécuter. Pour cela, il faut ajouter l'option `--check` à la commande. Par exemple, pour tester le playbook `test.yml` :

```bash
ansible-playbook test.yml --check
```

L'intérêt de cette fonctionnalité est de vérifier que le playbook fonctionne correctement avant de l'exécuter. Cela est très utile dans le cas de playbooks complexes.

## Structure d'un playbook

Un `playbook` est composés de `plays` qui sont des listes de tâches à exécuter sur un groupe de serveurs. Chaque `play` est composé de `tasks` qui sont des tâches à exécuter sur les cibles. Chaque `task` est composée de `modules` qui représentent les instructions à exécuter.




### Exécution de playbooks

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