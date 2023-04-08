---
title: Configurer et utiliser git
date: 2023-03-28 00:00:00
categories: [git, dev, devops]
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

### Initialiser un dépôt

Pour initialiser un dépôt, il faut se placer dans le dossier du projet et exécuter la commande `git init`.

```bash
git init
```

### Ajouter des fichiers

Pour ajouter des fichiers au dépôt, il faut utiliser la commande `git add`.

```bash
git add <fichier>
```

### Commiter des fichiers

Pour commiter des fichiers, il faut utiliser la commande `git commit`.

```bash
git commit -m "Message du commit"
```

### Pousser des fichiers

Pour pousser des fichiers sur le dépôt distant, il faut utiliser la commande `git push`.

```bash
git push
```

### Récupérer des fichiers

Pour récupérer des fichiers depuis le dépôt distant, il faut utiliser la commande `git pull`.

```bash
git pull
```

### Récupérer l'historique des commits

Pour récupérer l'historique des commits, il faut utiliser la commande `git log`.

```bash
git log
```

### Récupérer l'état des fichiers

Pour récupérer l'état des fichiers, il faut utiliser la commande `git status`.

```bash
git status
```

### Récupérer les différences entre les fichiers

Pour récupérer les différences entre les fichiers, il faut utiliser la commande `git diff`.

```bash
git diff
```
