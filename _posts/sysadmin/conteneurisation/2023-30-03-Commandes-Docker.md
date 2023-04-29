---
title: Commandes de base pour Docker
date: 2023-03-30 00:00:00
categories: [devops, conteneurisation, Docker]
tags: [devops, conteneurisation, Docker]
---

Dockers est un outil qui permet de créer des conteneurs. Ces conteneurs sont des environnements isolés qui permettent de lancer des applications. Ces conteneurs sont très légers et permettent de lancer des applications sans avoir à les installer sur la machine.

## Commandes de base

### Lister les conteneurs

Pour lister les conteneurs, il faut utiliser la commande suivante :

```bash
docker ps
```

### Lister les images

Pour lister les images, il faut utiliser la commande suivante :

```bash 
docker images
```

## Télécharger une image

Pour télécharger une image, il faut utiliser la commande suivante :

```bash
docker pull <image>
```

### Lancer un conteneur

Pour lancer un conteneur, il faut utiliser la commande suivante :

```bash
docker run <image>
```

### Lancer un conteneur en mode interactif

Pour lancer un conteneur en mode interactif, il faut utiliser la commande suivante :

```bash
docker run -it <image>
```

### Lancer un conteneur en mode démon

Pour lancer un conteneur en mode démon, il faut utiliser la commande suivante :

```bash
docker run -d <image>
```

### Lancer un conteneur en mode démon et en mode interactif

Pour lancer un conteneur en mode démon et en mode interactif, il faut utiliser la commande suivante :

```bash
docker run -dit <image>
```

### Lancer un conteneur en mode démon et en mode interactif avec un nom

Pour lancer un conteneur en mode démon et en mode interactif avec un nom, il faut utiliser la commande suivante :

```bash
docker run -dit --name <nom> <image>
```

### Lancer un conteneur en mode démon et en mode interactif avec un nom et un port

Pour lancer un conteneur en mode démon et en mode interactif avec un nom et un port, il faut utiliser la commande suivante :

```bash
docker run -dit --name <nom> -p <port>:<port> <image>
```

### Lancer un conteneur en mode démon et en mode interactif avec un nom et un port et un volume

Pour lancer un conteneur en mode démon et en mode interactif avec un nom et un port et un volume, il faut utiliser la commande suivante :

```bash
docker run -dit --name <nom> -p <port>:<port> -v <volume> <image>
```

### Lancer un conteneur en mode démon et en mode interactif avec un nom et un port et un volume et un environnement

Pour lancer un conteneur en mode démon et en mode interactif avec un nom et un port et un volume et un environnement, il faut utiliser la commande suivante :

```bash
docker run -dit --name <nom> -p <port>:<port> -v <volume> -e <environnement> <image>
```

