---
title: Ansible - Installation et configuration
date: 2023-05-05 00:00:00  
categories: [devops, automatisation, ansible]
tags: [sysadmin, automatisation, ansible, devops]
---

Ansible est un outil d'automatisation open-source qui permet de déployer des applications, de gérer des configurations et d'orchestrer des tâches sur plusieurs serveurs en même temps. Il permet de gagner du temps et de l'argent en automatisant des tâches répétitives. Il n'utilise aucun agent sur les serveurs cibles, mais uniquement `SSH` pour se connecter et exécuter des tâches en utilisant `python`. Les tâches exécutées par Ansible sont appelées des *playbooks*, qui se composent de *modules*. Ces modules peuvent être assemblés pour créer des *rôles* qui sont des unités de configuration réutilisables.

Ansible s'installe sur un serveur appelé *control node*. Il permet de se connecter à des serveurs cibles appelés *managed nodes* pour exécuter des tâches. Il est possible de se connecter à plusieurs serveurs cibles en même temps pour exécuter des tâches sur tous les serveurs cibles en même temps.

## Installation

### Prérequis

Dans un premier temps, il faut s'assurer que Python est installé sur le serveur Ansible. Pour cela, il faut exécuter la commande `python --version`. Si Python n'est pas installé, il faut l'installer avec la commande :

```bash	
apt install python
```

**Remarque** : On peut penser à installer `virtualenv` pour créer un environnement virtuel Python. Pour cela, il faut exécuter la commande suivante :

```bash
apt install python3-virtualenv
```

L'intérêt sera de cloisonner l'environnement Ansible afin d'éviter la dépréciation automatique de certains scripts Ansible.

### Installation d'Ansible

#### Basique

L'installation d'Ansible peut être un peu particulière selon la distribution Linux utilisée. Pour **Debian**, il ne suffit pas d'exécuter la commande `apt install ansible`. Il faut ajouter le dépôt `ppa:ansible/ansible` et installer le paquet `ansible` :

