---
title: Créer un reverse proxy avec nginx et docker
date: 2023-03-30 00:00:00
categories: [devops, serveurs web, nginx]
tags: [serveurs_web, nginx, reverse_proxy, docker]
---

Nginx permet de créer un reverse proxy. Un reverse proxy permet de rediriger les requêtes HTTP/HTTPS qu'il reçoit. Par exemple, si on a un serveur web sur le port 80 et un serveur web sur le port 8080, on peut créer un reverse proxy sur le port 80 qui redirigera les requêtes vers le serveur web sur le port 8080.

J'ai choisi d'utiliser `docker` afin de configurer un reverse proxy avec Nginx. Cela permet de créer un environnement isolé et de ne pas avoir à installer Nginx sur la machine hôte. De plus, on va pouvoir rediriger le trafic vers un autre conteneur docker hébergé sur la même machine.

# Fonctionnement et configuration de Nginx

`Nginx` est configurable par l'intermédiaire de ses fichiers de configuration stockés dans `/etc/nginx`. En utilisant `docker`, je vais donc devoir monter un volume pour pouvoir modifier les fichiers de configuration de `Nginx`.

Le fichier de configuration se présente comme suit : 

```nginx
worker_processes 1; # nombre de processus à lancer

# bloc events : définition des événements (nombre de connexions simultanée, délai d'attente, ...)
events {
  worker_connections 1024; # nombre de connexions simultanées
}

# Bloc http : définition des serveurs web
http {

  # Bloc server : définition d'un serveur web
  server {
    listen 80; # port d'écoute

    # Bloc location : définition d'une ressource (chemin d'accès)
    location / { 
      proxy_pass http://localhost:8080; # redirection vers un autre serveur web

      # Définition des en-têtes HTTP à envoyer pour le reverse proxy
      proxy_set_header Host $http_host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
    }
  }
}
```

Le bloc de configuration ci-dessus permet donc de générer un reverse proxy basique qui va rediriger le trafic du port `80` vers le `8080` sur la même machine.

Les directives `proxy_set_header` permettent de définir les en-têtes HTTP à envoyer pour le reverse proxy. Dans notre cas, on va envoyer les en-têtes `Host`, `X-Real-IP`, `X-Forwarded-For` et `X-Forwarded-Proto`. Ces en-têtes permettent de conserver les informations de la requête initiale : 
- `Host` : permet de transférer le nom original de l'hôte qui a envoyé la requête
- `X-Real-IP` : permet de transférer l'adresse IP du client 
- `X-Forwarded-For` : permet d'ajouter l'adresse IP du client à la liste des adresses IP qui ont envoyé la requête afin de suivre le chemin (client -> reverse proxy -> serveur web)
- `X-Forwarded-Proto` : permet au backend de connaître le protocole utilisé par le client (HTTP ou HTTPS par exemple si on a besoin de savoir si la requête est sécurisée ou non)

Dans le bloc `http`, on peut évidemment enchaîner les blocs `server` afin de créer plusieurs serveurs web. On peut également créer plusieurs blocs `location` afin de rediriger le trafic vers plusieurs serveurs web en fonction du chemin d'accès. 

En fonction des besoins, on peut séparer les fichiers de configuration de `Nginx` dans plusieurs fichiers. Pour cela, il faut créer un dossier `conf.d` et ajouter les fichiers de configuration dans ce dossier. On pourrait donc avoir une organisation comme suit :
- `default.conf` : fichier de configuration par défaut
- `reverse_proxy.conf` : fichier de configuration du reverse proxy
- `service1.conf` : fichier de configuration du service 1
- `service2.conf` : fichier de configuration du service 2

`Nginx` est donc très modulable et permet de s'adapter à de nombreux cas d'usages. 

# Lancer un reverse proxy avec Docker

Même s'il est possible d'utiliser `nginx` directement sur le système, j'ai choisi de conteneuriser le reverse proxy avec `docker`. Cela permet de créer un environnement isolé et de rediriger le trafic vers un autre conteneur hébergé sur la même machine.

Il est possible de lancer le conteneur directement `docker run` : 

```bash
docker run -d -p 80:80 --name nginx-rp --network host -v <path_to_nginx.conf>:/etc/nginx/nginx.conf nginx:latest 
```

Cependant, je préfère utiliser `docker-compose` afin de pouvoir définir les services à lancer et de créer des volumes grâce à un fichier de configuration `yaml`. Ce fichier permet de définir les services à lancer et de créer des volumes. Dans notre cas, on va créer un volume pour les fichiers de configuration de `nginx``.

```yaml
version: '3.8'

services:
  nginx:
    image: nginx:latest
    container_name: nginx
    restart: always
    ports:
      - 80:80
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf # fichier de configuration de Nginx monté en volume
    network_mode: host # permet de rediriger le trafic vers un autre conteneur docker hébergé sur la même machine
```

Grâce au mode `host`, on peut rediriger le trafic vers un autre conteneur docker hébergé sur la même machine. De manière alternative, on peut créer un réseau docker et ajouter les deux conteneurs au réseau. Pour cela, il faut préalablement créer un réseau docker.

```bash
docker network create <network_name>
```

Ensuite, il faut spécifier le réseau dans le fichier de configuration `yaml` des deux conteneurs.

```yaml
version: '3.8'

services:
  nginx:
    image: nginx:latest
    container_name: nginx
    restart: always
    ports:
      - 80:80
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf # fichier de configuration de Nginx monté en volume
    networks:
      - <network_name>
  service1:
    image: service1:latest
    container_name: service1
    restart: always
    networks:
      - <network_name>

