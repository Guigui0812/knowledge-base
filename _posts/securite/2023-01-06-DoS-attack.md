---
title: Attaques par déni de service (DoS et DDoS) - Définition, fonctionnement et protection
date: 2023-05-31 00:00:00
categories: [securite]
tags: [securite, serveur, dos, attaque]
---

Tout le monde a déjà entendu parler d'une attaque **DoS (Denial of Service)** ou **DDoS (Distributed Denial of Service)**. Il s'agit d'un type d'attaque répandu qui vise à surcharger un serveur en envoyant un grand nombre de requêtes simultanées.

# Comment fonctionne une attaque DoS ou DDoS ?

Dans un premier temps, il faut différencier les attaques DoS et DDoS. Une attaque DoS est une attaque qui vise à surcharger un serveur en envoyant un grand nombre de requêtes simultanées depuis une seule machine. Une attaque DDoS est une attaque qui vise à surcharger un serveur en envoyant un grand nombre de requêtes simultanées depuis plusieurs machines.

Cependant, ces deux attaques fonctionnent de la même manière, à l'exclusion du nombre de machines impliquées dans l'attaque. L'objectif est de surcharger un serveur en envoyant un grand nombre de requêtes simultanées. Pour cela, les attaquants utilisent des machines infectées par des virus ou des logiciels malveillants. Ces machines sont appelées des ***bots***. Les attaquants les contrôlent à distance et les utilisent pour envoyer des requêtes au serveur cible. Lorsque ce dernier reçoit un grand nombre de requêtes simultanées, il est surchargé et ne peut plus répondre aux demandes légitimes.

Dans le cadre d'une attaque de grande envergure, les attaquants utilisent des ***botnets***. Il s'agit d'un réseau de machines infectées par des virus ou des logiciels malveillants. Les attaquants contrôlent ces machines à distance et les utilisent pour envoyer des requêtes au serveur cible. Pour contrôler ces réseaux, ils utilisent des logiciels dédiés appelés des ***botnet clients***. Ils sont généralement installés sur les machines infectées par des virus ou des logiciels malveillants. L'ensemble des clients sont contrôlés par un ***botnet controller*** qui est le serveur de contrôle du botnet. 