```bash
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

Il est important de suivre cette étape, car sinon il n'y aura pas les fichiers de configuration nécessaires à Ansible dans `/etc/ansible`.

Pour les systèmes **CentOS** ou **RedHat**, il faut exécuter la commande `yum install ansible-core`.

Une fois Ansible installé, il faut vérifier que la commande `ansible --version` fonctionne. Si c'est le cas, on peut passer à la configuration d'Ansible.

#### Avec un environnement virtuel

Si l'on souhaite installer Ansible dans un environnement virtuel, il faut exécuter les commandes suivantes :

```bash
virtualenv -p python3 venv
source venv/bin/activate
pip install ansible
```

On peut ensuite vérifier que la commande `ansible --version` fonctionne. Si c'est le cas, on peut passer à la configuration d'Ansible.

## Configuration

Pour utiliser Ansible, il faut à minima : 

- Un serveur Ansible (appelé *control node*)
- Un ou plusieurs serveurs cibles (appelés *managed nodes*)

### Préparation du serveur Ansible

### Configuration SSH manuelle

Pour que Ansible puisse se connecter aux serveurs cibles, il faut que les serveurs cibles soient accessibles en SSH depuis le serveur Ansible. Il faut donc que les serveurs cibles aient un serveur SSH installé et configuré. 

Pour cela, on va créer un utilisateur `ansible` sur le **control node** et sur les **managed nodes**. Cet utilisateur sera utilisé pour se connecter aux serveurs cibles et exécuter les tâches. 

On crée donc et utilisateur `ansible` sur les serveurs avec la commande `sudo useradd -m ansible -g sudo -s /bin/bash`. Sur les distributions **RedHat** ou **CentOS**, il faut utiliser la commande `sudo useradd -m ansible -g wheel -s /bin/bash` car le groupe `sudo` n'existe pas, mais le groupe `wheel` est équivalent.


Il est important d'ajouter l'utilisateur au groupe `sudo` pour qu'il puisse effectuer une élévation de privilèges lorsque les `playbooks` le requièrent.
Pour cela, on aurait aussi pu éditer le fichier `/etc/sudoers` avec la commande `visudo` et ajouter la ligne `ansible ALL=(ALL) NOPASSWD:ALL`. L'intérêt de cette solution est qu'elle peut permettre d'être plus précis sur les droits accordés à l'utilisateur `ansible`.

Dans un second temps, il faut mettre en place une paire de clés SSH pour chaque serveur cible et les ajouter au serveur Ansible.

Pour générer une paire de clés SSH, il faut exécuter la commande `ssh-keygen` sur le serveur en tant que l'utilisateur `ansible`. Il faut ensuite copier la clé publique sur la cible avec la commande `ssh-copy-id <user>@<ip>`. Dans un second temps, il faut exécuter la commande `ssh-copy-id <user>@<ip>` depuis le **control node** afin de copier la clé publique sur le **managed node**.

Voici la suite de commandes à exécuter pour générer une paire de clés SSH et les copier sur le serveur cible :

```bash
ssh-keygen -t rsa -b 2048
ssh-copy-id -i ~/.ssh/id_rsa <user>@<ip>
```

Dans le cadre d'un laboratoire, il est plus intéressant de ne pas associer de mot de passe à la clé SSH. Cela permet de ne pas avoir à saisir de mot de passe lors de la connexion SSH. Cependant, dans un cadre professionnel, il est préférable d'ajouter un mot de passe à la clé SSH pour des raisons de sécurité.

Lorsque les clés sont ajoutées, il faut tester la connexion SSH depuis le serveur Ansible vers le serveur cible :

```bash
ssh <user>@<ip>
```

S'il y a un mot de passe à saisir, il ne faut pas oublier d'utiliser l'option `--ask-pass` lors de l'exécution d'une commande ou d'un playbook Ansible.

Si la configuration d'Ansible est un peu longue, il est possible d'utiliser des commandes adhoc pour effectuer des tâches simples. Cela permet de gagner du temps et de ne pas avoir à créer un playbook pour une tâche simple.

Typiquement, on va pouvoir créer des utilisateurs, leur octroyer des droits, générer des clés SSH, etc. L'intérêt c'est de configurer plusieurs serveurs en même temps avec une seule commande.

Pour facilier la configuration, on va toujours utiliser l'utilisateur `root` pour se connecter aux serveurs dans un premier temps. Ensuite, on pourra créer un utilisateur avec les droits sudo qui sera utilisé par `ansible` pour les commandes adhoc et les playbooks. 

**Bonne pratique :** Lorsque la configuration est terminée, il faut désactiver la connexion par mot de passe pour l'utilisateur `root` et activer la connexion par clé SSH pour l'utilisateur `ansible`. Cette opération s'effectuer en éditant le fichier `/etc/ssh/sshd_config` et en modifiant la ligne `PasswordAuthentication yes` par `PasswordAuthentication no`. On peut aussi désactiver le login pour l'utilisateur `root` en modifiant la ligne `PermitRootLogin yes` par `PermitRootLogin no`. Il faut ensuite redémarrer le service SSH avec la commande `sudo systemctl restart ssh`.

### Configuration SSH automatisée

#### Créer un utilisateur

Pour créer un utilisateur, il faut exécuter la commande suivante :

```bash
ansible -i <inventory> -m user -a 'name=<user_name> state=present groups="sudo,<user_name>" append=yes' --become --ask-become-pass -u <default_user> --ask-pass <group>
```

Ici, nous avons créer un utilisateur `user_name` qui appartient au groupe `sudo` et à son propre groupe. Il faut bien penser à ajouter l'utilisateur au groupe `sudo` pour qu'il puisse utiliser la commande `sudo` lors de l'exécution des playbooks.

#### Générer une clé SSH

Afin de générer une clé SSH et la copier sur un ensemble de serveurs qui seront administrés par Ansible, il faut d'abord générer une clé SSH sur le serveur Ansible avec la commande suivante :

```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/<key_name>
```

Lorsqu'elle est générée, il faut copier la clé publique sur les serveurs cibles avec l'aide d'Ansible :

```bash
ansible -i <inventory> -m authorized_key -a 'user=<user_name> key="{{ lookup("file", "~/.ssh/<key_name>.pub") }}"' --become --ask-become-pass -u <default_user> --ask-pass <group>
```

Grâce à cette commande adhoc, on peut copier la clé publique sur tous les serveurs cibles en une seule commande.

### Configuration du fichier d'inventaire

Dans le répertoire `/etc/ansible/`, on retrouve les fichiers de configuration d'Ansible. Le fichier `ansible.cfg` contient la configuration générale d'Ansible. Le fichier `hosts` contient la liste des serveurs cibles.


Si la clé fonctionne et que l'on peut se connecter au serveur via `SSH`, il reste à ajouter le serveur cible dans le fichier d'inventaire `/etc/ansible/hosts`.

Il faut ajouter le serveur cible dans la section `[servers]` :

```bash
[servers]
<ip>
<nom_de_domaine>
```

On peut créer des groupes de serveurs en ajoutant des sections dans le fichier `/etc/ansible/hosts`. Par exemple, pour créer un groupe `web` :

```bash
[web]
<ip>
<nom_de_domaine>

