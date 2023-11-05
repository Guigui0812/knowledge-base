---
title: Les chaînes de caractères en Python
date: 2023-09-13 00:00:00
categories: [dev, python]
tags: [python, dev, string]
---

## Substitution de variables dans une chaîne

Il existe plusieurs manières de substituer des variables dans une chaîne de caractères en Python.

### Concaténation

La première méthode consiste à concaténer les différentes parties de la chaîne avec l'opérateur `+` :

```python
name = "John"
age = 42
print("My name is " + name + " and I am " + str(age) + " years old.")
```

### Formatage de chaîne

La deuxième méthode consiste à utiliser la méthode `format()` de la classe `str` :

```python
name = "John"
age = 42
print("My name is {} and I am {} years old.".format(name, age))
```

### F-strings

La troisième méthode consiste à utiliser les f-strings, introduites dans ***Python 3.6*** :

```python
name = "John"
age = 42
print(f"My name is {name} and I am {age} years old.")
```

#### Sources utiles

