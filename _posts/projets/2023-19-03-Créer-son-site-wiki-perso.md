---
title: Crée son site wiki personnel avec Jekyll
date: 2023-03-19 00:00:00
categories: [documentation, projets]
tags: [web development, documentation, sysadmin,  wiki, jekyll, github, markdown]
---

Afin de centraliser mes connaissances, j'ai décidé de créer un site wiki personnel. Ce site est généré par Jekyll, outil créé par Github. Jekyll est un générateur de site statique, c'est à dire qu'il ne nécessite pas de serveur web pour fonctionner. Il suffit de lancer la commande `jekyll serve` pour lancer le serveur de développement. Jekyll est donc un outil idéal pour créer un site wiki personnel. Cependant, j'ai décidé de l'héberger sur mon propre VPS. Pour cela, j'ai utilisé Docker et NGINX. De cette manière, j'ai pu apprendre à déployer un site web avec Docker et NGINX. 

## Prérequis

- Un VPS avec Docker et NGINX installés
- Une connaissance de base de Docker et NGINX
- Une connaissance de base de Jekyll

## Installation et configuration de Jekyll

Dans un premier temps, j'ai créé le site localement sur mon PC. Il faut donc installer Ruby et Jekyll. Pour cela, je vous invite à suivre ce tutoriel : [Jekyll - Documentation](https://jekyllrb.com/docs/). Une fois Jekyll installé, il faut créer un nouveau site. Cependant, il est possible de créer un site à partir d'un thème existant. J'ai choisi le thème [Chirpy](https://chirpy.cotes.page/posts/getting-started/). La procédure d'installation est expliquée dans la documentation du thème. Une fois le site créé, il faut le tester en local. Pour cela, il suffit de lancer la commande `jekyll serve`. Le site est alors accessible à l'adresse `http://localhost:4000`.

Afin d'avoir un site plus personnalisé, il faut modifier le fichier `_config.yml`. Ce fichier contient toutes les informations du site. Il faut donc modifier les informations suivantes :

- `title` : le titre du site
- `description` : la description du site
- `url` : l'adresse du site
- `baseurl` : le chemin du site
- `author` : l'auteur du site
- `email` : l'email de l'auteur
- `twitter_username` : le nom d'utilisateur Twitter de l'auteur
- `github_username` : le nom d'utilisateur Github de l'auteur
- `linkedin_username` : le nom d'utilisateur Linkedin de l'auteur
- `locale` : la langue du site
- `timezone` : le fuseau horaire du site
- `markdown` : le moteur de rendu Markdown

Une fois ces éléments personnalisés, il faut ajouter les pages du site. Pour cela, il faut créer un fichier `.md` dans le dossier `_posts`. Ce fichier doit respecter le format suivant :

```markdown
---
title: Crée son site wiki personnel avec Jekyll
date: 2023-03-30 00:00:00
categories: [documentation]
tags: [web development, documentation, sysadmin,  wiki, jekyll, github, markdown]
---
Contenu de la page
```

Le contenu de la page est écrit en Markdown. Pour plus d'informations sur le Markdown, je vous invite à consulter ce tutoriel : [Markdown Guide](https://www.markdownguide.org/). Une fois les pages créées, il faut les tester en local. Pour cela, il suffit de lancer la commande `jekyll serve`. Le site est alors accessible à l'adresse `http://localhost:4000`.

Cependant, il peut être intéressant de dockeriser le site afin de le rendre plus portable. 

## Dockerisation du site

Pour dockeriser le site, il faut créer un fichier `Dockerfile` à la racine du site. Ce fichier contient les instructions pour créer l'image Docker. Le fichier `Dockerfile` doit contenir les instructions suivantes :

```dockerfile
FROM jekyll/jekyll:latest

WORKDIR /srv/jekyll

COPY . .

RUN bundle install

EXPOSE 4000

CMD ["jekyll", "serve", "--watch", "--force_polling", "--host", "0.0.0.0"]
```

Le dockerfile est basé sur l'image Docker `jekyll/jekyll:latest`. Cette image contient Jekyll et Ruby. Le fichier `Dockerfile` copie le site dans le conteneur Docker. Il installe ensuite les dépendances du site. Enfin, il lance le serveur de développement de Jekyll. Pour lancer le conteneur Docker, il suffit de lancer la commande `docker run -p 4000:4000 -v $(pwd):/srv/jekyll -it jekyll/jekyll:latest`. Le site est alors accessible à l'adresse `http://localhost:4000`.

