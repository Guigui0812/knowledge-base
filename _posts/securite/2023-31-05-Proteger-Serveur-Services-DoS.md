---
title: Protéger un serveur et ses services contre les attaques DoS
date: 2023-03-19 00:00:00
categories: [securite]
tags: [securite, serveur, dos, attaque]
---

Tout le monde a déjà entendu parler d'une attaque DoS (Denial of Service) ou DDoS (Distributed Denial of Service). Ces attaques sont très courantes et peuvent être très dangereuses pour les entreprises et les particuliers. Ces attaques peuvent mettre hors service un site web, un serveur ou un service en ligne pendant plusieurs heures, voire plusieurs jours.

## Qu'est-ce qu'une attaque DoS ?

Une attaque DoS est une attaque qui vise à rendre un service indisponible en le surchargeant de requêtes. L'objectif est de saturer la bande passante du serveur ou de le faire planter.


# Protéger l'application contre les attaques par déni de service

**A DEPLACER DANS UNE CATEGORIE SECU**

Les attaques par déni de service consistent à rendre une application ou un service indisponible en surchargeant les ressources disponibles. Dans cette catégorie, on retrouve par exemple le ***DDOS*** (Distributed Denial Of Service) qui consiste à surcharger un serveur en envoyant un grand nombre de requêtes simultanées.

Il existe plusieurs manières de protéger une application contre les attaques par déni de service.

## Limiter les requêtes par IP

Une manière de protéger une application contre les attaques par déni de service est de limiter le nombre de requêtes par IP. Ainsi, si une IP effectue un grand nombre de requêtes, on peut la bloquer pour éviter de surcharger les ressources du serveur.

Cela est possible en utilisant des outils comme [Fail2Ban](https://www.fail2ban.org/wiki/index.php/Main_Page) mais aussi en utilisant des services tiers comme [Cloudflare](https://www.cloudflare.com/fr-fr/), ou une solution maison.

## Utiliser des outils de monitoring

Lorsqu'elle est déployée en ***production***, une application est exposée à des attaques par déni de service. Il est important de surveiller ses performances afin de détecter les éventuelles attaques par déni de service. Pour cela, on peut utiliser des services de surveillance comme [Sentry](https://sentry.io/welcome/), [Datadog](https://www.datadoghq.com/) ou [Prometheus](https://prometheus.io/). 

L'intérêt d'utiliser ces outils en ***production*** va être d'identifier une montée en charge anormale des serveurs ou une augmentation du trafic. Ainsi, on pourra détecter les attaques par déni de service et réagir rapidement. 

## Utiliser des outils de protection contre les attaques par déni de service

Il existe des outils qui permettent de protéger les applications contre les attaques par déni de service.  Ces outils sont conçus pour surveiller en permanence le réseau, les systèmes et les applications, à la recherche de comportements ou de schémas d'activité anormaux qui pourraient indiquer une tentative d'intrusion.

Ils utilisent diverses techniques pour détecter les attaques comme l'analyse des journaux, la surveillance du trafic réseau, l'analyse comportementale et l'apprentissage automatique. Ils peuvent identifier des modèles de trafic malveillant, des tentatives d'exploitation de vulnérabilités connues, des scans de ports, des activités de bruteforce, des accès non autorisés et d'autres comportements suspects.

Une fois qu'une activité suspecte est détectée, les outils de détection d'intrusion peuvent déclencher des alertes ou des notifications pour avertir les administrateurs du système. Cela permet une réponse rapide et appropriée pour contrer les attaques et minimiser les dommages potentiels.

Il est important de configurer et de maintenir correctement ces outils, en mettant à jour régulièrement les signatures de détection et les règles de sécurité, ainsi qu'en surveillant attentivement les alertes générées.
