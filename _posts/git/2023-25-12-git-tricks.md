---
title: GIT - Astuces utiles
date: 2023-12-25 00:00:00
categories: [git]
tags: [devops, dev, git, versioning, commandes]
---

![git_tricks](/assets/git-tricks.jpg)

Liste d'astuces **git** utiles au quotidien.

## Annuler le dernier commit

Afin d'annuler le dernier commit, il est possible d'utiliser la commande `reset`.

```bash
git reset --soft HEAD~1
```

## Conservation des modifications locales lors d'un pull

Il est possible de conserver les modifications locales lors d'un pull avec la commande `stash`.

```bash
git stash
git pull
git stash pop
```

## Supprimer les fichiers non suivis

Il est possible de supprimer les fichiers non suivis avec la commande `clean`.

```bash
git clean -f
```

## Supprimer les fichiers suivis

Il est possible de supprimer les fichiers suivis avec la commande `rm`.

```bash
git rm <file>
```

## Appliquer les changements du fichier `.gitignore`

Pour appliquer les changements du fichier `.gitignore`, il faut `commit` les changements et supprimer le cache. Pour cela, il faut utiliser les commandes suivantes :

```bash
git add .
git commit -m "Message du commit"
git rm -r --cached .
git add .
git commit -m "Message du commit"
```
