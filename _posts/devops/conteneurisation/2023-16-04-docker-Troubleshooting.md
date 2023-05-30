---
title: Solutions à des problèmes rencontrés avec Docker
date: 2023-03-24 00:00:00
categories: [devops, conteneurisation, docker]
tags: [devops, docker, troubleshooting, conteneurisation, sysadmin]
---

Ici je stocke des solutions à des problèmes rencontrés avec Docker lors de mes projets ou de mes tests.

## An attempt was made to access a socket in a way forbidden by its access permissions.

Ce message d'erreur est souvent rencontré lorsqu'on utilise Docker Desktop sur Windows. Il est souvent lié à un problème de carte réseau. Pour résoudre ce problème, il faut désactiver le service Hyper-V Network Service (HNS) et le redémarrer. Pour cela, il faut utiliser le terminal PowerShell en tant qu'administrateur et exécuter les commandes suivantes :

```bash
net stop hns
net start hns
```