---
title: Généralités et notions de base sur le cloud
date: 2023-10-28 00:00:00
categories: [cloud]
tags: [cloud, cloud computing, cloud privé, cloud public, cloud hybride, cloud communautaire, IaaS, PaaS, SaaS]
---

# Les bases du cloud computing

## Définition

Le Cloud Computing est un modèle qui permet d'accéder à des ressources informatiques à la demande via un réseau, généralement Internet. Ces ressources peuvent être des serveurs, des applications, des bases de données, des outils de stockage, etc. L'intérêt est de fournir des services informatiques à la demande, sans avoir à gérer l'infrastructure sous-jacente.

Ainsi, les clients ne possèdent pas les infrastructures, mais les louent à un fournisseur de services. Le fournisseur de services est responsable de la gestion de l'infrastructure, de la maintenance, de la mise à jour, de la sécurité, etc. Le client n'a plus qu'à se concentrer sur son métier et payer uniquement les ressources qu'il utilise, à la demande.

Il y a 3 modèles de services :

- **Cloud Public** : il s'agit d'un cloud qui est accessible à tous. Les ressources sont partagées entre plusieurs clients. C'est le modèle le plus répandu et correspondant aux grands acteurs du cloud (AWS, Azure, GCP, etc.).
- **Cloud Privé** : il s'agit d'un cloud qui est accessible à une seule entité. Les ressources sont dédiées à un seul client. C'est le modèle le plus sécurisé, mais aussi le plus coûteux.
- **Cloud Hybride** : il s'agit d'un cloud qui est composé d'un cloud privé et d'un cloud public. 

## Pourquoi le cloud ?

Le Cloud offre de nombreux avantages aux entreprises : 

- **Speed to market** : le cloud permet de déployer rapidement des ressources informatiques. Il suffit de quelques minutes pour déployer un serveur, une base de données ou une application. Cela permet de réduire le time-to-market et de répondre rapidement aux besoins des clients.
- **Scalabilité** : le cloud permet de faire évoluer les ressources informatiques en fonction des besoins. Il est possible d'augmenter ou de diminuer les ressources en fonction de la demande.
- **Optimisation des coûts** : le cloud permet de réduire les coûts informatiques. Il n'est plus nécessaire d'acheter des serveurs, des licences, etc. Il suffit de louer les ressources dont on a besoin. De plus, le cloud permet de réduire les coûts de maintenance, de mise à jour, de sécurité et d'énergie.
- **Redondance** : le cloud permet de réduire les risques de pannes. Les ressources sont réparties sur plusieurs serveurs et plusieurs datacenters. Ainsi, si un serveur ou un datacenter tombe en panne, les ressources sont automatiquement basculées sur un autre serveur ou un autre datacenter.
- **Sécurité** : Les fournisseurs de services cloud mettent en place des mesures de sécurité pour protéger les données des clients. De plus, du fait de la répartition des données sur plusieurs serveurs et plusieurs datacenters, les données sont toujours disponibles même si un serveur est compromis.
- **Disponibilité** : le cloud permet d'assurer une disponibilité des ressources 24h/24 et 7j/7. Les fournisseurs de services cloud mettent en place des mesures de sécurité pour assurer une disponibilité des ressources en cas de panne.

## Les types de cloud

### SaaS (Software as a Service)

Il s'agit de fournir des applications à la demande. Les applications sont hébergées sur le cloud et accessibles via un navigateur web. Les utilisateurs n'ont pas besoin d'installer l'application sur leur ordinateur ou n'importe quel autre appareil. 

**Exemples :** Google Workspace, Office 365, Salesforce, Dropbox, Slack, etc.

### PaaS (Platform as a Service)

Il s'agit de fournir une plateforme de développement et de déploiement d'applications à la demande. Les développeurs peuvent développer et déployer des applications sans avoir à gérer l'infrastructure sous-jacente. Dans ce modèle, le client gère uniquement l'application et les données. Le fournisseur de services s'occupe de l'infrastruture sous-jacente (serveurs, stockage, réseau, etc.).

**Exemples :** AWS Elastic Beanstalk, Heroku, Google App Engine, etc.

### IaaS (Infrastructure as a Service)

Il s'agit de fournir des ressources informatiques à la demande. Les ressources peuvent être des serveurs, des réseaux, du stockage, etc. Le client gère les applications, les données, le runtime, le middleware, et le système d'exploitation. Le fournisseur de services s'occupe de l'infrastructure sous-jacente (serveurs, stockage, réseau, etc.).

**Exemples :** AWS, Azure, GCP, etc.

### CaaS (Containers as a Service)

Il s'agit de fournir des conteneurs à la demande. Les conteneurs sont des environnements d'exécution isolés qui permettent d'exécuter des applications. Dans ce modèle, le client crée et gère les conteneurs. Le fournisseur de services s'occupe de l'infrastructure sous-jacente (serveurs, stockage, réseau, etc.).

**Exemples :** AWS ECS, Azure Container Instances, GCP Cloud Run, etc.

### FaaS (Functions as a Service)

Il s'agit de fournir des fonctions à la demande. Les fonctions sont des petits morceaux de code qui peuvent être exécutés à la demande. Dans ce modèle, le client crée et gère les fonctions. Le fournisseur de services s'occupe de l'infrastructure sous-jacente (serveurs, stockage, réseau, etc.) permettant d'exécuter les fonctions.

**Exemples :** AWS Lambda, Azure Functions, GCP Cloud Functions, etc.