Cependant, il est possible de créer un fichier `docker-compose.yml` afin de lancer le conteneur Docker plus facilement. Le fichier `docker-compose.yml` doit contenir les instructions suivantes :

```yaml
version: '3.8'

services:
  jekyll_website:
    image: my-jekyll-site
    container_name: jekyll_website
    volumes:
      - ".:/srv/jekyll"
    ports:
      - "4000:4000"
```

Pour lancer le conteneur Docker, il suffit de lancer la commande `docker-compose up`. Le site est alors accessible à l'adresse `http://localhost:4000`. Pour le lancer en tant que démon, il suffit de lancer la commande `docker-compose up -d`. Pour arrêter le conteneur Docker, il suffit de lancer la commande `docker-compose down`.

## Déploiement sur un VPS

J'ai choisi d'héberger mon site sur un VPS. Pour cela, j'ai utilisé mon serveur *Hostinger*.

Lors de mes recherches, j'ai réfléchi à la manière dont je voulais héberger mon site. Dans un premier temps, j'ai tenté de faire une nouvelle image du site basée sur **ruby:3.0** mais je me suis heurté à de nombreuses problématiques. 

### Image Docker

En effet, exposer un conteneur Docker sur internet peut être dangereux. J'avais donc décidé de créer une image spécifique pour mon site. Cependant, j'ai rencontré de nombreux problèmes. En effet, j'ai dû installer Ruby, Jekyll et les dépendances du site. J'ai également dû créer un utilisateur spécifique pour lancer le serveur de développement de Jekyll. Malgré mes tentatives, j'avais constamment des problèmes de droits.

Tentative d'image : 

```dockerfile
FROM ruby:3.0

# Installation des dépendances
RUN apt-get update && \
    apt-get install -y build-essential && \
    gem install jekyll bundler

# Création d'un utilisateur non-root pour la sécurité
RUN addgroup --system jekyll_group && adduser --system jekyll_user --ingroup jekyll_group
USER jekyll_user

# Définition du répertoire de travail
WORKDIR /srv/jekyll

# Exécution des commandes pour générer le site
RUN bundle install

# Commande par défaut pour exécuter le serveur Jekyll
CMD ["bundle", "exec", "jekyll", "serve", "--watch", "--force_polling", "--host", "0.0.0.0"]
```

Exemple de problème :

```bash
PermissionError There was an error while trying to write to `/usr/local/bundle/cache/racc-1.6.2.gem`. It is likely that you need to grant write permissions for that path.
```

J'ai donc décidé de conservé l'image de base de Jekyll.

### Installation de Docker et de Docker Compose sur le VPS

