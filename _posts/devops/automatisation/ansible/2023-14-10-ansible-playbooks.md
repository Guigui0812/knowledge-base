---
title: Ansible - Les playbooks
date: 2023-10-09 00:00:00  
categories: [devops, automatisation, ansible]
tags: [sysadmin, automatisation, ansible, devops]
---

Les `playbooks` sont des fichiers `YAML` qui permettent d'automatiser des tâches complexes et récurrentes. Ils sont au coeur d'Ansible et permettent de décrire l'état souhaité des serveurs. 

Ils sont exécutés par la commande `ansible-playbook` qui permet d'exécuter les instructions décrites dans le fichier `YAML` via `SSH` sur les serveurs cibles.

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

L'intérêt de cette fonctionnalité est de vérifier que le playbook fonctionne correctement avant de l'exécuter. Cela est très utile dans le cas de playbooks qui installent des paquets assez lourds ou qui modifient des fichiers de configuration.

## Structure d'un playbook

Un `playbook` est composés de `plays` qui sont des listes de tâches à exécuter sur un groupe de serveurs. Chaque `play` est composé de `tasks` qui sont des tâches à exécuter sur les cibles. Chaque `task` est composée de `modules` qui représentent les instructions à exécuter.

De manière générale, un `playbook` est structuré de la manière suivante :

```yaml
---
- name: <name>
  hosts: <hosts>
  become: yes
  become_method: sudo

  tasks:
    - name: <name>
      <module>: <arguments>
```

On peut trouver plusieurs `tasks` dans un `play` :

```yaml
---
- name: <name>
  hosts: <hosts>
  become: yes
  become_method: sudo

  tasks:
    - name: <name>
      <module>: <arguments>
    - name: <name>
      <module>: <arguments>
```

On peut trouver plusieurs `plays` dans un `playbook` :

```yaml
---
- name: <name>
  hosts: <hosts>
  become: yes
  become_method: sudo

  tasks:
    - name: <name>
      <module>: <arguments>

- name: <name>
    hosts: <hosts>
    become: yes
    become_method: sudo
    
    tasks:
        - name: <name>
        <module>: <arguments>
    ```
```

## Les modules

Les `modules` sont les instructions qui permettent d'effectuer des actions sur les serveurs. Ils sont au coeur d'Ansible et permettent d'automatiser des tâches complexes et récurrentes. Il existe de nombreux modules qui permettent de gérer les paquets, les services, les fichiers, les utilisateurs, les groupes, etc.

On peut retrouver ces modules sur le site officiel d'Ansible : [Collection Index - Ansible Documentation](https://docs.ansible.com/ansible/latest/collections/index.html). Dans cette rubrique, on peut retrouver tous les modules disponibles par catégorie (cloud, network, system, etc.).

## Exécution d'un playbook

Pour exécuter un `playbook`, il faut utiliser la commande `ansible-playbook`. Par exemple, pour exécuter le playbook `test.yml` :

```bash
ansible-playbook test.yml
```

On peut utiliser de très nombreuses options avec la commande `ansible-playbook`. La liste des options est disponible dans la documentation officielle : [ansible-playbook - Ansible Documentation](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html).

De manière générale, on utilise les options suivantes :
- `-i` : permet de spécifier le fichier d'inventaire à utiliser
- `-l` : permet de spécifier les serveurs cibles
- `-u` : permet de spécifier l'utilisateur à utiliser pour se connecter aux serveurs cibles
- `-b` : permet d'activer l'élévation de privilèges
- `-K` : permet de demander le mot de passe de l'utilisateur pour se connecter aux serveurs cibles
- `--ask-become-pass` : permet de demander le mot de passe de l'utilisateur pour l'élévation de privilèges
- `--ask-pass` : permet de demander le mot de passe de l'utilisateur pour se connecter aux serveurs cibles
- `--check` : permet de tester le playbook sans l'exécuter
- `--syntax-check` : permet de vérifier la syntaxe du playbook
- `--become` : permet d'activer l'élévation de privilèges

La syntaxe de la commande `ansible-playbook` est la suivante :

```bash
ansible-playbook <playbook> [options]
```

## Utiliser des variables

Il est possible d'utiliser des variables dans les `playbooks`. Cela permet de les rendre plus flexibles et réutilisables. Il existe plusieurs types de variables : les variables globales, les variables de groupe, les variables d'hôte et les variables de rôle.

Pour les variables, l'option importante est `-e` car elle permet de les définir. Par exemple, pour définir la variable `foo` avec la valeur `bar` :

```bash
ansible-playbook test.yml -e "foo=bar"
```

On pourra ensuite utiliser cette variable dans le playbook :

```yaml
---
- name: <name>
  hosts: <hosts>
  become: yes
  become_method: sudo

  tasks:
    - name: <name>
      debug:
        msg: "foo: {{ foo }}"
