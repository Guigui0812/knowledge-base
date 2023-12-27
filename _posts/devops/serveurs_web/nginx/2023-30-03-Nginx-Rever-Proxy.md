---
title: Créer un reverse proxy avec nginx et docker
date: 2023-03-30 00:00:00
categories: [devops, serveurs web, nginx]
tags: [serveurs_web, nginx, reverse_proxy, docker]
---

`Nginx` permet de créer un **reverse proxy** afin de rediriger les requêtes HTTP/HTTPS qu'il reçoit vers d'autres serveurs. Cela permet par exemple de rediriger les requêtes vers des conteneurs `Docker` exposant leurs applications sur un port. De cette manière, on va pouvoir interroger plusieurs services conteneurisés et hébergés sur un ou plusieurs serveurs. 

J'ai choisi d'utiliser `docker` afin de configurer `nginx` en mode **reverse proxy**, qui redirigera le trafic vers différents services.  

## Fonctionnement et configuration de Nginx

`nginx` est configurable par l'intermédiaire de ses fichiers de configuration stockés dans `/etc/nginx`. En utilisant `docker`, il faut donc monter un **volume** embarquant les fichiers de configuration afin de les monter dans le répertoire mentionné. 

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

Dans le bloc `http`, on peut évidemment enchaîner les blocs `server` afin de configurer plusieurs serveurs web. Dans ceux-ci, on utilisera un bloc `location` afin de rediriger le trafic vers un certain contenu, ou simplement vers un autre serveur en moed **reverse proxy**. 

En fonction des besoins, on peut séparer les fichiers de configuration de `Nginx` dans plusieurs fichiers ou utiliser un seul fichier de configuration. Pour cela, il faut créer un dossier `conf.d` et ajouter les fichiers de configuration dans ce dossier. On pourrait donc avoir une organisation comme suit :
- `default.conf` : fichier de configuration par défaut
- `reverse_proxy.conf` : fichier de configuration du reverse proxy
- `service1.conf` : fichier de configuration du service 1
- `service2.conf` : fichier de configuration du service 2

`nginx` est donc très modulable et permet de s'adapter à de nombreux cas d'usages. 

## Lancer un reverse proxy avec Docker

Même s'il est possible d'utiliser `nginx` directement sur le système, j'ai choisi de conteneuriser le reverse proxy avec `docker`. Cela permet de créer un environnement isolé, et de relancer le service sur demande. De plus, on pourra plus tard utiliser `certbot` afin de générer des **certificats ssl* pour sécuriser le trafic sur le serveur. 

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

Grâce au mode `host`, on peut rediriger le trafic vers un autre conteneur docker hébergé sur la même machine. 

De manière alternative, et afin de respecter la philosophie de `docker`, il est possible d'utiliser un **réseau docker** et ajouter les deux conteneurs au réseau. Pour cela, il faut préalablement le créer : 

```bash
docker network create <network_name>
```

Ensuite, il faut spécifier le réseau dans le fichier de configuration `yaml` :

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

Dans ce cas, on peut rediriger le trafic vers le conteneur `service1` en utilisant le nom du conteneur comme nom de domaine. Par exemple, si le conteneur `service1` écoute sur le port `8080`, on peut rediriger le trafic vers ce conteneur en utilisant l'URL `http://service1:8080` qui est donc le nom du conteneur. 

Il n'y a pas forcément de meilleure solution entre les deux. Cela dépend des usages. Dans notre cas, on va utiliser le mode `host` puisque le conteneur `nginx` va rediriger le trafic vers un autre conteneur docker hébergé sur la même machine.

## Sécuriser un reverse proxy avec Nginx et Docker : Let's Encrypt

Lorsque le **reverse proxy** est fonctionnel, il peut être souhaitable de sécuriser le trafic à l'aide d'un **certificat ssl**. Je vais générer un certificat via l'autorité `letsencrypt` et grâce à l'outil en ligne de commande `certbot` qui permet de générer facilement les certificats de sécurité pour le serveur. 

Afin de générer le certificat, il faut ajouter un nouveau conteneur `certbot` dans le fichier `yaml` : 

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

La dernière ligne du `docker-compose.yml` est très importante : il s'agit de la commande qui permet de générer le certificat. 

**Remarque** : afin de faire des tests, il faut utiliser l'option `--dry-run`. Dans le cas inverse, l'autorité `letsencrypt` risque de bloquer la génération pendant un certain temps.

Avant de démarrer le conteneur `certbot`, il faut s'assurer que l'autorité pourra accéder au serveur via le protocole `http` afin d'authentifier les certificats générés. Pour cela, il faut ajouter les lignes suivantes et ne pas mentionner le protocole `ssl`. 

Le fichier de configuration `nginx` doit se présenter comme suit : 

```nginx
server {
    listen 80;
    listen [::]:80;

    server_name example.org www.example.org;
    server_tokens off;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://example.org$request_uri;
    }
}
```

Cette configuration permettra à l'autorité de valider les certificats. Si le fichier mentionne ces certificats avant la procédure de vérification, il y aura une erreur et le serveur web sera inaccessible. 

Afin de générer les certificats et les faire valider par `letsencrypt`, il suffit d'exécuter un `docker compose up -d` puisque tout est géré via `docker`. Afin de vérifier la bonne exécution du processus, on peut utiliser `docker logs <conteneur`. 

Une fois validé, on peut configurer le `https` via `ssl` et rediriger le trafic du port `80` vers le port `443` : 

```nginx
server {
    listen 80;
    listen [::]:80;

    server_name example.org www.example.org;
    server_tokens off;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://example.org$request_uri;
    }
}

server {
    listen 443 default_server ssl http2;
    listen [::]:443 ssl http2;

    server_name example.org;

    ssl_certificate /etc/nginx/ssl/live/example.org/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/live/example.org/privkey.pem;
    
    location / {
    	proxy_pass http://localhost:8080; # redirection vers un autre serveur web

      # Définition des en-têtes HTTP à envoyer pour le reverse proxy
      proxy_set_header Host $http_host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Cette configuration permet de rediriger le trafic `http` vers `https` en utilisant les certificats générés via le conteneur `certbot`. 

## Automatiser le renouvellement du certificat SSL/TLS

Le certificat SSL/TLS est valable 90 jours. Il faut donc le renouveler régulièrement mais c'est évidemment contraignant et chronophage. Pour cela, on peut créer un `cron job` :

```bash
0 0 1 */3 * "/usr/bin/docker compose" -f /chemin/absolu/vers/nginx-conf/docker-compose.yml run certbot renew
```

#### Liens utiles

- [Docker documentation](https://docs.docker.com/)
- [HTTPS using Nginx and Let's encrypt in Docker](https://mindsers.blog/post/https-using-nginx-certbot-docker/)
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
