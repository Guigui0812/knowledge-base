---
title: MongoDB - Généralités et commandes
date: 2023-03-20 00:00:00
categories: [database, mongoDB]
tags: [database, mongoDB, script, nosql]
---

How to Create a `LIKE` Query in MongoDB

```SQL
SELECT * FROM table WHERE column LIKE '%value%'
```

In MongoDB, we can use the `$regex` operator to perform a `LIKE` query.

```mongodb
db.collection.find({column: {$regex: /.*value.*/}})
```