```

### Les variables globales

Les variables globales sont des variables qui sont définies dans le fichier `ansible.cfg`. Elles sont utilisées par tous les `playbooks` et tous les `roles`. Elles sont définies dans la section `[defaults]` du fichier `ansible.cfg`.

### Les variables de groupe

Les variables de groupe sont des variables qui sont définies dans le fichier d'inventaire. Elles sont utilisées par tous les `playbooks` et tous les `roles`. Elles sont définies dans la section `[group_vars]` du fichier d'inventaire.

### Les variables d'hôte

Les variables d'hôte sont des variables qui sont définies dans le fichier d'inventaire. Elles sont utilisées par tous les `playbooks` et tous les `roles`. Elles sont définies dans la section `[host_vars]` du fichier d'inventaire.

### Les variables de rôle

Les variables de rôle sont des variables qui sont définies dans le dossier `vars` du `role`. Elles sont utilisées par le `role` dans lequel elles sont définies. Elles sont définies dans le fichier `main.yml` du dossier `vars` du `role`.

### Les variables du playbook

Les variables du playbook sont des variables qui sont définies dans le `playbook`. Elles sont utilisées par le `playbook` dans lequel elles sont définies. Elles sont définies dans la section `vars` du `playbook` : 

```yaml
---
- name: <name>
  hosts: <hosts>
  become: yes
  become_method: sudo

  vars:
    <variable>: <value>

  tasks:
    - name: <name>
      <module>: <arguments>
```

### Stocker le résultat d'un module dans une variable

Il est possible de stocker le résultat d'un module dans une variable. Pour cela, il faut utiliser l'option `register` :

```yaml
---
- name: <name>
  hosts: <hosts>
  become: yes
  become_method: sudo

  tasks:
    - name: <name>
      <module>: <arguments>
      register: <variable>
```

Cela est très utile pour utiliser le résultat d'un module dans un autre module. 

### Les ansibles facts

Les `ansible facts` sont des variables qui sont définies par Ansible. Elles sont automatiquement découvertes par **Ansible** sauf si on désactive cette fonctionnalité avec l'option `gather_facts: no` dans le `playbook`.

Par exemple, on peut récupérer le nom de l'hôte avec la variable `ansible_hostname` :

```yaml
---
- name: <name>
  hosts: <hosts>
  become: yes
  become_method: sudo

  tasks:
    - name: <name>
      debug:
        msg: "Hostname: {{ ansible_hostname }}"
```

## Les handlers

Les `handlers` sont des tâches qui sont exécutées uniquement si une `task` a modifié l'état d'un serveur. Ils sont très utiles pour redémarrer un service uniquement si une `task` a modifié un fichier de configuration.

Pour utiliser un `handler`, il faut l'appeler dans une `task` avec l'option `notify` :

```yaml
---
- name: <name>
  hosts: <hosts>
  become: yes
  become_method: sudo

  tasks:
    - name: <name>
      <module>: <arguments>
      notify: <handler>

  handlers:
    - name: <name>
      <module>: <arguments>
```

Par exemple, on va pouvoir démarrer un service directement après l'avoir installé :

```yaml
---
- name: <name>
  hosts: <hosts>
  become: yes
  become_method: sudo

  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
      notify: Start nginx

  handlers:
    - name: Start nginx
      service:
        name: nginx
        state: started
```


#### Liens et ressources utiles :

- [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
- [Ansible Documentation - Collection Index](https://docs.ansible.com/ansible/latest/collections/index.html)
- [Ansible Documentation - ansible-playbook](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)
- [Ansible Documentation - Variables](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html)