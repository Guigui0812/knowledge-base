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

To apply the changes of the `.gitignore` file, you can use the following commands:

```bash
git rm -r --cached .
git add .
git commit -m "Message du commit"
```