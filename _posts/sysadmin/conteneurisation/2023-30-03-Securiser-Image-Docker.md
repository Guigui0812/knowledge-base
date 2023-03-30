---
title: Les bonnes pratiques de sécurité pour Docker
date: 2023-03-30 00:00:00
categories: [devops, conteneurisation, Docker]
tags: [devops, conteneurisation, Docker, sécurité]
---

Docker peut être utilisé pour exposé des services à l'extérieur. Il faut cependant respecter certaines bonnes pratiques de sécurité pour éviter les failles de sécurité.

## Utiliser un utilisateur non root

Il est fortement recommandé d'utiliser un utilisateur non root pour lancer les services. Cela permet de limiter les risques d'escalade de privilèges.

## Limiter les privilèges

Il est fortement recommandé de limiter les privilèges des conteneurs. Il faut donc limiter les privilèges des conteneurs en utilisant les options suivantes :

- `--cap-drop` : permet de supprimer les privilèges du conteneur
- `--cap-add` : permet d'ajouter des privilèges au conteneur

## Limiter les ressources

Il est fortement recommandé de limiter les ressources utilisées par les conteneurs. Il faut donc limiter les ressources utilisées par les conteneurs en utilisant les options suivantes :

- `--cpu-shares` : permet de limiter le nombre de CPU utilisé par le conteneur
- `--memory` : permet de limiter la mémoire utilisée par le conteneur

...

#### Liens utiles : 
- [Docker Security Best Practices](https://blog.gitguardian.com/how-to-improve-your-docker-containers-security-cheat-sheet/)