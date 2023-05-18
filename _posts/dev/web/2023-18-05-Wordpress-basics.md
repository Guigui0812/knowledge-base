---
title: Notes sur Wordpress
date: 2023-05-18 00:00:00
categories: [dev, web, wordpress]
tags: [dev, web, wordpress]
---

**Wordpress** est un CMS (Content Management System) qui permet de créer des sites web. Il est très simple à utiliser et permet de créer rapidement des sites web. Ici je stocke des notes sur l'utilisation de Wordpress et différents liens utiles.

J'utilies Wordpress pour développer des sites pour mes proches car il permet ensuite de laisser la main à l'utilisateur final pour la gestion du site. Même si j'apprécie le développement web, je n'ai pas envie de devenir le webmaster de mes proches.

## Développement Wordpress avec Docker

Plutôt que d'utiliser **PhpMyAdmin** et **MySQL** pour gérer la base de données, j'utilise **Docker** pour créer un environnement de développement. Cela permet de ne pas avoir à installer **PhpMyAdmin** et **MySQL** sur la machine de développement. Cela permet également de pouvoir développer sur n'importe quelle machine, même si elle n'est pas sous Windows.

Afin de faciliter mes déploiements, j'ai créé un docker-compose.yml qui permet de créer un environnement de développement pour Wordpress. Il suffit de lancer la commande `docker-compose up -d` pour lancer l'environnement de développement.

```yaml
version: '3.1'

services:

  wordpress:
    image: wordpress
    restart: always
    ports:
      - 8080:80
    environment:
      WORDPRESS_DB_HOST: <wordpress_db>
      WORDPRESS_DB_USER: <wordpress_user>
      WORDPRESS_DB_PASSWORD: <wordpress_password>
      WORDPRESS_DB_NAME: <wordpress_db>
    volumes:
      - wp:/var/www/html

  db:
    image: mysql:latest
    restart: always
    environment:
      MYSQL_DATABASE: <mysql_db>
      MYSQL_USER: <mysql_user>
      MYSQL_PASSWORD: <mysql_password>
      MYSQL_ROOT_PASSWORD: <mysql_root_password>
    volumes:
      - db:/var/lib/mysql

volumes:
  wp:
  db:
```

Cependant, il y a des soucis de performance avec **Wordpress** sous **Docker** avec **Windows**. 

#### Liens utiles

- [Wordpress - Docker Hub](https://hub.docker.com/_/wordpress)
