---
title: MongoDB - Commandes du shell mongo
date: 2023-03-20 00:00:00
categories: [Bases de données, mongoDB]
tags: [database, mongoDB, script, nosql]
---


# MongoDB - Généralités

MongoDB est une base de données NoSQL orientée document. MongoDB est une base de données open source, écrite en C++ et développée par MongoDB Inc. MongoDB est une base de données orientée document, ce qui signifie que les données sont stockées sous forme de documents JSON. MongoDB est distribuée sous licence AGPL.

Ce SGBD offre une grande flexibilité et une grande performance (haute disponibilité, scalabilité horizontale, etc.). Elle repose sur les concepts de collections et de documents.

## Concepts

**Base de données MongoDB** : conteneur physique pour les collections. Chaque base possède son ensemble de fichiers. Un serveur MongoDB peut contenir plusieurs bases de données. Une base peut contenir plusieurs collections.

**Collection MongoDB** : groupement de documents. C'est l'équivalent d'une table dans une base de données relationnelle. Une collection existe dans une seule base de données. Elles n'imposent pas de schéma de données. Généralement, une collection contient des documents qui ont des champs similaires ou connexes.

**Document MongoDB** : enregistrement. C'est l'équivalent d'une ligne dans une base de données relationnelle. Un document est un ensemble de paires clé/valeur. Ils ont un schéma dynamique et les champspeuvent conteni différents types de données.

## Syntaxe d'un document MongoDB

```json
{
    "name": "John",
    "age": 30,
    "address": {
        "street": "Main Street",
        "city": "New York"
    },
    "hobbies": ["football", "basketball", "tennis"]
}
```

MongoDB utilise le format JSON pour stocker les données. Les documents sont stockés sous forme de BSON (Binary JSON). BSON est un format de données binaires qui est plus efficace que le JSON car offre des fonctionnalités supplémentaires.

Un document JSON représente un arbre dont les noeuds sont des paires clé/valeur ou des tableaux. 

**Règles de syntaxe** :
- Ne contient qu'une seule racine par document
- tout ficher json est soit un objet ({...}) soit un tableau ([...])
- Les virgules sont obligatoires entre les paires clé/valeur
- Un objet peut contenir d'autres objets ou des tableaux.
- Pas d'éléments croisés entre les objets et les tableaux
- Un objet peut contenir plusieurs paires clé/valeur et plusieurs tableaux

# Gérer des bases de données avec le shell mongo

Le shell mongo est en charge de l'interpretation des commandes mongoDB. Il est possible de lancer le shell mongo en ligne de commande ou de lancer le shell mongo depuis un script.


Plusieurs commandes sont disponibles pour gérer les bases de données et les collections dans mongoDB.

#### Lancer le shell mongo

```bash
mongosh
```

Cette commande va lancer le shell mongo en ligne de commande.

#### Créer une base de données

```mongodb
use mydb
```

Cette commande va créer une base de données nommée mydb.

#### Vérifier la base de données courante

```mongodb
db
```

Cette commande va retourner la base de données courante.

#### Vérifier les bases de données

```mongodb
show dbs
```

Cette commande va retourner la liste des bases de données.

#### Supprimer une base de données

```mongodb
db.dropDatabase()
```

Cette commande va supprimer la base de données courante.

#### Créer une collection

```mongodb
db.createCollection("mycollection")
```

Cette commande va créer une collection nommée mycollection.

#### Lecture d'une collection

```mongodb
db.mycollection.find()
```

Cette commande va retourner tous les éléments de la collection mycollection.

#### Renommer une collection

```mongodb
db.mycollection.renameCollection("newcollection")
```

Cette commande va renommer la collection mycollection en newcollection.

#### Supprimer une collection

```mongodb
db.collection.drop()
```

Cette commande va supprimer la collection.

# Opérations sur les collections

Plusieurs commandes sont disponibles pour gérer les collections dans mongoDB. Le nom de ces opérations est le CRUD (Create, Read, Update, Delete).

## Les types de données

MongoDB supporte les types de données suivants :

* String
* Integer
* Double
* Boolean
* Date
* Object
* Array
* Null
* ObjectId
* Code

## Les insertions

#### Insertion d'un document

```mongodb
db.mycollection.insertOne({name: "John", age: 30})
```

