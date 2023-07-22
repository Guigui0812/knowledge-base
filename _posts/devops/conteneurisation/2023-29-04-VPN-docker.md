---
title: Conteneurisation d'un VPN avec Docker
date: 2023-04-29 00:00:00
categories: [devops, conteneurisation, docker]
tags: [devops, conteneurisation, docker, linux, réseau, vpn, openvpn]
---

Utiliser un VPN est devenu indispensable pour protéger sa vie privée sur internet ou pour accéder à son réseau local depuis l'extérieur.

Il existe de nombreux fournisseurs de VPN, mais il est également possible de créer son propre VPN. Dans ce tutoriel, nous allons voir comment créer un VPN avec Docker.

## Prérequis

- Un serveur sous Linux
- Docker
- Un accès internet

## Création du conteneur

Pour créer le conteneur, nous allons utiliser l'image [kylemanna/openvpn](https://hub.docker.com/r/kylemanna/openvpn). C'est la plus populaire sur Docker Hub pour créer un VPN.

Il faut d'abord créer un volume pour stocker les données du VPN :

```bash
OVPN_DATA="ovpn-data-example"
docker volume create --name $OVPN_DATA
```

Pour créer le conteneur, il faut utiliser la commande suivante :

```bash
docker run -v <chemin vers le répertoire>:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://<adresse IP>:<port>
```

Cette commande crée un ficher de configuration dans le répertoire spécifié. Il faut ensuite lancer le conteneur pour générer les certificats :

```bash
docker run -v <chemin vers le répertoire>:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
```

Cette commande va permettre de génére les certificats et les clés de chiffrement. 

Lorsque les éléments sont générés, il faut lancer le conteneur en mode démon :

```bash
docker run -v <chemin vers le répertoire>:/etc/openvpn --name vpn-container -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
```

On peut vérifier que le conteneur est bien lancé avec la commande `docker ps`.

## Création d'un utilisateur

Pour créer un utilisateur, il faut utiliser la commande suivante :

```bash
docker run -v <chemin vers le répertoire>:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full <nom de l'utilisateur> nopass
```

Il faut ensuite récupérer le certificat de l'utilisateur :

```bash
docker run -v <chemin vers le répertoire>:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient <nom de l'utilisateur> > <nom de l'utilisateur>.ovpn
```

## Configuration du client

Pour se connecter au vpn via un client, il faut installer le client OpenVPN. Il est disponible sur le site officiel : [https://openvpn.net/community-downloads/](https://openvpn.net/community-downloads/).

Une fois installé, il ne reste qu'à importer le fichier de configuration de l'utilisateur. Pour récupérer le fichier, il existe plusieurs méthodes. On peut utiliser filezilla afin de se connecter au serveur et de récupérer le fichier via **sftp**. Une fois récupérer, il ne reste qu'à l'importer dans le client OpenVPN.

Si le VPN a vocation à être utilisé depuis l'exérieur du réseau local, il faut configurer le routeur pour rediriger le port 1194 vers le serveur et ouvrir le port 1194 dans le pare-feu du serveur.

## Avec docker-compose

Il est possible de créer le conteneur avec docker-compose. Pour cela, il faut créer un fichier `docker-compose.yml` avec le contenu suivant :

```yaml
version: '3'
services:
  openvpn:
    image: kylemanna/openvpn
    container_name: openvpn
    ports:
      - "1194:1194/udp"
    cap_add:
      - NET_ADMIN
    volumes:
      - ./openvpn-data:/etc/openvpn
    restart: always
```

Il faut ensuite paramétrer le fichier de configuration avec la commande suivante :

```bash
docker-compose run --rm openvpn ovpn_genconfig -u udp://<adresse IP>:<port>
```

Il faut ensuite lancer le conteneur pour générer les certificats :

```bash
docker-compose run --rm openvpn ovpn_initpki
```

Lorsque les éléments sont générés, il faut lancer le conteneur en mode démon :

```bash
docker-compose up -d
```

Pour créer un utilisateur, il faut utiliser la commande suivante :

```bash
docker-compose run --rm openvpn easyrsa build-client-full <nom de l'utilisateur> nopass
```

Il faut ensuite récupérer le certificat de l'utilisateur :

```bash
docker-compose run --rm openvpn ovpn_getclient <nom de l'utilisateur> > <nom de l'utilisateur>.ovpn
```

#### Liens et ressources : 

- [Un serveur openVPN en 5 minutes avec Docker](https://www.grottedubarbu.fr/serveur-openvpn-5-minutes-docker/)
- [Image Docker kylemanna/openvpn](https://hub.docker.com/r/kylemanna/openvpn)