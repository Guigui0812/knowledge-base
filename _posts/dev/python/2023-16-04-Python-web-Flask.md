---
title: Flask pour développer des applications web en Python
date: 2023-04-16 00:00:00
categories: [dev, web, python]
tags: [framework, web, python, flask]
---

**Flask** est un framework web en Python. Il permet de développer des applications web en Python. Il est très simple à utiliser et permet de développer rapidement des applications web. Ici je stocke des notes sur l'utilisation de Flask et différents liens utiles.

## Installation

Avant d'installer Flask, il faut créer un environnement afin de respecter les bonnes pratiques de développement en Python.

Une fois l'environnement mis en place, on peut installer Flask avec la commande `pip` :

```bash
pip install flask
```

## Application de base

Flask nécessite assez peu de code pour fonctionner. Voici un exemple d'application de base :

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run()
```

Ce code suffit pour créer une application web qui affiche "Hello, World!" sur la page d'accueil. Evidemment, Flask permet de faire bien plus que ça.

## Organisation du projet Flask

Flask est très libre sur l'organisation du projet. Il n'y a pas de structure imposée. Cependant, il est possible de suivre une structure classique pour organiser son projet Flask. La structure de référence pour tout projet de développement web repose sur le modèle [Modèle Vue Contrôleur (MVC)]().

Ainsi, il est pratique de respecter cette structure pour organiser son projet Flask. Voici un exemple de structure de projet Flask :

```bash
myapp/
├── app/
│   ├── __init__.py
│   ├── models.py
│   ├── views.py
│   └── controllers.py
├── static/
│   └── styles.css
├── templates/
│   ├── base.html
│   └── index.html
├── config.py 
├── requirements.txt
└── run.py
```

Cette structure est assez simple. Elle contient un dossier `app` qui contient les fichiers Python de l'application. Le dossier `static` contient les fichiers statiques de l'application (images, CSS, JS, etc.). Le dossier `templates` contient les templates HTML de l'application. Enfin, le fichier `run.py` permet de lancer l'application.

## Le contenu des fichiers

### Le répertoire `app`

#### Le fichier `__init__.py`

Le fichier `__init__.py` permet de définir l'application Flask. Il contient le code suivant :

```python
import os
from flask import Flask
from .views import app

# Connect sqlalchemy to the app
models.db.init_app(app)
```

Le fichier `__init__.py` est utilisé pour créer une instance de l'application Flask, configurer des paramètres, définir des variables globales, importer des modules, etc. C'est le point d'entrée de votre application Flask et de ses paramètres.

#### Le fichier `models.py`

```python
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(100), nullable=False)

    def __init__(self, username, email, password):
        self.username = username
        self.email = email
        self.password = password
```

`models.py` est utilisé dans une application Flask pour définir la structure des données et intéragir avec la base de données. Il contient les modèles, qui sont des représentations des tables de la base sous forme d'objets Python.

Dans ce fichier, il est possible d'utiliser un ORM tel que SQLAlchemy pour faciliter la création et la manipulation des données. SQLAlchemy fournit une abstraction de la base de données qui permet d'écrire des requêtes SQL en utilisant des objets Python et sans utiliser la syntaxe en SQL. 

#### Le fichier `views.py`

```python
from flask import Flask, render_template, request, url_for, redirect, jsonify, session
from .models import User
from .controller import create_user, get_user

from 

# Route for the home page
@app.route('/')
def index():
    return render_template('index.html')
```

#### Liens utiles

- [Explore Flask - A book about best practices and patterns in Flask](http://exploreflask.com/en/latest/index.html)
- [Les sessions en Flask](https://pythonbasics.org/flask-sessions/)
- [Générer une clé pour l'appication Flask](https://randomkeygen.com/)
- [Cours Flask - OpenClassroom](https://openclassrooms.com/fr/courses/4425066-concevez-un-site-avec-flask)
