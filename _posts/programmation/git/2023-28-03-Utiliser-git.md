---
title: Configurer et utiliser git
date: 2023-03-28 00:00:00
categories: [dev, git]
tags: [devops, dev, git, ci/cd]
---

**Git** est un système de gestion de versions distribué. Il permet de gérer les versions d'un projet et de collaborer avec d'autres personnes sur un projet. Il est très utilisé dans le monde du développement logiciel et est un outil indispensable pour les développeurs.

## Installation

### Windows

Il est possible d'installer **git** sur Windows en téléchargeant le fichier d'installation sur le site officiel : [Git - Downloading Package](https://git-scm.com/download/win).

### Linux

Il est possible d'installer **git** sur Linux en utilisant le gestionnaire de paquets de la distribution.

#### Debian

```bash
sudo apt install git
```

#### Arch Linux

```bash
sudo pacman -S git
```

#### CentOS

```bash
sudo yum install git
```

## Configuration

Il faut configurer **git** avec son nom d'utilisateur et son adresse email.

```bash
git config --global user.name "John Doe"
git config --global user.email "john.doe@test.com"
```

## Utilisation

### Basic commands

|Command|Purpose|
|---|---|
|`git init`|Initializes a new git repository|
|`git add <file>`|Adds a file to the staging area|
|`git commit -m "Message"`|Commits the changes|
|`git push`|Pushes the changes to the remote repository|
|`git pull`|Pulls the changes from the remote repository|
|`git status`|Shows the status of the working tree|
|`git log`|Shows the commit history|
|`git diff`|Shows the differences between commits, branches, etc.|
|`git branch`|Shows the branches|
|`git checkout <branch>`|Switches to the specified branch|
|`git merge <branch>`|Merges the specified branch into the current branch|
|`git clone <url>`|Clones the specified repository|
|`git remote add <name> <url>`|Adds a remote repository|
|`git remote -v`|Shows the remote repositories|
|`git remote remove <name>`|Removes the specified remote repository|

### Some useful tips

#### Appliquer les changements du fichier `.gitignore`

Pour appliquer les changements du fichier `.gitignore`, il faut utiliser la commande suivante :

```bash
git rm -r --cached .
git add .
git commit -m "Message du commit"
```

## Les bonnes pratiques

Afin d'utiliser `git` correctement, il est important de suivre les bonnes pratiques.

### Les branches

Chaque modification doit être effectuée dans une branche. Il est important de ne pas modifier la branche `main` directement. Il faut créer une branche à partir de la branche `main` et effectuer les modifications dans cette branche. Une fois les modifications terminées, il faut créer une pull request et demander à un autre développeur de valider la pull request. Une fois la pull request validée, il faut merger la branche dans la branche `main`.

### Les commits

Dans une même branche il est important de réaliser des commits régulièrement. Il faut éviter de faire un seul commit avec toutes les modifications. Il faut faire un commit pour chaque modification. Il est important de donner un nom explicite au commit afin de pouvoir comprendre les modifications effectuées.

Plusieurs raisons : 
- Revenir en arrière sur une modification
- Historiser les modifications

Il faut évidemment trouver un bon équilibre entre le nombre de commits et la taille des commits. Il faut éviter de faire un commit pour chaque caractère modifié. Il faut également éviter de faire un seul commit avec toutes les modifications. L'historique de code doit avoir du sens : une nouvelle fonctionnalité, une correction de bug, etc.

### Les pull requests

Une pull request est une demande de validation de modifications. Une pull request doit être créée pour chaque modification. Une pull request doit être validée par un autre développeur. Une fois la pull request validée, il faut merger la branche dans la branche `main`.

Il s'agit d'un mécanisme de sécurité et de qualité. Il permet de s'assurer que les modifications sont valides et qu'elles ne cassent pas le code existant.

**Attention** : il faut éviter de valider ses propres pull requests. Il faut demander à un autre développeur de valider la pull request. Même les meilleurs développeurs peuvent faire des erreurs.