networks:
  <network_name>:
    external: true
```

Dans ce cas, on peut rediriger le trafic vers le conteneur `service1` en utilisant le nom du conteneur comme nom de domaine. Par exemple, si le conteneur `service1` écoute sur le port `8080`, on peut rediriger le trafic vers ce conteneur en utilisant l'URL `http://service1:8080`.

Il n'y a pas forcément de meilleure solution entre les deux. Cela dépend des usages. Dans notre cas, on va utiliser le mode `host` puisque le conteneur `nginx` va rediriger le trafic vers un autre conteneur docker hébergé sur la même machine.

# Sécuriser un reverse proxy avec Nginx et Docker : Let's Encrypt

Il est possible de sécuriser un reverse proxy avec Nginx et Docker en utilisant Let's Encrypt. Pour cela, il faut utiliser l'image officielle de Nginx et l'image officielle de Certbot.

```yaml
version: '3.7'

services:
  nginx:
    image: nginx:latest
    container_name: nginx
    restart: always
    ports:
      - 80:80
      - 443:443
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./conf.d:/etc/nginx/conf.d
      - ./certs:/etc/letsencrypt
      - ./html:/usr/share/nginx/html
  certbot:
    image: certbot/certbot
    container_name: certbot
    restart: always
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./conf.d:/etc/nginx/conf.d
      - ./certs:/etc/letsencrypt
      - ./html:/usr/share/nginx/html
    command: certonly --webroot --webroot-path=/usr/share/nginx/html --email <email> --agree-tos --no-eff-email --force-renewal --staging -d <domain>
```

On peut ensuite créer le fichier de configuration de Nginx. Dans notre cas, on va créer un reverse proxy qui redirigera les requêtes vers un serveur web sur le port 8080.

```nginx
http {
  server {
    listen 80;
    server_name <domain>;
    location / {
      proxy_pass http://localhost:8080;
    }
  }

  server {
    listen 443 ssl;
    server_name <domain>;
    ssl_certificate /etc/letsencrypt/live/<domain>/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/<domain>/privkey.pem;
    location / {
      proxy_pass http://localhost:8080;
    }
  }
}
```

Grâce à ce fichier de configuration, on peut accéder au serveur web sur le port 8080 via le reverse proxy sur le port 80 et 443.

On peut évidemment ajouter une redirection HTTP vers HTTPS.

```nginx
server {
  listen 80;
  server_name <domain>;
  return 301 https://$host$request_uri;
}
```

Cela permet de sécuriser les communications entre le client et le serveur web puisque les communications sont chiffrées via SSL/TLS.

# Automatiser le renouvellement du certificat SSL/TLS

Le certificat SSL/TLS est valable 90 jours. Il faut donc le renouveler régulièrement. Pour cela, on peut utiliser un cronjob chargé de renouveler le certificat SSL/TLS.

Dans le but de certifier notre domaine, nous avons utiliser certbot dans un container docker décrit dans un `docker-compose.yml`. Nous avons donc accès à la commande `certbot` dans ce container. Nous pouvons donc créer un cronjob chargé de relancer notre container `certbot` tous les 2 mois.

```yaml
0 0 1 */2 * /usr/bin/docker compose -f <path_to_container>/docker-compose.yml up certbot
```

Ce job permet donc d'arrêter de se soucier du renouvellement du certificat SSL/TLS.

#### Liens utiles

- [Docker documentation](https://docs.docker.com/)
- [NGINX Reverse Proxy - Nginx Doc](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
- [Configure NGINX as a Reverse Proxy with Docker Compose file - Medium](https://umasrinivask.medium.com/configure-nginx-as-a-reverse-proxy-with-docker-compose-file-4ebba2b75c89)
- [Docker compose : NGINX reverse proxy with multiple containers -BogoToBogo](https://www.bogotobogo.com/DevOps/Docker/Docker-Compose-Nginx-Reverse-Proxy-Multiple-Containers.php)
- [Nginx: configuration as reverse proxy - RDR-IT](https://rdr-it.com/en/nginx-configuration-as-reverse-proxy/)
- [How To Configure Nginx as a Reverse Proxy on Ubuntu 22.04 - DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-as-a-reverse-proxy-on-ubuntu-22-04)
- [Docker : Nginx en reverse proxy](https://www.grottedubarbu.fr/docker-nginx-reverse-proxy/)
- [Using Free Let’s Encrypt SSL/TLS Certificates with NGINX](https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/?amp=1)
- [Documentation certbot](https://eff-certbot.readthedocs.io/en/stable/install.html#running-with-docker)
- [Setup SSL with Docker, NGINX and Lets Encrypt](https://www.programonaut.com/setup-ssl-with-docker-nginx-and-lets-encrypt/)
- [Simplest HTTPS setup: Nginx Reverse Proxy+ Letsencrypt+ AWS Cloud + Docker](https://leangaurav.medium.com/simplest-https-setup-nginx-reverse-proxy-letsencrypt-ssl-certificate-aws-cloud-docker-4b74569b3c61)
- [Nginx and Let’s Encrypt with Docker in Less Than 5 Minutes](https://leangaurav.medium.com/simplest-https-setup-nginx-reverse-proxy-letsencrypt-ssl-certificate-aws-cloud-docker-4b74569b3c61)
- [HTTPS using Nginx and Let's encrypt in Docker](https://mindsers.blog/post/https-using-nginx-certbot-docker/)