Pour installer Docker sous Debian, il faut suivre les instructions suivantes : [Install Docker Engine on Debian](https://docs.docker.com/engine/install/debian/). Ensuite, pour Docker Compose, il faut suivre les instructions suivantes : [Install Docker Compose](https://docs.docker.com/compose/install/).

### Docker Compose

Afin de faciliter le déploiement du site, j'ai décidé d'utiliser Docker Compose. Docker Compose permet de définir et de lancer des applications Docker en utilisant un fichier YAML. Pour cela, il faut créer un fichier `docker-compose.yml` à la racine du site. Ce fichier contient les instructions pour créer le conteneur Docker. Le fichier `docker-compose.yml` doit contenir les instructions suivantes :

```yaml
version: '3.8'

services:
  jekyll_website:
    image: my-jekyll-site
    container_name: jekyll_website
    volumes:
      - ".:/srv/jekyll"
    ports:
      - "4000:4000"
    
networks:
  default:
    name: shared-network  
    external: true
```

Le fichier `docker-compose.yml` définit un service nommé `jekyll_website`. Ce service utilise l'image `my-jekyll-site`. Le service utilise le volume `./:/srv/jekyll` afin de partager le site avec le conteneur Docker. Le service expose le port `4000` du conteneur Docker sur le port `4000` du serveur. Le fichier `docker-compose.yml` définit également un réseau nommé `shared-network`. Ce réseau est utilisé pour partager le réseau entre le conteneur Docker et le serveur web.

### Serveur Web

Pour héberger mon site, j'ai utilisé le serveur web **Nginx**. Cependant, dans le but de concevoir une organisation propice à mes futurs projets et de mettre en ligne différents sites, j'ai décidé de créer un reverse proxy. Le reverse proxy permet de rediriger les requêtes HTTP vers les différents conteneurs Docker. Pour cela, j'ai configuré le serveur web **Nginx** en tant que reverse proxy. 

Mon reverse proxy possède un docker-compose.yml spécifique. Ce fichier contient les instructions pour créer le conteneur Docker. Le fichier `docker-compose.yml` doit contenir les instructions suivantes :

```yaml
version: '3.8'

services:
  reverseproxy:
    image: nginx:latest
    container_name: nginxrp
    volumes:
      - ./conf/core.conf:/etc/nginx/conf.d/core.conf
      - ./conf/proxy.conf:/etc/nginx/conf.d/proxy.conf
      - ./conf/jekyll.conf:/etc/nginx/conf.d/jekyll.conf
    ports:
      - "80:80"
      - "443:443"
    depends_on:
      - jekyll_website
     
networks:
  default:
    name: shared-network
    external: true
```

J'ai conçu mon reverse proxy de la manière suivante :
- Le reverse proxy utilise un fichier `core.conf` qui contient les configurations de base du serveur web.
- Le reverse proxy utilise un fichier `proxy.conf` qui contient les configurations du reverse proxy.
- Chaque projet qui a vocations à être hébergé sur le serveur possède un fichier `*.conf` qui contient les configurations spécifiques au projet.

De cette manière, il est possible de créer un nouveau projet et de l'héberger sur le serveur web. Il suffit de créer un nouveau fichier `*.conf` dans le dossier `conf` du reverse proxy. 

De plus, cette technique permet d'avoir des préfixes pour les différents sites. Par exemple, le site wiki possède le préfixe `wiki`. Ainsi, le site wiki est accessible à l'adresse `http://wiki.guillaume-rohee.me`. Chaque projet pourra avoir un préfixe différent.

### Configuration du reverse proxy

Article en cours d'écriture...

J'ai choisi de versionner les configurations du reverse proxy. Cela permet de garder une trace des modifications apportées au serveur web. De plus, cela permet de partager les configurations avec d'autres personnes.

### Démarage du site

La configuration du Nginx est disponible dans le dépôt [Guigui0812/vps-nginx](https://github.com/Guigui0812/vps-nginx)

Lorsque ces différents éléments sont configurés, il est possible de lancer le site en utilisant la commande suivante :

```bash
docker-compose up -d
```

Il faut la lancer pour chaque projet. D'abord, il faut démarrer le site puis démarrer le reverse proxy. De cette manière, le reverse proxy pourra rediriger les requêtes HTTP vers le site. Dans le docker-compose.yml du reverse proxy, il faut ajouter le service du site dans la section `depends_on`.

Mon objectif prochain est d'automatiser le déploiement du site. Pour cela, j'ai décidé d'utiliser **Github Actions**. Github Actions permet de définir des workflows qui seront exécutés lors d'événements. :

### Conclusion

Ce projet m'a permis de perfectionner mon usage de docker, de découvrir Jekyll et la mise en place un reverse proxy. Ce site a vocation à évoluer et à devenir un site de documentation pour mes futurs projets et ma veille technologique.

#### Liens utiles :

- [Jekyll - Documentation](https://jekyllrb.com/docs/)
- [Meet Jekyll - Techno Tim](https://www.youtube.com/watch?v=F8iOU1ci19Q&t=897s)
- [Jekyll - Github Pages](https://pages.github.com/versions/)
- [Tutoriel Jekyll : tout ce qu’il faut savoir - IONOS](https://www.ionos.fr/digitalguide/hebergement/blogs/jekyll/)
- [How to build an efficient personnal knowledge management system - axtonliu](https://axtonliu.medium.com/how-to-build-an-efficient-personal-knowledge-management-system-355332ae5991)
- [Markdown Guide](https://www.markdownguide.org/)
- [Chirpy - Jekyll Theme](https://chirpy.cotes.page/posts/getting-started/)
- [Markdown in VScode - VScode](https://code.visualstudio.com/docs/languages/markdown#_markdown-preview)
- [A personnal git repo as a knowledge base wiki](https://dev.to/adam_b/a-personal-git-repo-as-a-knowledge-base-wiki-j51)
- [Simple NGINX with Docker for beginners ](https://www.youtube.com/watch?v=qxPdd-geqqA)
- [Docker Compose and Jekyll](https://urre.me/writings/docker-compose-and-jekyll/)
- [Building a blog with Jekyll, Docker and GitLab](https://voutzinos.com/blog/jekyll-docker-gitlab-blog/)
- [Musing around a dockerfile for jekyll](https://blog.frankel.ch/musings-dockerfile-jekyll/)