---
title: MongoDB - Généralités et commandes
date: 2023-03-20 00:00:00
categories: [database, mongoDB]
tags: [database, mongoDB, script, nosql]
---

MongoDB est une base de données NoSQL orientée document. Elle est écrite en C++ et est disponible sous licence AGPL. Elle est développée par MongoDB Inc. depuis 2007. MongoDB est une base de données orientée document, ce qui signifie que les données sont stockées sous forme de documents JSON. MongoDB est distribuée sous licence AGPL. MongoDB est une base de données orientée document, ce qui signifie que les données sont stockées sous forme de documents JSON. MongoDB est distribuée sous licence AGPL.

## Commandes de base

### Obtenir tous les éléments d'une collection

```mongodb
db.collection.find()
```

### Obtenir un élément d'une collection

```mongodb
db.collection.find({id: 1})
```


### Obtenir un élément d'une collection avec un filtre

```mongodb
db.collection.find({id: 1, name: "John"})
```





How to Create a `LIKE` Query in MongoDB

```SQL
SELECT * FROM table WHERE column LIKE '%value%'
```

In MongoDB, we can use the `$regex` operator to perform a `LIKE` query.

```mongodb
db.collection.find({column: {$regex: /.*value.*/}})
```