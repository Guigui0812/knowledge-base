---
title: Les environnements virtuels en Python
date: 2023-04-16 00:00:00
categories: [dev, python]
tags: [python, dev, virtualenv]
---

Les environnements virtuels sont des outils essentiels pour les développeurs Python. Ils permettent d'isoler les dépendances d'un projet, évitant ainsi les conflits et les problèmes de compatibilité entre les différentes versions des packages utilisés. 

# Définition

Un environnement virtuel est une installation Python autonome qui isole les packages, les dépendances et l'interpréteur Python lui-même du système global. Il permet de travailler sur un projet spécifique avec ses propres versions de packages, indépendamment des autres projets et de l'installation Python globale. Cela permet de maintenir un environnement de développement propre et cohérent, sans interférence entre les différentes applications.

# Avantages  

Les environnements virtuels offrent plusieurs avantages importants :

- **Isolation des dépendances** : Chaque projet peut avoir ses propres versions de packages, évitant les conflits entre les différentes versions utilisées par d'autres projets.

- **Gestion simplifiée des dépendances** : Les environnements virtuels facilitent la gestion des dépendances en permettant d'installer et de désinstaller des packages spécifiques sans affecter le système global.

- **Reproductibilité des environnements** : En utilisant des environnements virtuels, vous pouvez garantir que tous les développeurs travaillent avec les mêmes versions de packages, assurant ainsi la reproductibilité de l'environnement de développement.

- **Facilité de déploiement** : Les environnements virtuels permettent de spécifier les dépendances d'un projet de manière explicite, facilitant ainsi le déploiement de l'application sur d'autres machines sans avoir à s'inquiéter des dépendances manquantes.

# Configuration d'un environnement virtuel

***Python*** propose plusieurs outils pour la gestion des environnements virtuels. Le plus populaire est `venv`, inclus dans les versions récentes depuis partir de ***Python 3.3***.

## Les étapes pour configurer un environnement virtuel :

Exécuter la commande suivante pour créer un nouvel environnement virtuel :

```bash
python3 -m venv myenv
```

Cela créera un nouveau répertoire `myenv` contenant tous les fichiers nécessaires pour l'environnement virtuel.

Dans un secod temps, pour activer l'environnement virtuel, il faut exécuter la commande appropriée en fonction de l'OS.

- Sur **macOS** et **Linux** dans le ***terminal*** :

```bash
source myenv/bin/activate
```

- Sur **Windows** dans ***PowerShell*** :

```PowerShell
myenv\Scripts\activate
```

Lorsque l'environnement virtuel est activé, l'invite de commandes affichera le nom de l'environnement entre parenthèses, indiquant que l'on travaille désormais à l'intérieur de l'environnement virtuel.

## Désactiver l'environnement virtuel actif

Pour désactiver l'environnement virtuel actif et revenir à l'environnement Python global, il suffit d'utiliser la commande suivante :

```bash
deactivate
```

## Supprimer un environnement virtuel

Pour supprimer un environnement virtuel, il suffit de supprimer le répertoire correspondant à cet environnement. 

# Gérer facilement les dépendances de l'environnement

Une fois l'environnement spécifié, il est très facile répertorier toutes les dépendances de celui-ci en créant

# Cas d'erreurs courants

## Erreurs sous Windows

### ***venv\Scripts\activate.ps1 cannot be loaded because running scripts is disabled on this system.***

L'erreur se produit lors de l'activation de l'environnement virtuel dans ***PowerShell***.

```powershell
venv\Scripts\activate.ps1 : File A:\Code\IIITH\image-processing-iiith\SRIP\venv\Scripts\activate.ps1 cannot be loaded
because running scripts is disabled on this system. For more information, see about_Execution_Policies at
https:/go.microsoft.com/fwlink/?LinkID=135170.
```

Cette erreur est due à la politique d'exécution de ***PowerShell*** qui empêche l'exécution de scripts.	Pour résoudre ce problème, il faut exécuter la commande suivante dans ***PowerShell*** :

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Liens et ressources

- [Environnements virtuels et paquets - Doc Python](https://docs.python.org/fr/3/tutorial/venv.html)
- [Erreur : venv\Scripts\activate.ps1 cannot be loaded because running scripts is disabled on this system - stackoverflow](https://stackoverflow.com/questions/18713086/virtualenv-wont-activate-on-windows)

