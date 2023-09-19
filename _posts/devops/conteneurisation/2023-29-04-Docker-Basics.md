---
title: Quelques notions sur Docker
date: 2023-04-29 00:00:00
categories: [devops, conteneurisation, docker]
tags: [devops, conteneurisation, docker, linux]
---

Docker est une technologie de virtualisation qui permet de créer, déployer et exécuter des applications dans des conteneurs logiciels. Contrairement à la virtualisation traditionnelle qui crée une machine virtuelle entière avec son propre système d'exploitation, Docker utilise des conteneurs qui partagent le même noyau de système d'exploitation de l'hôte.

Les conteneurs Docker sont légers et portables, ce qui les rend faciles à déployer et à gérer sur différentes plateformes et environnements. Chaque conteneur Docker contient une application et ses dépendances, ainsi que toutes les bibliothèques et outils nécessaires à son exécution.

Docker permet également de créer des images de conteneurs, qui sont des modèles préconfigurés de conteneurs prêts à l'emploi. Ces images peuvent être partagées et réutilisées entre différents projets et équipes, ce qui facilite la collaboration et l'intégration continue.

## Concepts

Docker n'est pas une machine virtuelle, il embarque uniquement les drivers nécessaires au fonctionnement de l'application. Il n'y a pas de système d'exploitation, il n'y a que les drivers nécessaires au fonctionnement de l'application. Il simule le fonctionnement de l'application sur un système d'exploitation, mais il n'y a pas de système d'exploitation. Cependant il tourne sur un système d'exploitation, qui peut contrôler les conteneurs grâce au docker daemon.

### Images et Layers

Une image possède différentes couches appelées "layers" dans un `dockerfile` : 
- `FROM` : la base de l'image, par exemple `FROM ubuntu:latest`
- `EXPOSE` : les ports à exposer, par exemple `EXPOSE 80`
- `CMD` : la commande à exécuter, par exemple `CMD ["apache2ctl", "-D", "FOREGROUND"]
- `COPY` : les fichiers à copier, par exemple `COPY index.html /var/www/html`
- `RUN` : les commandes à exécuter, par exemple `RUN apt-get update && apt-get install -y apache2`

Toutes ces instructions forment les layers de l'image. Chaque layer est indépendante, et si on modifie une layer, on ne modifie pas les autres. Cela permet de réutiliser les layers, et de ne pas avoir à tout recompiler à chaque fois.

**Bonne pratique** : il faut mieux enchaîner les commandes avec les `&&` plutôt que de les séparer avec des `\` car cela permet de ne pas créer de layer supplémentaire.

L'image construite est encapsulée dans un `docker` : un conteneur = 1 processus.

**Bonne pratique 2** : Toujours `EXPOSE` un port si on souhaite utiliser `-p` pour le lier à un port de la machine hôte.

Lorsqu'on lance un conteneur, on peut utiliser `-d` pour le lancer en arrière plan, et `-it` pour le lancer en interactif : 
- `-i` : interactive
- `-t` : pseudo-tty (terminal)
- `-d` : detached (arrière plan)

Pour afficher toutes les images, on peut utiliser `docker images ls`. Pour supprimer une image, on peut utiliser `docker rmi` suivit du nom de l'image ou de son id.

Pour nettoyer les images, on peut faire `docker image prune`.

### Réseau

Docker utilise un réseau virtuel pour communiquer entre les conteneurs. Il est possible de créer un réseau virtuel avec `docker network create` et de lier les conteneurs à ce réseau avec `docker run --network`.

Chaque conteneur a une `ip` gérée par le docker engine. On peut donc lier les conteneurs entre eux avec leur `ip` s'ils sont dans le même réseau virtuel.

Pour connaître l'ip d'un conteneur, on peut utiliser `docker inspect` suivit du nom du conteneur ou de son id.

### Volumes

Cela permet de monter un volume afin d'assurer la persistance des données. On peut monter un volume avec `docker run -v` ou `docker run --mount`.

Les volumes logiciels sont une autre implémentation des volumes, qui permettent de partager des données entre les conteneurs. On peut les créer avec `docker volume create` et les lister avec `docker volume ls`.

### docker-compose

C'est un descripteur de déploiement qui permet de déployer plusieurs conteneurs en même temps. Il permet de déployer plusieurs conteneurs en même temps, et de les lier entre eux. Il permet également de définir des variables d'environnement, des volumes, des réseaux, etc.

De plus, les docker montés dans un même docker-compose sont dans le même réseau virtuel, ce qui permet de les lier entre eux avec leur nom de conteneur.

## Problèmes

- Failles dans le docker engine
- Pertes de l'image ou faille dans l'image
- Danger d'exposition du docker daemon

## Docker hub

On peut vérifier les versions des images sur le [docker hub](https://hub.docker.com/). Dans la section tags, on peut voir les failles de sécurité connues. Il ne faut jamais utiliser d'images avec des vulnéralités critiques connues.

## Dépôts

On peut build des images et les `tag` pour les pousser sur un dépôt. On peut ensuite les récupérer avec `docker pull`. Cependant, il faut utiliser des services de dépôt ou mettre en place un dépôt privé appelé `registry`. Ces services peuvent être mis en place `on-premise` ou `cloud` chez des providers comme `AWS`, `Azure` ou `GCP`.	



## Installation de Docker

[Installation sur Debian](https://docs.docker.com/engine/install/debian/)

