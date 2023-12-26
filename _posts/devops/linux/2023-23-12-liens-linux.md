---
title: Les commandes pour la création et la gestion des liens dans Linux
date: 2023-12-23 00:00:00
categories: [sysadmin, linux]
tags: [linux, commandes, liens, symlink, terminal]
---

![linux links](assets/linux_links.png)

## Qu'est-ce qu'un lien dans Linux ?

Un lien est un pointeur vers un fichier ou un répertoire. Il existe deux types de liens : les **liens physiques** et les **liens symboliques**.

### Les liens physiques

Un **lien physique** est une référence directe aux données physiques d'un fichier sur un disque dur. Contrairement à un raccourci ou à un lien symbolique, il est indiscernable du fichier original.

Un **lien physique** est créé avec la commande `ln`.

**Quelques caractéristiques des liens physiques :**

- **Invisible** : un lien physique apparait comme le fichier original et non pas comme un raccourci.
- **Indépendant** : un lien physique est indépendant du fichier original. Si le fichier original est supprimé, le lien physique reste intact.
- **Limité** : un lien physique ne peut pas pointer vers un répertoire.

Ce type de lien est peu utilisé. On l'utilise principalement pour créer des copies de sauvegarde d'un fichier.

#### Créer un lien physique

```bash
ln <fichier_original> <lien_physique>
```

### Les liens symboliques

Un **lien symbolique** est une référence plus flexible à un fichier ou répertoire. Il fonctionne plus comme un raccourci, pointant vers le chemin d'un fichier plutôt que vers les données elles-mêmes.

Un **lien symbolique** est créé avec la commande `ln -s`.

**Quelques caractéristiques des liens symboliques :**

- **Visible** : un lien symbolique apparait comme un raccourci (avec une flèche dans le terminal).
- **Dépendant** : un lien symbolique est dépendant du fichier original. Si le fichier original est supprimé, le lien symbolique est rompu.
- **Flexible** : un lien symbolique peut pointer vers un fichier ou un répertoire.

Il est bien plus courant d'utiliser des liens symboliques que des liens physiques. On l'utilise principalement pour créer des raccourcis vers des fichiers ou des répertoires afin de les rendre plus accessibles.

#### Créer un lien symbolique

```bash
ln -s <fichier_original> <lien_symbolique>
```

## Quelques commandes utiles pour la gestion des liens

### Supprimer un lien

On peut supprimer un lien avec la commande `rm`, comme pour un fichier ou un répertoire.

```bash
rm <lien>
```

On peut aussi supprimer un lien avec la commande `unlink`.

```bash
unlink <lien>
```

### Modifier un lien

On peut modifier un lien symbolique avec la commande `ln -sf`.

```bash
ln -sf <fichier_original> <lien_symbolique>
```

#### Sources

- [Comment Créer un Lien Symbolique sous Linux](https://www.hostinger.fr/tutoriels/comment-creer-un-lien-symbolique-sous-linux)
- [How to Create a Symbolic Link in Linux](https://www.freecodecamp.org/news/linux-ln-how-to-create-a-symbolic-link-in-linux-example-bash-command/#:~:text=You%20use%20the%20ln%20command,link%20will%20be%20created%20instead.)