Cette commande va insérer un document dans la collection mycollection.

#### Insertion de plusieurs documents

```mongodb
db.mycollection.insertMany([{name: "John", age: 30}, {name: "Jane", age: 25}])
```

Cette commande va insérer plusieurs documents dans la collection mycollection.

## Les mises à jour

#### Mise à jour d'un document

```mongodb
db.mycollection.updateOne({name: "John"}, {$set: {age: 31}})
```

Cette commande va mettre à jour le document dont le nom est John.

```mongodb
db.mycollection.findOneAndUpdate({name: "John"}, {$set: {age: 31}})
```

Cette commande va mettre à jour le document dont le nom est John et retourner le document mis à jour.

Possibilité d'utiliser des options supplémentaires :

* upsert : si le document n'existe pas, il sera créé

```mongodb
db.mycollection.findOneAndUpdate({name: "John"}, {$set: {age: 31}}, {upsert: true, new: true})
```

#### Mise à jour de plusieurs documents

```mongodb
db.mycollection.updateMany({name: "John"}, {$set: {age: 31}})
```

Cette commande va mettre à jour tous les documents dont le nom est John.

## Les suppressions

#### Suppression d'un document

```mongodb
db.mycollection.deleteOne({name: "John"})
```

Cette commande va supprimer le document dont le nom est John.

```mongodb
db.mycollection.findOneAndDelete({name: "John"})
```

Cette commande va supprimer le document dont le nom est John et retourner le document supprimé.

#### Suppression de plusieurs documents

```mongodb
db.mycollection.deleteMany({name: "John"})
```

Cette commande va supprimer tous les documents dont le nom est John.

#### Suppression de tous les documents

```mongodb
db.mycollection.deleteMany({})
```

## Opérations de lecture

#### Lecture d'un document

```mongodb
db.mycollection.findOne({name: "John"})
```

Cette commande va retourner le premier document dont le nom est John.

#### Lecture de plusieurs documents

```mongodb
db.mycollection.find({name: "John"})
```

Cette commande va retourner tous les documents dont le nom est John.

#### Lecture de tous les documents

```mongodb
db.mycollection.find()
```

Cette commande va retourner tous les documents de la collection mycollection.

#### Afficher les données dans un format plus lisible

```mongodb
db.mycollection.find().pretty()
```

Cette commande va retourner tous les documents de la collection mycollection avec un format plus lisible (indentation, saut de ligne).

#### Afficher uniquement certains champs

```mongodb
db.mycollection.find({}, {name: 1})
```

Cette commande va retourner tous les documents de la collection mycollection avec uniquement le champ name.

#### Lecture de tous les documents avec un tri

```mongodb
db.mycollection.find().sort({name: 1})
```

Cette commande va retourner tous les documents de la collection mycollection triés par nom.

#### L'objet cursor

Lorsque l'on interroge une collection, mongoDB retourne un objet cursor. Cet objet contient les résultats de la requête. Dans un premier temps, le shell affiche les 20 premiers résultats. Pour afficher les résultats suivants, il faut utiliser la méthode `it()`.

```mongodb
db.mycollection.find().it()
```

Pour itérer sur tous les résultats, il faut convertir l'objet cursor en tableau.

```mongodb
var mycursor = db.mycollection.find().toArray()
```

Pour accéder à un élément du tableau, il faut utiliser l'index de l'élément.

```mongodb
mycursor[0]
```

### Quelques opérations conditionnelles

#### Opérateur d'égalité

```mongodb
db.mycollection.find({name: "John"})
```

Cette commande va retourner tous les documents dont le nom est John.

#### Opérateur $gt

```mongodb
db.mycollection.find({age: {$gt: 30}})
```

Cette commande va retourner tous les documents dont l'age est supérieur à 30.

#### Opérateur $gte

```mongodb
db.mycollection.find({age: {$gte: 30}})
```

Cette commande va retourner tous les documents dont l'age est supérieur ou égal à 30.

#### Opérateur $lt

```mongodb
db.mycollection.find({age: {$lt: 30}})
```

Cette commande va retourner tous les documents dont l'age est inférieur à 30.

#### Opérateur $lte

```mongodb
db.mycollection.find({age: {$lte: 30}})
```

