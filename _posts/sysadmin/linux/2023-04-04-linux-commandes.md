---
title: Les commandes Linux
date: 2023-03-30 00:00:00
categories: [sysadmin, linux]
tags: [sysadmin, linux, commandes, shell, terminal]
---

## Rechercher une ligne dans un fichier

```bash
grep <motif> <fichier>
```

**Exemple :**

```bash
grep docker /etc/group
```

## Ajouter un utilisateur à un groupe

```bash
usermod -aG <groupe> <utilisateur>
```

## Changer l'hostname

```bash
hostnamectl set-hostname <hostname>
```

https://www.hostinger.com/tutorials/linux-commands
https://www.pierre-giraud.com/shell-bash/redirection-gestion-flux/