[bdd]
<ip>
```

Il est possible de perfectionner ce fichier d'inventaire en ajoutant des variables comme suit : 

```bash
[web]
<ip>

[web:vars]
ansible_ssh_user=<ssh_user>
ansible_ssh_private_key_file=<path_to_ssh_key>
```

Ajouter des variable est utile pour ne pas avoir à les spécifier à chaque fois que l'on exécute une commande ou un playbook. 

Un serveur peut appartenir à plusieurs groupes. Par exemple un groupe `servers` général et un groupe `web` plus spécifique. Ceci est utile pour exécuter des commandes sur un groupe de serveurs spécifique (par exemple pour déployer une application web sur les serveurs du groupe `web` et mettre à jour les paquets sur tous les serveurs du groupe `servers`).

Il est possible de mettre en place des inventaires personnalisés. Pour cela, il faut créer un répertoire `inventory` dans le répertoire de notre choix (typiquement, celui du playbook). Dans ce répertoire, il faut créer un fichier `hosts` qui contiendra la liste des serveurs cibles. Il faut également créer un fichier `ansible.cfg` qui contiendra la configuration d'Ansible. Il faut ensuite spécifier le chemin de l'inventaire lors de l'exécution d'une commande ou d'un playbook :

```bash
ansible all -i <path_to_inventory> -m ping
```

Le répertoire `inventory` peut contenir deux répertories : `group_vars` et `host_vars`. Ces répertoires contiennent des fichiers YAML qui contiennent des variables. Ces variables peuvent être utilisées dans les playbooks. Par exemple, si on a un fichier `inventory/group_vars/all.yml` qui contient la variable `ansible_ssh_user: user`, on pourra utiliser cette variable dans un playbook. 

Pour l'utiliser, il faut spécifier son chemin lors de l'exécution d'une commande ou d'un playbook : 

### Test de la connexion SSH

Pour tester la connexion SSH depuis Ansible vers le serveur cible, on peut exécuter la commande `ansible all -m ping`. Si la connexion fonctionne, on devrait avoir un résultat similaire à celui-ci :

```bash
<ip> | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

Si un mot de passe et un utilisateur sont demandés, il faut ajouter les variables `ansible_ssh_user` et `ansible_ssh_pass` dans le fichier d'inventaire (voir ci-dessous) ou les spécifier dans la commande `ansible all -m ping -u <user> -ask-pass`.

Lorsque la connexion fonctionne, Ansible est prêt à être utilisé. 

## Conclusion

**Ansible** est désormais installé et configuré. Il est possible de l'utiliser pour automatiser des tâches sur des serveurs cibles.

Pour tout besoin de documentation, il est possible d'utiliser la commande `ansible-doc <module>`. La documentation est également disponible en ligne sur le site d'Ansible : [documentation](https://docs.ansible.com/).

On peut aussi lister les modules disponibles sur le **control node** avec la commande `ansible-doc -l`.

#### Liens et ressources

- [Ansible Documentation](https://docs.ansible.com/)
- [Install Docker on Debian with Ansible](https://yasha.solutions/install-docker-on-debian-with-ansible/)
- [Define ssh key per host using ansible_ssh_private_key_file](https://www.cyberciti.biz/faq/define-ssh-key-per-host-using-ansible_ssh_private_key_file/)
- [How to Pass Ansible Username And Password ?](https://linuxhint.com/pass-ansible-username-and-password/)
- [How To Set Up Ansible Inventories](https://www.digitalocean.com/community/tutorials/how-to-set-up-ansible-inventories)
- [Utilisez Ansible pour automatiser vos tâches de configuration - OpenClassrooms](https://openclassrooms.com/fr/courses/2035796-utilisez-ansible-pour-automatiser-vos-taches-de-configuration)
- [Ansible Quick Start - Linux Academy](https://lucid.app/lucidchart/0c4c899b-39e1-430e-8186-c8b8812b6888/view?page=0Hmu9fbwitfV#)