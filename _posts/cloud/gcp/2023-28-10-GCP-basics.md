---
title: Les bases de Google Cloud Platform (GCP)
date: 2023-10-28 00:00:00
categories: [cloud, gcp]
tags: [cloud, cloud computing, google cloud platform, gcp, cloud public, cloud hybride, IaaS, PaaS]
---

# Les bases de Google Cloud Platform (GCP)

Cet article n'est pas un article à proprement parle. Il s'agit des notes que je prends sur **Google Cloud Platform (GCP)** lors de mon apprentissage du provider sur [A Cloud Guru](https://acloudguru.com/). Je les partage ici pour les retrouver plus facilement et les partager.

**Google Cloud Platform (GCP)** est un cloud public proposé par **Google**. Il s'agit d'un cloud public, c'est-à-dire que les ressources sont partagées entre plusieurs clients. C'est le modèle le plus répandu et correspondant aux grands acteurs du cloud (AWS, Azure, GCP, etc.).

C'est le troisième plus grand fournisseur de services cloud derrière AWS et Azure, mais il est en forte croissance, surtout dans les domaines de l'IA et du Big Data.

Economiquement, on peut déjà distinguer **2 catégories de services** : 

- **Standard tier** : c'est l'offre classique et la plus économique, cependant l'accès aux ressources n'est pas garanti car il repose sur une connexion Internet. De plus, le client ne bénéficie pas de **PoP** (Point of Presence) ou **Edge Location** lui permettant d'accéder aux ressources via un accès dédié.

- **Premium tier** : c'est l'offre premium permettant un accès garanti aux ressources via des **PoP** (Point of Presence) ou **Edge Location**. 


## Les notions importantes

- **Region** : c'est un emplacement géographique dans lequel les ressources sont hébergées. 
- **Zone** : c'est un emplacement géographique dans une région. Une région est composée de plusieurs zones. Les zones sont indépendantes les unes des autres afin de garantir une haute disponibilité des ressources.
- **Edge Location** : c'est un emplacement physique permettant d'accéder aux ressources via un accès dédié. C'est un concept propre à GCP.

## Les services et concepts de base

### Virtual Private Cloud (VPC)

C'est un réseau privé virtuel dans lequel les ressources seront hébergées. On utilise alors des adresses IP privées pour les ressources. On peut étendre le masque `CIDR` du `VPC` en créant des sous-réseaux. On peut également faire du `VPC Network Peering` afin d'interconnecter différents réseaux : `VPC`, autres clouds, réseau on-premise, etc.

Les ressources internes au `VPC` peuvent communiquer entre elles via des adresses IP privées. Les ressources sont également accessibles depuis Internet via des adresses IP publiques. On peut également utiliser des `Cloud VPN` ou `Cloud Interconnect` pour accéder aux ressources via un accès dédié.

Le `routage` utilisé pour accéder aux ressources est le `routage dynamique` (BGP). On peut également utiliser le `routage statique` pour des besoins spécifiques. On pourra choisir un routage `global` ou `régional`.

### Fault Tolerance & High Availability

La `Fault Tolerance` est la capacité d'un système à continuer à fonctionner en cas de panne d'un de ses composants. 

Cette notion est possible grâce au fait que `GCP` utilise des `zones` indépendantes les unes des autres. Ainsi, si une zone tombe en panne, les autres zones continueront à fonctionner. Cela veut dire qu'on peut déployer des ressources dans plusieurs régions, dans des zones différentes afin de garantir la disponibilité des ressources.

La `High Availability` est la capacité d'un système à être disponible en permanence. Ici, on peut parler de `SLA` (Service Level Agreement) qui est un contrat de niveau de service. C'est un engagement de la part de `GCP` à garantir un certain niveau de disponibilité des ressources.

**Exemple :** Mise en place de bases de données dans deux zones différentes afin de garantir la disponibilité des données en cas de panne d'une zone.

### Compute Engine

C'est le service `IaaS` (Infrastructure as a Service) de `GCP`. Il permet de déployer des machines virtuelles dans le `VPC`. On peut choisir la taille de la machine virtuelle, le système d'exploitation, le stockage, etc.

Un `Compute Engine` peut être utilisé pour différents types de charges de travail :

- **Charges de travail généralistes** : serveurs web, serveurs d'applications, etc.
- **Calcul intensif** : calculs scientifiques, calculs financiers, etc.
- **Charges de travail à forte intensité de mémoire** : bases de données, electronic design automation (EDA), SAP, etc.
- **Charge de travail accélérées** : CUDA, TensorFlow, etc.
- **Scale out workloads** : google fonctionne en auto-scaling, pour offrir de la `high performance` et de la `high availability`.

L'utilisateur ne possède pas la machine virtuelle, par contre les données qui sont stockées dessus lui appartiennent. 

Il est possible de déployer des machines virtuelles avec des `disques persistants` ou des `disques locaux`. 
Les `disques persistants` sont des disques réseau, alors que les `disques locaux` sont des disques physiques de la machine virtuelle. 
Les `disques persistants` sont plus lents que les `disques locaux`, mais ils sont plus fiables car ils sont redondés.

### Google Cloud Storage

C'est le service de stockage objet de `GCP`. Il permet de stocker des `objets` dans des `buckets`, qui sont des conteneurs de stockage. 
Les `objets` sont n'importe quel type de données stockés dans les `buckets`. Ils peuvent être de n'importe quelle taille et de n'importe quel type. Ils sont accessibles via des `URL` et peuvent être publics ou privés.

Dès que les `objets` sont stockés dans les `buckets`, ils sont répliqués dans plusieurs `zones` afin de garantir la disponibilité des données. On dit qu'ils sont `globalement distribués` : on peut les récupérer depuis n'importe quelle **zone** ou **région**.

Il y a 4 classes de stockage :

- **Standard** : c'est la classe de stockage par défaut. C'est pour les données fréquemment accédées.Il n'y a pas de durée minimale de stockage et pas de charge de récupération.
- **Nearline** : c'est pour les données accédées moins d'une fois par mois. Il y a une durée minimale de stockage de 30 jours et une charge de récupération.
- **Coldline** : c'est pour les données accédées moins d'une fois par an. Il y a une durée minimale de stockage de 90 jours et une charge de récupération.
- **Archive** : c'est pour les données accédées moins d'une fois par an. Il y a une durée minimale de stockage de 365 jours et une charge de récupération.

Plusieurs options peuvent être choisies pour la protection des données :

- **Versioning** : permet de conserver les versions précédentes des objets.
- **Retention Policy** : permet de définir une durée de rétention des objets. Cette dernière est pratique pour la conformité aux réglementations du type `RGPD`.

### Les outils de développement de GCP

#### Les outils de développement

Pour le **développement** avec `GCP`, on peut utiliser `Cloud Code` qui est un plugin `IDE` pour `Visual Studio Code` ou `IntelliJ`. Il permet de développer des applications `Cloud Native` en utilisant les `API` de `GCP`.

**Google** met également à disposition `Google Cloud SDK` qui est un ensemble d'outils en ligne de commande permettant de gérer les ressources `GCP`. Il existe également des librairies pour les langages de programmation les plus courants : `Java`, `Python`, `Go`, etc.

#### Les outils de build

Google met à disposition `Cloud Source Repositories` qui est un service de `Git` hébergé. Il permet de stocker les sources des applications dans un repo privé. Il est possible de faire du `CI/CD` avec `Cloud Build` qui est un service de `CI/CD` hébergé. Il permet de faire du `CI/CD` avec `Cloud Source Repositories` ou `GitHub`. Ce service utilise des `containers` pour exécuter les `builds` de la même manière que les `Gitlab Runners`.

Ensuite, on peut citer `Artifact Registry` qui permet de stocker les images `Docker` et les `packages` de l'application. Il est possible de faire du `CI/CD` avec `Artifact Registry` et `Cloud Build`.

#### Les outils de déploiement

Pour le **déploiement** des applications, on peut utiliser `Cloud Run` qui est un service `PaaS` permettant de déployer des applications `Cloud Native` dans des `containers`. Ce service prend le code de l'utilisateur et le déploie dans un `container` qui est ensuite déployé dans un `cluster` de `Kubernetes` afin de garantir la haute disponibilité des ressources (scalabilité, redondance, etc.)

L'un des services phares de `GCP` est `GKE`. C'est le service déploiement de `Kubernetes` de `GCP`. Il permet de déployer des `clusters` de `Kubernetes` afin de déployer des applications `Cloud Native` dans des `containers`. 

Enfin on a `Deployment Manager` qui permet de déployer des ressources `GCP` en utilisant des `templates`. Ces derniers sont des fichiers `YAML` qui décrivent les ressources à déployer. C'est un service très pratique pour déployer des ressources de manière répétitive.

### Les outils de data analytics de GCP

Google met à disposition de nombreux outils afin de faire de l'analyse de données grâce à `GCP`.

`BigQuery` est le service `Data Warehouse` de `GCP`. Il permet de stocker des données structurées dans des `tables` et de faire des requêtes `SQL` sur ces dernières. En utilisant `BigQuery ML` ou `AI Platform`, il est possible de faire du `Machine Learning` sur les données stockées dans `BigQuery`.

Grâce à cela on va pouvoir réaliser des analyses prédictives et anticiper les besoins des clients.

Ensuite, afin de processer les data en temps réel, on peut utiliser `Dataflow` qui est un service `ETL` (Extract Transform Load) permettant de processer les données en temps réel. Il est possible de faire du `streaming` ou du `batch processing` avec `Dataflow`.
Il existe également `Pub/Sub` qui est un service de `messaging` permettant de faire du `streaming` de données. Il permet de faire du `streaming` de données entre les différentes applications de manière asynchrone.

A des fins de **Business Intelligence**, on peut utiliser `Data Studio` qui est un service de `BI` permettant de créer des rapports et des tableaux de bord afin de visualiser les données. Une alternative à cette solution est `Looker` qui est un service de `BI` permettant de créer des rapports et des tableaux de bord afin de visualiser les données.

Enfin, **Google** met à disposition des outils de **Data Science** comme `Apache Spark` ou évidemment `AI Platform` qui permettent de faire du `Machine Learning` sur les données stockées dans `BigQuery`.

### Les bases de données dans GCP

#### Les bases de données relationnelles

`Cloud SQL` est le service de base de données relationnelle de `GCP`. Il permet de déployer des bases de données relationnelles dans le `VPC`. Il prend en charge les moteurs `MySQL`, `PostgreSQL` ou `SQL Server` et permet de faire du `replication` afin de garantir la disponibilité des données.

`Cloud Spanner` est le service de base de données relationnelle distribuée de `GCP`. Il permet de déployer des bases de données relationnelles distribuées dans le `VPC`. Ce moteur peut prendre en charge jusqu'à 2 millions de requêtes par seconde et permet de faire du `replication` afin de garantir la disponibilité des données.

`BigQuery` est le service `Data Warehouse` de `GCP` qui stocke les données structurées dans des `tables` et permet de faire des requêtes `SQL` sur ces dernières. Il est très utilisé pour faire de la `Business Intelligence` et de l'analyse de données.

#### Les bases de données NoSQL

`BigTable` est le service de base de données `key-value` de `GCP` et est utilisé pour les tâches d'analyse de larges volumes de données. Cette base de données est très rapide et peut prendre en charge un grand nombre d'opération de lecture et d'écriture par seconde.

`Firestore` est un service de base de données `NoSQL` de type documents et est utilisé pour les applications web et mobiles. Il permet de stocker des données structurées et non structurées.

`Firebase` est un service de base de données orienté document de `GCP` et est utilisé pour les applications web et mobiles, notamment les tâches de synchronisation de données. Contrainrement à `Firestore`, `Firebase` est un service `serverless` et on parle parfois de `backend as a service` car il propose des services de login, de stockage de fichiers, de notifications push, etc.

`Memorystore` est un service de base de données `in-memory` de `GCP` et est utilisé pour le `cache` de données. Il utilise `Redis` ou `Memcached` et permet de stocker les données en mémoire afin d'accélérer les opérations de lecture et d'écriture.

### Le monitoring dans GCP

`Cloud Monitoring` est le service de monitoring de `GCP` qui permet de superviser les services, mettre en place des alertes, des tableaux de bord et obtenir des `metrics` sur les ressources `GCP`. 

Grâce à cela, on va pouvoir savoir si les ressources sont disponibles, si elles sont utilisées de manière optimale, etc.

On peut monitorer les `machines virtuelles`, les `bases de données`, les clusters `Kubernetes`, les `API`, etc.

On peut également monitorer les performances de nos applications avec `Tracing`, `Profiler` et `Audit Logs`.

### Les outils serveless de GCP

Le `serverless` est un modèle de déploiement d'applications dans lequel le fournisseur de cloud gère l'infrastructure sous-jacente. Le client ne s'occupe que du code de son application. Il ne s'occupe pas de la gestion des serveurs, de la mise à l'échelle, de la haute disponibilité, etc.

`Cloud Run` est un service `serverless` permettant de déployer des applications `Cloud Native` dans des `containers` en utilisant les langages de programmation les plus courants : `Java`, `Python`, `Go`, etc. 

`Cloud Functions` est un service `serverless` de type `pay-as-you-go` permettant de déployer et d'exécuter du code dans un environnement sans aucun service à gérer. Il permet de déclencher des actions en fonction d'événements. Il est possible d'utiliser les langages de programmation les plus courants : `Java`, `Python`, `Go`, etc.

`Service Integrations` permet d'automatiser, combiner, planifier et connecter des services entre eux. Il permet de créer des `workflows` afin d'automatiser des tâches de manière synchrone ou asynchrone.

L'intérêt du serverless est de ne pas avoir à gérer les services et l'infrastructure puisque `GCP` gère l'ensemble pour nous. On va ainsi pouvoir concevoir des applications entièrement `serverless`.

### Le déploiement d'applications dans GCP

#### Cloud Shell


`Cloud Shell` est un service de `GCP` permettant d'exécuter des commandes `Linux` dans le navigateur. Il permet d'interagir avec les ressources `GCP` en utilisant les outils de `Cloud SDK`. Il permet également d'installer des outils de développement comme `Git`, `Docker`, `Kubectl` ou `Terraform` sur la machine virtuelle.

`Cloud Shell` embarque `gcloud` qui est un outil en ligne de commande permettant d'interagir avec les ressources `GCP`. Il permet de créer des ressources, de les gérer, de les supprimer, etc.

Quelques commandes `gcloud` :

- `gcloud config set project <project_id>` : permet de définir le projet `GCP` sur lequel on va travailler.
- `gcloud container clusters create <cluster_name> --zone <zone>` : permet de créer un cluster `Kubernetes`.
- `gcloud compute zones list` : permet de lister les `zones` disponibles.
- `gcloud app deploy` : permet de déployer une application `App Engine`.


