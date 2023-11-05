---
title: Bonnes pratiques en Python
date: 2023-04-18 00:00:00
categories: [dev, python]
tags: [python, dev]
---

Bien que Python soit un langage très simple à apprendre, il est important de respecter certaines bonnes pratiques afin de faciliter la lecture et la maintenance du code. 

# Bonnes pratiques et conventions : la bible PEP 8

## PEP 8

Comme tout langage de programmation, Python possède ses propres bonnes pratiques et conventions. Celles-ci sont décrites dans le [PEP 8](https://www.python.org/dev/peps/pep-0008/). Il s'agit d'un document qui décrit les bonnes pratiques de codage pour le langage Python. Il est recommandé de le lire et de le suivre pour écrire du code Python de qualité.

Plusieurs éléments sont décrits dans le PEP 8, tels que :

- l'indentation
- les lignes blanches
- les commentaires
- les noms de variables
- les noms de fonctions
- les noms de classes

L'intérêt de suivre ces bonnes pratiques est de rendre le code plus lisible et plus facile à maintenir. En effet, si tout le monde suit les mêmes conventions, il est plus facile de comprendre le code écrit par quelqu'un d'autre. 
  
## L'utilisation d'un linter

Un linter est un outil qui permet d'analyser le code source et de signaler les erreurs de syntaxe, les erreurs de style et les erreurs logiques. Il permet de vérifier que le code respecte les bonnes pratiques et conventions du langage.

En Python, l'un des linters les plus utilisés est [Black](https://github.com/psf/black). Il s'agit d'un linter qui permet de vérifier que le code respecte les bonnes pratiques du PEP 8. Il permet également de formater automatiquement le code pour qu'il respecte ces bonnes pratiques.

# Le Clean Code en Python

Le Clean Code, également appelé code propre, fait référence à un style d'écriture de code qui privilégie la lisibilité, la maintenabilité et la simplicité. Il s'agit de produire un code compréhensible et facile à maintenir pour les développeurs, en suivant des principes et des bonnes pratiques de programmation.

**Le Clean Code repose sur plusieurs concepts et principes clés** :

- Clarté et lisibilité: Le code doit être écrit de manière claire et compréhensible pour les autres développeurs. Cela implique d'utiliser des noms de variables et de fonctions explicites, d'éviter les abréviations cryptiques et de maintenir une structure logique.

- Simplicité: Le code doit être simple et éviter toute complexité inutile. Cela signifie favoriser la simplicité d'implémentation plutôt que la sophistication technique, en utilisant des concepts et des constructions simples lorsque cela est possible.

- Principe de responsabilité unique (Single Responsibility Principle, SRP): Chaque module, classe ou fonction doit avoir une seule responsabilité clairement définie. Cela facilite la compréhension du code et rend les modifications plus faciles à effectuer.

- Principe d'ouverture/fermeture (Open/Closed Principle, OCP): Les entités logicielles doivent être ouvertes à l'extension mais fermées à la modification. Cela signifie qu'il est possible d'ajouter de nouvelles fonctionnalités sans avoir à modifier le code existant.

- Principe de substitution de Liskov (Liskov Substitution Principle, LSP): Les instances d'une classe doivent pouvoir être substituées par des instances de sous-classes sans altérer la cohérence du programme. Cela garantit que les sous-classes respectent les contrats définis par les classes parentes.

- Principe d'inversion des dépendances (Dependency Inversion Principle, DIP): Les modules de haut niveau ne doivent pas dépendre des détails d'implémentation des modules de bas niveau. Au contraire, les détails d'implémentation doivent dépendre des abstractions. Cela favorise une conception modulaire et facilite les tests et les modifications.

- Tests unitaires et couverture du code: Le Clean Code encourage l'écriture de tests unitaires pour valider le comportement du code. Les tests doivent être automatiques, reproductibles et fournir une bonne couverture du code.

En suivant les principes du Clean Code, les développeurs peuvent produire un code de qualité supérieure, plus facile à comprendre, à maintenir et à tester. Cela favorise la collaboration, réduit les bugs et facilite l'évolutivité du logiciel.

## Quelques ressources pour écrire un code propre en Python

- [The Hitchhiker's Guide to Python](https://docs.python-guide.org/writing/style/)
- [Transforming Code into Beautiful, Idiomatic Python - YouTube](https://www.youtube.com/watch?v=OSGv2VnC0go)
- [Cours "Ecrivez du code python maintenable" - OpenClassRoom](https://openclassrooms.com/fr/courses/7160741-ecrivez-du-code-python-maintenable)