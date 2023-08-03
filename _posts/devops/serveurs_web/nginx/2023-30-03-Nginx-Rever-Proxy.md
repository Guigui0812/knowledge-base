---
title: Créer un reverse proxy avec Nginx et Docker
date: 2023-03-30 00:00:00
categories: [devops, serveurs web, nginx]
tags: [serveurs_web, nginx, reverse_proxy, docker]
---

Nginx permet de créer un reverse proxy. Un reverse proxy permet de rediriger les requêtes HTTP/HTTPS qu'il reçoit. Par exemple, si on a un serveur web sur le port 80 et un serveur web sur le port 8080, on peut créer un reverse proxy sur le port 80 qui redirigera les requêtes vers le serveur web sur le port 8080.

Docker est souvent utilisé pour lancer des applications. Il est donc possible de lancer un reverse proxy avec Docker. Pour cela, il faut utiliser l'image officielle de Nginx.

# Lancer un reverse proxy avec Docker

Pour lancer un reverse proxy avec Docker, on peut utiliser un docker-compose.yml. Ce fichier permet de définir les services à lancer et de créer des volumes. Dans notre cas, on va créer un volume pour les fichiers de configuration de Nginx.

```yaml
version: '3.7'

services:
  nginx:
    image: nginx:latest
    container_name: nginx
    restart: always
    ports:
      - 80:80
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
```

On peut ensuite créer le fichier de configuration de Nginx. Dans notre cas, on va créer un reverse proxy qui redirigera les requêtes vers un serveur web sur le port 8080.

```nginx
events {
  worker_connections 1024;
}

http {
  server {
    listen 80;
    location / {
      proxy_pass http://localhost:8080;
    }
  }
}
```

Il est possible de séparer les fichiers de configuration de Nginx. Pour cela, il faut créer un dossier `conf.d` et ajouter les fichiers de configuration dans ce dossier : 

- `default.conf` : fichier de configuration par défaut
- `reverse_proxy.conf` : fichier de configuration du reverse proxy
- `service.conf` : fichier de configuration du service

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

- [Docker : Nginx en reverse proxy](https://www.grottedubarbu.fr/docker-nginx-reverse-proxy/)
- [Using Free Let’s Encrypt SSL/TLS Certificates with NGINX](https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/?amp=1)
- [Documentation certbot](https://eff-certbot.readthedocs.io/en/stable/install.html#running-with-docker)
- [Setup SSL with Docker, NGINX and Lets Encrypt](https://www.programonaut.com/setup-ssl-with-docker-nginx-and-lets-encrypt/)
- [Simplest HTTPS setup: Nginx Reverse Proxy+ Letsencrypt+ AWS Cloud + Docker](https://leangaurav.medium.com/simplest-https-setup-nginx-reverse-proxy-letsencrypt-ssl-certificate-aws-cloud-docker-4b74569b3c61)
- [Nginx and Let’s Encrypt with Docker in Less Than 5 Minutes](https://leangaurav.medium.com/simplest-https-setup-nginx-reverse-proxy-letsencrypt-ssl-certificate-aws-cloud-docker-4b74569b3c61)
- [HTTPS using Nginx and Let's encrypt in Docker](https://mindsers.blog/post/https-using-nginx-certbot-docker/)