Cette commande va retourner tous les documents dont l'age est inférieur ou égal à 30.

#### Opérateur $ne

```mongodb
db.mycollection.find({age: {$ne: 30}})
```

Cette commande va retourner tous les documents dont l'age est différent de 30.

#### Opérateur $in

```mongodb
db.mycollection.find({age: {$in: [30, 31]}})
```

Cette commande va retourner tous les documents dont l'age est égal à 30 ou 31.

#### Opérateur $size

```mongodb
db.mycollection.find({hobbies: {$size: 2}})
```

Cette commande va retourner tous les documents dont le champ hobbies contient 2 éléments.

#### Opérateur $and

```mongodb
db.mycollection.find({$and: [{name: "John"}, {age: 30}]})
```

Cette commande va retourner tous les documents dont le nom est John et l'age est 30.

#### Opérateur $or

```mongodb
db.mycollection.find({$or: [{name: "John"}, {age: 30}]})
```

### Réaliser une projection

Une projection permet de sélectionner les champs à retourner dans la requête.

```mongodb
db.mycollection.find({}, {name: 1, age: 1})
```

Cette commande va retourner tous les documents de la collection mycollection avec uniquement les champs name et age.

### Réaliser un tri

#### Tri ascendant

```mongodb
db.mycollection.find().sort({name: 1})
```

Cette commande va retourner tous les documents de la collection mycollection triés par nom (ordre croissant).

#### Tri descendant

```mongodb
db.mycollection.find().sort({name: -1})
```

Cette commande va retourner tous les documents de la collection mycollection triés par nom (ordre décroissant).

### Limiter le nombre de résultats

```mongodb
db.mycollection.find().limit(2)
```

Cette commande va retourner les 2 premiers documents de la collection mycollection.

### Afficher à partir d'un certain index

```mongodb
db.mycollection.find().skip(2)
```

Cette commande va retourner tous les documents de la collection mycollection à partir du 3ème document.

## Import et export de données

### Exporter une collection

```mongodb
mongoexport --db mydb --collection mycollection --out mycollection.json
```

Cette commande va exporter la collection mycollection dans le fichier mycollection.json.

### Importer une collection

```mongodb
mongoimport --db mydb --collection mycollection --file mycollection.json
```

Cette commande va importer la collection mycollection depuis le fichier mycollection.json.

## Quelques exemples

#### Afficher les 2 premiers documents dont le nom est John

```mongodb
db.mycollection.find({name: "John"}).limit(2)
```

#### Afficher les documents à partir du 3ème dont le nom est John, l'âge est supérieur à 30 et le nombre de hobbies est égal à 2 triés par nombre de hobbies

```mongodb
db.mycollection.find({name: "John", age: {$gt: 30}, hobbies: {$size: 2}}).skip(2).sort({hobbies: 1})
```

#### Afficher les documents où age est supérieur à 30 et où le nombre de hobbies est supérieur à 2

```mongodb
db.mycollection.find({$and: [{age: {$gt: 30}}, {hobbies: {$size: 2}}]})
```
#### Afficher le nom en ordre décroissant SANS le champ _id

```mongodb
db.mycollection.find({}, {name: 1, _id: 0}).sort({name: -1})
```

#### Commande avec un or 

```mongodb
 db.ColEtu.find({$or: [{nom:'GATES'}, {nom:'Musk'}]}, {nom: 1, _id: 0}).sort({nom:-1})
```

#### Afficher un élément d'un attribut tableau d'un document

```mongodb
db.ColEtu.find({}, {cours:{code: 1}})
```

#### Afficher les éléments dont le numéro de rue est supérieur à 10 et inférieur à 20

```mongodb
db.ColEtu.find({$or:[{"adresse.num":{$gt:10}}, {"adresse.num":{$lt:20}}]}, {cours:{code:1}})
```

#### Afficher les éléments dont le numéro de rue est compris dans l'intervalle [10, 15]

```mongodb
db.ColEtu.find({"adresse.num":{$in:[10, 11, 12, 13, 14, 15]}}, {cours:{code:1}}).sort({"adresse.num":1})
// Version avec limite : 
db.ColEtu.find({"adresse.num":{$in:[10, 11, 12, 13, 14, 15]}}, {cours:{code:1}}).sort({"adresse.num":1}).limit(2)
```