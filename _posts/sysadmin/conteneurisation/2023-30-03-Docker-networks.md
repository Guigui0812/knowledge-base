---
title: Les réseaux Docker
date: 2023-03-30 00:00:00
categories: [devops, conteneurisation, Docker]
tags: [devops, conteneurisation, Docker, réseau]
---

Docker permet de créer des réseaux. Ces réseaux permettent de connecter les conteneurs entre eux. Ces réseaux peuvent être de 2 types :

- `bridge` : réseau par défaut
- `host` : réseau hôte

## Réseau bridge

Le réseau bridge est le réseau par défaut. Il permet de connecter les conteneurs entre eux. Il est possible de créer plusieurs réseaux bridge. Ces réseaux bridge sont isolés les uns des autres.

### Créer un réseau bridge

Pour créer un réseau bridge, il faut utiliser la commande suivante :

```bash
docker network create <nom_du_reseau>
```

### Lister les réseaux bridge

Pour lister les réseaux bridge, il faut utiliser la commande suivante :

```bash
docker network ls
```

### Lister les conteneurs d'un réseau bridge

Pour lister les conteneurs d'un réseau bridge, il faut utiliser la commande suivante :

```bash
docker network inspect <nom_du_reseau>
```

### Lancer un conteneur dans un réseau bridge

Pour lancer un conteneur dans un réseau bridge, il faut utiliser la commande suivante :

```bash
docker run --network <nom_du_reseau> <image>
```

### Ajouter un réseau bridge à un docker-compose

Pour ajouter un réseau bridge à un docker-compose, il faut ajouter la section suivante :

```yaml
networks:
  <nom_du_reseau>:
    driver: bridge
```

### Ajouter un réseau existant à un docker-compose

Pour ajouter un réseau existant à un docker-compose, il faut ajouter la section suivante :

```yaml
networks:
  <nom_du_reseau>:
    external: true
```