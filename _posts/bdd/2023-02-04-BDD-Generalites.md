---
title: Quelques généralités sur les bases de données
date: 2023-02-04 00:00:00
categories: [database, nosql, bdd relationnelle]
tags: [database, sql, nosql]
---

Une base de données est un ensemble de données organisées de manière à ce qu'elles soient facilement accessibles, gérées et mises à jour.

Un système de gestion de base de données (SGBD) est une collection de programmes qui permettent de stocker, de modifier et d'extraire des informations d'une base de données (mySQL, Oracle, PostgreSQL, MongoDB, etc.).

# Paradigmes des bases de données

## Pourquoi les bases de données sont importantes ?
- Stockage et récupération efficace des informations 
- Collecte et stockage d’informations cruciales via différentes applications
- Comprendre les données, déterminer un rapport à partir de celles-ci qui permettra de prédire les tendances futures
- Permet d’assurer un accès facile à des informations cruciales 
- Aide à l’analyse et à la décision

## Qui utilise les bases de données ?
- Concepteur de la base de données 
- Administrateur de la base de données
- Programmeur d’applications 
- Data analyst
- Utilisateurs finaux

## Quelques structures de bases de données

- **Bases de données hiérarchiques** : structurées via une relation parent-enfant
- **Bases de données réseau** : similaire aux bases de données hiérarchiques, mais l'enfant peut accéder aux données du parent grâce à une relation bidirectionnelle
- **Bases de données orientées objet** : données stockées comme des objets (avec des attributs)
- **Bases de données temporelles** : permet de stocker et requêter des données temporelles (Time Series)
- **Bases de données relationnelles** : stockage des données sous forme de relations (tables)
- **Bases de données non relationnelles ou NoSQL** : stockage des données sous forme de documents, de clés-valeurs, de graphes, etc.

Un SGDB relationnel permet de créer, mettre à jour et interroger des bases de données relationnelles. Il permet de créer des tables, de les modifier, de les supprimer, de les remplir, de les interroger, etc. La plupart sont basés sur le langage SQL.

Un SGBD non relationnel permet de stocker tout type de contenu dans une seule base de données. Le paradigme le plus populaire est NoSQL (Not Only SQL). 

## Caraactéristiques du NoSQL

- Permet de le stockage de gros volumes de données (Big Data)
- Architecture distribuée et scalabilité horizontale : redondance des données sur plusieurs serveurs
- Réplique des données sur plusieurs stockages
- Schéma dynamique ou absence de schéma
- Open source

Le NoSQL ne remplace pas le SGBD relationnel, mais il est utilisé pour des applications spécifiques. Il n'est ni meilleur ni pire, il est différent.

## Différences entre SQL et NoSQL

| SQL / BDD Relationnelles | NoSQL / BDD non relationnelle |
| --- | --- |
| Modèle relationel | Modèle non relationnel |
| Stockage dans des tables | Stockage dans des collections |
| Schéma prédéfini et strict (réduit le nb d'erreurs) | Schéma dynamique (plus flexible et pratique pour le big data) MAIS problème de fiabilité car pas de schéma spécifique|
| Requêtes SQL | Requêtes spécifiques |
| Modèle normalisé pour réduire la duplication à l'aide de clés étrangères | Modèle non normalisé, admet la duplication mais rend difficile la mise à jour (le faire pour chaque détail) |

## Deux principes 

### SQL et ACID

- **Atomicité** : requiert à ce qu’une transaction soit totale ou rien, si une partie échoue, toute la transaction échoue.
- **Consistance** : toutes les données de la base doivent être valides selon toutes les règles définies.
- **Isolation** : les transactions lancées simultanément ne doivent pas interférer les unes avec les autres. 
- **Durabilité** :  toutes les transactions lancées demeurent même en cas de perte de puissance, de collisions ou d’erreurs.

### NoSQL et BASE

- **Basically Available** : dispobilité assurées les 2/3 du temps (théorème CAP - Consistency, Availability, Partition tolerance)
- **Soft State** : l'état du système peut évoluer, même sans opération en raison d'éventuelles cohérences
- **Eventual consistency** : cohérence atteinte à terme, le système finit toujours par converger vers un état cohérent dès qu'il cesse de recevoir des entrées

## Avantages et inconvénients

| SQL / BDD Relationnelles | NoSQL / BDD non relationnelle |
| --- | --- |
| **Avantages** </br> Normalisation </br> clé étrangère </br> intégrité </br> CRUD basé sur SQL </br> représentation réaliste | **Avantages** </br> Evolutivité </br> Schéma flexible |
| **Inconvénients** </br> Rigidité </br> Evolution horizontale complexe | **Inconvénients** </br> Pas de schéma </br> Pas de jointure </br> Pas de transactions </br> Pas de requêtes SQL |

## Typologie des bases de données NoSQL

- **Bases de données clé-valeur** : stockage de données sous forme de clé-valeur (Redis, DynamoDB, etc.).

- **Bases de données document** : stockage de données sous forme de documents (MongoDB, CouchDB, etc.). Chaque document possède ses propres doonées et sa propre clé unique, utilisée pour le récupérer. Les documents peuvent contenir plusieurs paires clé-valeur, ou clé-tableau, ou des documents imbriqués.

- **Bases de données graphes** : stockage de données sous forme de graphes (Neo4j, etc.). Les données sont stockées sous forme de noeuds et de relations entre ces noeuds.

- **Bases de données colonnes** : stockage de données sous forme de colonnes (Cassandra, HBase, etc.). Les données sont stockées sous forme de colonnes et de lignes. Ces bases de données sont très performantes pour les ensemble de données volumineux.