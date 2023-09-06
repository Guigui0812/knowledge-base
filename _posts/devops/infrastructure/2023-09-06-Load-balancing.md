---
title: Load balancing notions
date: 2023-03-30 00:00:00
categories: [devops, infrastructure]
tags: [devops, infrastructure, load-balancing]
---

Le load balancing est une technique permettant de répartir la charge entre plusieurs serveurs. Elle permet d'assurer la disponibilité et la performance des services en permettant l'optimisation des ressources. Grâce à différents algorithmes, le trafic entrant est réparti entre les différentes ressources disponibles dans le cluster sans avoir un serveur surchargé.

## Quelques algorithmes de load balancing

Il existe plusieurs algorithmes de load balancing. Chacun de ces algorithmes a ses avantages et ses inconvénients. Il faut donc choisir l'algorithme le plus adapté à l'infrastructure et au cas d'usage.

### Round Robin

Les requêtes sont réparties de manière circulaire entre les différents serveurs. Cet algorithme est très simple à mettre en place et permet de répartir la charge de manière équitable entre les différents serveurs. Cependant, cet algorithme ne prend pas en compte la charge des serveurs. Il est donc possible qu'un serveur soit surchargé alors qu'un autre serveur est sous-utilisé.

### Least Connection

Les requêtes sont redirigées vers le serveur ayant le moins de connexions actives. Cet algorithme permet de répartir la charge de manière équitable entre les différents serveurs.

### Least Response Time

Les requêtes sont redirigées vers le serveur ayant le temps de réponse le plus faible et le moins de connexions actives. 

### Hashing

Les requêtes sont redirigées vers le serveur en fonction d'une clé.

### IP Hashing

Les requêtes sont redirigées vers le serveur en fonction de l'adresse IP de l'utilisateur.

### Least Bandwidth

Les requêtes sont redirigées vers le serveur ayant le moins de bande passante utilisée.

### Random

Deux serveurs sont choisis aléatoirement puis application du **Least Connection** afin de choisir le serveur final.

## Les technologies du marché

Il existe plusieurs technologies permettant de mettre en place du load balancing :
- **Nginx** : le serveur web Nginx permet de mettre en place du load balancing à l'aide d'algorithmes simples.
- **HAProxy** : HAProxy est un logiciel permettant de mettre en place du load balancing. Il permet de mettre en place des algorithmes de load balancing complexes.


#### Ressources et liens utiles :

- [What Is Load Balancing? - Nginx](https://www.nginx.com/resources/glossary/load-balancing/)


