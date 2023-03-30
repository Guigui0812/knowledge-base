---
title: Créer un Dockerfile
date: 2023-03-30 00:00:00
categories: [devops, conteneurisation, Docker]
tags: [devops, conteneurisation, Docker]
---

Avec Docker, il est possible de créer des images. Ces images sont des conteneurs qui peuvent être utilisés pour lancer des applications. Pour créer une image, il faut créer un fichier appelé `Dockerfile`. Ce fichier contient toutes les instructions pour créer l'image.

## Créer un Dockerfile

Pour créer un Dockerfile, il faut créer un fichier appelé `Dockerfile` dans le dossier de votre projet. Ce fichier doit être dans le dossier racine de votre projet. Dans ce fichier, il faut ajouter les instructions pour créer l'image.

### Exemple

Voici un exemple de Dockerfile :

```dockerfile
FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y nginx
```

Dans cet exemple, on crée une image à partir de l'image `ubuntu:latest`. On met ensuite à jour les paquets et on installe `nginx`.

## Construire une image

Pour construire une image, il faut utiliser la commande suivante :

```bash
docker build -t <nom de l'image> .
```

Le nom de l'image doit être en minuscule et sans espace. Il est possible de spécifier un tag pour l'image. Par exemple, `docker build -t monimage:1.0 .`.

## Lancer un conteneur à partir d'une image

Pour lancer un conteneur à partir d'une image, il faut utiliser la commande suivante :

```bash
docker run -d -p 80:80 <nom de l'image>
```

Cette commande permet de lancer un conteneur en mode démon et de mapper le port 80 de l'hôte sur le port 80 du conteneur.

## Commandes Dockerfile

De nombreuses commandes peuvent être utilisées pour créer une image. Pour plus d'informations, il faut consulter la [documentation officielle](https://docs.docker.com/engine/reference/builder/).

### Les commandes de base

#### FROM

La commande `FROM` permet de spécifier l'image de base. Par exemple, `FROM ubuntu:latest`.

#### RUN

La commande `RUN` permet d'exécuter une commande. Par exemple, `RUN apt-get update`.

#### CMD

La commande `CMD` permet d'exécuter une commande lors du lancement du conteneur. Par exemple, `CMD ["nginx", "-g", "daemon off;"]`.

#### EXPOSE

La commande `EXPOSE` permet d'ouvrir un port. Par exemple, `EXPOSE 80`.

#### ENV

La commande `ENV` permet de définir une variable d'environnement. Par exemple, `ENV NGINX_VERSION 1.14.0`.

#### ADD

La commande `ADD` permet d'ajouter des fichiers ou des dossiers. Par exemple, `ADD . /var/www/html`.

#### COPY

La commande `COPY` permet de copier des fichiers ou des dossiers. Par exemple, `COPY . /var/www/html`.

#### ENTRYPOINT

La commande `ENTRYPOINT` permet d'exécuter une commande lors du lancement du conteneur. Par exemple, `ENTRYPOINT ["nginx", "-g", "daemon off;"]`.

#### VOLUME

La commande `VOLUME` permet de créer un volume. Par exemple, `VOLUME ["/var/www/html"]`.

#### USER

La commande `USER` permet de spécifier l'utilisateur. Par exemple, `USER www-data`.

#### WORKDIR

La commande `WORKDIR` permet de spécifier le répertoire de travail. Par exemple, `WORKDIR /var/www/html`.

#### ARG

La commande `ARG` permet de définir un argument. Par exemple, `ARG NGINX_VERSION`.

#### ONBUILD

La commande `ONBUILD` permet d'exécuter une commande lors de la création d'une image à partir de l'image courante. Par exemple, `ONBUILD RUN apt-get update`.

### Quelques commandes et exemples utiles

#### Créer un utilisateur et un groupe propre au conteneur

Cette opération permet de créer un utilisateur et un groupe propre au conteneur. Cela permet de ne pas utiliser l'utilisateur `root` pour lancer l'application. Cela permet de sécuriser l'application.

```dockerfile
RUN groupadd -r www-data && useradd -r -g www-data www-data
```

OU

```dockerfile
RUN addgroup --system www-data && adduser --system --ingroup www-data www-data
```