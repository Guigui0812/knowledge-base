---
title: Notes cours de virtualisation ESIEE
date: 2023-09-04 00:00:00
categories: [ESIEE, virtualisation]
tags: [sysadmin, virtualisation]
---

# Définitions

## Virtualisation

**Virtualisation** : Technique consistant à faire fonctionner un ou plusieurs systèmes d’exploitation, sur un ou plusieurs serveurs ou machine individuelle. Les ressources physiques de plusieurs machines peuvent être partagées entre plusieurs machines virtuelles.

**Intérêt** : 
- Permet le partage des ressources d’une même machine physique. 
- Permet de soustraire le facteur matériel de l’équation, les machines virtuelles en deviennent indépendantes.

**Machine hôte** : machine exécutant les différents systèmes d'exploitation

**Machine invitée** : machine virtuelle s’éxécutant dans l’environnement de virtualisation

## Le système d'exploitation

Pourquoi décoréler le système d'exploitation de la machine physique ? Pour isoler les applications et les données de la machine physique, et ainsi sécuriser les données.

# Les concepts de la virtualisation

## Serveurs physiques vs serveurs virtuels

### Approche classique des serveurs physiques

1 serveur = 1 service

Inconvénient : 
- Pas de redondance
- Pas de scalabilité (car il faut tout remonter)
- Utilisation des ressources non optimisée
- Pas de haute disponibilité

Il faut un parc homogène si on souhaite déplacer les données d'un serveur à un autre. Si ce n'est pas le cas, on peut avoir des problèmes de compatibilité entre les architectures.

### Approche des serveurs virtuels

**Anecdote** : on peut virtualiser sous Windows avec Hyper V, mais le Windows Server sera donc lui même une machine virtuelle émulée par Hyper V. 

Avantages : 
- Disponibilité
- Optimisation des ressources
- Redondance
- Scalabilité

Inconvénients :
- Coût élevé
- Problèmes si redondance inefficace (si le serveur physique tombe, toutes les machines virtuelles tombent)

Prix : 7000€ pour une licence ESXi

Concept important : on a des réseaux virtuels, donc on peut déplacer les machines virtuelles d'un serveur à un autre sans problème de compatibilité.

Pour avoir une redondance, on va avoir plusieurs ESXi, et on va avoir un serveur qui va gérer la répartition de charge entre les ESXi. On va avoir un serveur qui va gérer la répartition de charge entre les ESXi. On va pouvoir utiliser un vCenter pour gérer les ESXi et les faire transiter d'un serveur à un autre. On peut, selon la licence, migrer les machines virtuelles à chaud ou à froid. A chaud, on ne verrait pas la différence, à froid, on va avoir une coupure de service.

## Concepts de virtualisation

Isolation : Machines invitées complètement indépendantes
Para-virtualisation : Machines invitées qui tournent sur un hyperviseur
Virtualisation complète : Machines invitées qui tournent par dessus un hyperviseur, qui tourne au dessus d'un système d'exploitation

### Isolation

Overhead très faible: coût en ressources

### Para-virtualisation (Type 1)

Conscience d'être virtualisé : adaptation des drivers à la machine. 

Vérifier si les instructions de virtualisation sont activées pour virtualiser dans le BIOS. On peut faire tourner que du 32 bit si on active pas.

### Virtualisation complète (Type 2)

Pas de conscience d'être virtualisé, donc ça peut poser des problèmes sur des OS spécifiques.

**Remarque WSL** : implémentation particulière de l'isolation. Ils ont implémenté les logiciels de contrôle linux dans le noyau windows. Il n'y a pas d'hyperviseur, c'est directement dans le kernel Windows au niveau des drivers. 

**Emuler des cartes réseaux** : problèmes avec les adresses mac (spoofer les adresses mac)

## La conteneurisation

Docker et la containerisation sont des technologies de virtualisation qui sont hérités du concept d'isolation. C'est une catégorie cependant très spécifique de la virtualisation.

De plus, c'est pas réellement de l'isolation car on ouvrir des ports et créer des volumes. Un container n'est donc pas réellement isolé.

Technologies : 
- Docker
- Podman
- Open Container

## La virtualisation des postes de travail

Besoin de croissant de ressources, notamment les développeurs. Sauf qu'on ne peut pas pouvoir fournir des machines physiques suffisamment puissantes pour les dev. 

Fournir des machines qui vont serveur d'interfaces pour se connecter à des postes de travail virtuels bien plus puissants.

## Cloud Computing


Définition des termes IAAS / PAAS / SAAS

AWS : IAAS / PAAS
Azure : IAAS / PAAS
Ikoula : IAAS
Office 365 : SAAS
OVH : IAAS / PAAS
Google Apps : SAAS
OpenShift : PAAS (surcouche kub)
Dropbox : SAAS
Hetzner : IAAS / PAAS

# Les solutions du marché

- VirtualBox : type 2
- KVM : Récupération du KERNEL dans l'hyperviseur. C'est type 1 car les binaires de KVM sont directement intégrés au noyau linux.
- Hyper-V : type 1 mais systèmes 64 bits indispensable. 

L'architecture de Hyper-V est très complexe (voir schéma). C'est organisé en ring avec différents niveaux en fonction des applications.

- Virtual PC : test de Microsoft pour virtualiser des postes de travail. 

## VMware

...

# Le stockage

Pourquoi virtualiser le stockage ? Pour la fiabilité, assurer l'évolutivité et assurer une haute disponibilité.

### DAS

Direct Attached Storage : stockage directement connecté à la machine. Pas d'agent réseau. 

### NAS

Network Attached Storage : stockage connecté au réseau.

On ne travaille qu'au niveau des fichiers, pas au niveau des blocs.

### SAN

C'est le système de fichier qui reconstruit le fichier. On travaille au niveau des blocs qui sont envoyés et reçus par le SAN dans les disques virtuels.

## Système de stockage RAID

Vérifier le nombre minimal de disques requis. 

Possibilité de combiner les RAID.

Exemple : 

Avec 12 disques on va faire un RAID 510 ()


## Green IT

Intérêt de la virtu pour ça : revendre des équipements un peu moins puissant à d'autres entreprises avec des besoins moins importants.

On est capable de recycler les machines physiques grâce à la virtualisation car on décorelle le système d'exploitation de la machine physique, on peut utiliser la machine en support d'une infrastructure.

Cependant y a du green washing: certaines entreprises disent que c'est plus facile à recycler, mais c'est pas vrai car c'est exactement la même chose qu'un serveur physique.

