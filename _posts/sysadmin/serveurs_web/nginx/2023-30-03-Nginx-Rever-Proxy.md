---
title: Créer un reverse proxy avec Nginx et Docker
date: 2023-03-30 00:00:00
categories: [sysadmin, nginx, reverse_proxy, docker]
tags: [serveurs_web, nginx, reverse_proxy, docker]
---

Nginx permet de créer un reverse proxy. Un reverse proxy permet de rediriger les requêtes HTTP/HTTPS qu'il reçoit. Par exemple, si on a un serveur web sur le port 80 et un serveur web sur le port 8080, on peut créer un reverse proxy sur le port 80 qui redirigera les requêtes vers le serveur web sur le port 8080.

Docker est souvent utilisé pour lancer des applications. Il est donc possible de lancer un reverse proxy avec Docker. Pour cela, il faut utiliser l'image officielle de Nginx.

## Lancer un reverse proxy avec Docker

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

#### Liens utiles

- [Docker : Nginx en reverse proxy](https://www.grottedubarbu.fr/docker-nginx-reverse-proxy/)