**Quelques exemples d'outils de DDoS** :
- [LOIC](https://www.cloudflare.com/fr-fr/learning/ddos/ddos-attack-tools/low-orbit-ion-cannon-loic/)
- [HOIC](https://www.cloudflare.com/fr-fr/learning/ddos/ddos-attack-tools/high-orbit-ion-cannon-hoic/) 
- [Trinoo](https://en.wikipedia.org/wiki/Trinoo)

Ces outils sont généralement utilisés par des ***script kiddies***. Il s'agit de personnes qui utilisent des outils développés par d'autres personnes pour lancer des attaques sans avoir de connaissances techniques approfondies.

L'attaque réussit si le service visé ne répond plus ou si ses performances sont dégradées. Dans certains cas, l'attaque peut également entraîner une indisponibilité du réseau.

## Les différents types d'attaques DoS et DDoS

Il existe plusieurs catégories d'attaques DoS et DDoS. Chaque catégorie d'attaque a un objectif différent. 

### Attaques de la couche applicative

Les attaques de la couche applicative visent à surcharger les ressources d'une application. Elles sont généralement plus difficiles à détecter et à contrer que les attaques de la couche réseau.

**Rappel** : La couche applicative est la couche la plus élevée du modèle OSI. Elle est responsable de l'interaction entre l'application et l'utilisateur. Elle permet à l'utilisateur d'accéder aux services de l'application.

Ce type d'attaque consiste, à l'aide d'une ou plusieurs machines, à cibler une page web ou une application en envoyant un grand nombre de requêtes simultanées. Les ressources du serveur applicatif sont alors surchargées afin de répondre aux multiples demandes, ce qui entraîne une indisponibilité du service puisque l'application crash sous le poids des requêtes.

Ces attaques sont très difficiles à contrer car compliquées à détecter car il est difficile de différencier les requêtes légitimes des requêtes malveillantes.

**Exemple de méthode - HTTP Flood** : cette attaque se comporte comme si un utilisateur légitime accédait à une page web ou tentait de la recharger. Cependant, contrairement à un utilisateur légitime, l'attaquant envoie un grand nombre de requêtes simultanées. Le serveur est alors surchargé et ne peut plus répondre aux requêtes légitimes.

Ces attaques peuvent être simples ou complexes selon leur implémentation. Les versions simples peuvent accéder à une seule URL avec la même plage d'adresses IP et les mêmes agents utilisateurs. Les versions complexes peuvent utiliser un grand nombre d'adresses IP d'attaque et cibler des URL aléatoires en utilisant des agents utilisateurs variés.

**Agents utilisateurs** : on détecte les agents avec les headers HTTP `User-Agent` et `X-Forwarded-For`. Ces headers sont utilisés pour identifier le navigateur, le système d'exploitation, le type d'appareil et la version du logiciel utilisé par l'utilisateur. 

### Attaques de protocole

Les attaques de protocole visent à exploiter les faiblesses des protocoles de communication pour affaiblir des équipements réseau comme les pare-feux et les ***load balancers***. Les protocoles ciblés sont généralement les protocoles de la couche 3 et de la couche 4 du modèle OSI.

**Couche 3** : C'est la ***couche réseau*** du modèle OSI. Elle est responsable de l'identification des hôtes dans le réseau, de la fragmentation des données en paquets IP et de l'acheminements de ces derniers entre les hôtes en déterminant le meilleur chemin à l'aide de protocoles de routage (OSPF, RIP, BGP, etc.).

**Couche 4** : C'est la ***couche transport*** du modèle OSI. Elle est responsable de la fiabilité de la communication entre les hôtes. Elle permet de segmenter les données en unités plus petites appelées segments et de les envoyer à la couche réseau. Elle permet également de réassembler les segments reçus en données. Les protocoles de la couche 4 sont ***TCP*** et ***UDP***. L'aspect le plus connu de cette couche est le ***port***. Il s'agit d'un numéro de 16 bits qui identifie une application ou un service sur un hôte.

**Exemple d'attaque - SYN Flood** : 

Le SYN Flood consiste à envoyer un grand nombre de requêtes SYN à un serveur. Le serveur répond à chaque requête par un paquet SYN-ACK et attend une réponse. Cependant, l'attaquant ne répond pas, ce qui entraîne une surcharge du serveur. Le serveur ne peut plus répondre aux requêtes légitimes et devient indisponible.

L'intérêt de cette attaque est donc d'utiliser le mécanisme de fiabilité de la connexion du protocole TCP pour surcharger le serveur. 

**SYN** : Le paquet SYN est le premier paquet d'une connexion TCP. Il est envoyé par le client pour demander une connexion au serveur. Le serveur répond par un paquet SYN-ACK pour confirmer la demande de connexion. Le client répond alors par un paquet ACK pour confirmer la connexion.

### Attaques volumétriques

Les attaques DDoS volumétriques exploitent les opérations normales d'Internet pour créer d'énormes flux de trafic réseau qui consomment la bande passante de l'organisation ciblée, rendant ainsi ses ressources indisponibles. Contrairement à l'opinion courante, la plupart des attaques DDoS ne génèrent pas un trafic élevé. Moins de 1% de toutes ces attaques sont volumétriques. Les attaques volumétriques sont simplement davantage médiatisées en raison de leur caractère sensationnel.

Le but de ce type d'attaque est de contrôler toute la bande passante disponible entre la victime et Internet. L'amplification du système de noms de domaine (DNS) en est un exemple. Dans ce scénario, l'attaquant usurpe l'adresse de la cible, puis envoie une demande de recherche de nom DNS à un DNS ouvert avec l'adresse usurpée.
Lorsque le serveur DNS envoie la réponse contenant les enregistrements DNS, elle est envoyée à la cible, ce qui entraîne une amplification de la requête initialement petite de l'attaquant.

Cette catégorie d'attaques tente de créer une congestion en consommant toute la bande passante disponible entre la cible et Internet. De grandes quantités de données sont envoyées à une cible en utilisant une forme d'amplification ou un autre moyen de créer un trafic massif, tel que des demandes provenant d'un botnet.

# Protection contre les attaques par déni de service

Comme démontré précédemment, les attaques par déni de service peuvent être très dangereuses pour une application. Elles peuvent entraîner une indisponibilité de l'application et donc une perte de revenus pour l'entreprise. De plus, l'existence d'outils permettant à des ***script kiddies*** de lancer ces attaques les rend encore plus dangereuses puisqu'elle peuvent être perpétrées par n'importe qui.

Cependant, il existe plusieurs manières de détecter et d'empêcher ces attaques, qu'elles soient de type **DoS** ou **DDoS**.

## Stratégies de réponses aux attaques DoS et DDoS

### Se protéger contre les attaques DoS

Se protéger des attaques DoS est assez simple. Il suffit de mettre en place des règles de pare-feu qui bloquent les adresses IP qui envoient un grand nombre de requêtes. Cependant, cette méthode n'est pas efficace contre les attaques DDoS qui utilisent un grand nombre d'adresses IP différentes puisque basées sur des ***botnets***.

### Se protéger contre les attaques DDoS

Afin de contrer les attaques DDoS, il est nécessaire de mettre en place une stratégie de réponse à incident. Cette stratégie doit être définie en amont afin de pouvoir être appliquée rapidement en cas d'attaque. Elle doit également être testée régulièrement afin de s'assurer de son efficacité.

Il est important de communiquer pendant le déroulé de la stratégie, que ce soit auprès des utilisateurs, des responsables de l'entreprise ou des clients. De même, il faudra informer sur les conséquences de l'attaque auprès des responsables de l'entreprise : pertes de données, pertes financières, etc.

#### Etape 1 : Détection

L'infrastructure doit être équipée d'outils permettant de détecter l'attaque à un stade précoce. Ces outils peuvent être des IDS, des IPS ou des outils de ***Netflow***. Ces outils permettent de détecter les attaques en analysant le trafic réseau et le contenu des paquets. Ils peuvent également être utilisés pour détecter les attaques au niveau applicatif en analysant les journaux d'application.

#### Etape 2 : Filtrage

Aussitôt détecté, il est nécessaire de mettre en place des règles de filtrage afin d'endiguer le trafic malveillant. Cela passe par la mise en place de règles sur les dispositifs réseaux comme les **pare-feu**. 

#### Etape 3 : Diversion et redirection

Afin de protéger les ressources critiques de l'infrastructure, il peut être intéressant de rediriger le trafic malveillant vers d'autres ressources. Cela permet de protéger les ressources critiques et de continuer à fournir le service aux utilisateurs légitimes.

#### Etape 4 : Analyse

Il est important de comprendre la source et le fonctionnement de l'attaque. Cela permet d'adapter la réponse et de perfectionner la stratégie de réponse à incident. 

Cette phase d'analyse peut être conduite par une équipe de sécurité ou par un prestataire externe. Elle consiste en plusieurs mesures :
- Analyse des journaux d'application
- Analyse des logs de pare-feu, de routeurs et de commutateurs
- Analyse des logs de serveurs
- Inspection détallée des paquets

#### Etape 5 : Activer une CDN

En cas d'attaque, il peut être intéressant de prévoir une connexion alternative afin de pouvoir continuer à fournir le service aux utilisateurs légitimes. Dès lors, une fois l'attaque détectée, il est possible de rediriger le trafic vers cette connexion alternative afin de garantir la continuité du service.

## Techniques de protection spécifiques

Afin de se protéger contre ces attaques, une stratégie de réponse seule n'est pas suffisante. Il faut également mettre en place un certain nombre de techniques. 

### Limiter les requêtes par IP

Cette méthode est la plus simple à mettre en place, mais elle n'est efficace que contre les attaques DoS. Ici, la stratégie est simplement de bloquer les requêtes provenant d'une même IP si le nombre de requêtes dépasse un certain seuil. 

**Cela permet de bloquer les attaques DoS simples, mais pas les attaques DDoS qui utilisent un grand nombre d'IP différentes**.

Cette opération est une règle à mettre en place au niveau du pare-feu. Il est possible de le faire manuellement, mais il existe aussi des outils comme [Fail2Ban](https://www.fail2ban.org/wiki/index.php/Main_Page) qui permettent de le faire automatiquement. 

### Utiliser des outils de monitoring

Il est important d'être en capacité de détecter la survenue de ce type d'attaques. Pour cela, il est nécessaire de surveiller les **infrastructures de production** à l'aide d'outils de monitoring comme [Zabbix](https://www.zabbix.com/), [Nagios](https://www.nagios.org/) ou [Prometheus](https://prometheus.io/). Ces outils permettent de surveiller les ressources du système comme le CPU, la mémoire, le disque, etc. Ils permettent également de surveiller les applications et les services en vérifiant qu'ils sont bien en fonctionnement et qu'ils répondent correctement aux requêtes.

Si les systèmes de supervision sont bien configurés, ils permettent de détecter les attaques par déni de service. En effet, ces attaques se traduisent par une augmentation anormale du nombre de requêtes reçues par l'application,, une augmentation du temps de réponse des requêtes, une augmentation de la charge CPU, etc. Dès lors, il est possible de paramétrer des alertes sur les outils afin de détecter ces comportements anormaux et de pouvoir réagir rapidement.

### Blackhole routing (route vers une adresse IP qui n'existe pas)

Une des solutions les plus simples pour se protéger contre les attaques par déni de service est de créer un trou noir. Cette solution consiste à créer une route vers une adresse IP qui n'existe pas. Ainsi, toutes les requêtes envoyées à cette adresse IP seront perdues et ne pourront pas atteindre l'application.

L'intérêt est qu'en cas d'attaque, l'administrateur réseau peut simplement rediriger le trafic vers cette adresse IP et ainsi empêcher les requêtes d'atteindre l'application. Cela permet de limiter les dégâts en attendant de trouver une solution plus pérenne. En effet, il ne s'agit pas d'une solution optimale puisque cela revient à rendre l'application indisponible à la fois pour le trafic légitime et malveillant.

### Utiliser des outils de protection spécialisés

Face à l'augmentation de ces attaques, il existe aujourd'hui des outils spécialisés dans la protection contre les attaques par déni de service. Ces outils permettent de détecter les attaques et de les bloquer automatiquement. 

**Quelques services** : 

- [Cloudflare DDoS Protection](https://www.cloudflare.com/fr-fr/ddos/) : Protection contre les attaques de niveau 3, 4 et 7. Il s'agit de la solution gratuite la plus sophistiquée. 
- [Akamai DDoS Protection](https://www.akamai.com/fr/solutions/security/ddos-protection) : Une solution reconnue dans le domaine de la protection contre les attaques par déni de service.
- [AWS Shield](https://aws.amazon.com/fr/shield/) : Protection contre les attaques de niveau 3 et 4. Disponible gratuitement pour les clients AWS. La protection contre les attaques applicatives de niveau 7 est disponible pour un coût supplémentaire.

#### Liens et ressources

- [What is a DDoS attack? - CloudFlare](https://www.cloudflare.com/learning/ddos/what-is-a-ddos-attack/)
- [What is DDoS Attack? - Fortinet](https://www.fortinet.com/resources/cyberglossary/ddos-attack)
- [What Is a DDoS Attack and How Does It Work? - CompTIA](https://www.comptia.org/content/guides/what-is-a-ddos-attack-how-it-works)
- [Qu'est-ce qu'une attaque DDoS ? - Akamai](https://www.akamai.com/fr/glossary/what-is-ddos)
- [Attaque par déni de service - Wikipédia](https://fr.wikipedia.org/wiki/Attaque_par_d%C3%A9ni_de_service)
- [Mitigation de DDoS - Wikipédia](https://fr.wikipedia.org/wiki/Mitigation_de_DDoS)
- [What is a denial of service attack (DoS) ? - Paloalto](https://www.paloaltonetworks.com/cyberpedia/what-is-a-denial-of-service-attack-dos)
- [What is a Botnet? - Paloalto](https://www.paloaltonetworks.com/cyberpedia/what-is-botnet)
- [Own a WiFi network with Python! - David Bombal](https://www.youtube.com/watch?v=XUncozRGbcs)
- [How to DDoS | DoS and DDoS attack tools - Cloudflare](https://www.cloudflare.com/learning/ddos/ddos-attack-tools/how-to-ddos/)