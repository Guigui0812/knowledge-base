---
title: Créer un bridge pour WSL
date: 2023-05-07 00:00:00
categories: [sysadmin, virtualisation, WSL]
tags: [sysadmin, virtualisation, WSL, Windows, Linux]
---

Dans certains cas, par exemple tester des playbooks Ansible, il peut être utile de créer un bridge pour WSL afin que l'outil puisse accéder au réseau local et exécuter des commandes sur les serveurs cibles.

Cependant, un vrai bridge n'est pas possible avec WSL. Il faut donc utiliser une solution de contournement.

La solution utilisée est le "port forwarding" : on redirige les ports du serveur cible vers le serveur WSL.

## Création de la règle de port forwarding

Pour chaque port que l'on souhaite rediriger, il faut créer une règle de port forwarding sur la machine hôte. Pour cela, on utilise la commande `netsh`.

On va ainsi pouvoir créer des règles : 

```bash
netsh interface portproxy add v4tov4 listenport=<port sur la machine Windows> listenaddress=0.0.0.0 connectport=<port de destination sur la machine Linux> connectaddress=<adresse IP machine Linux>
```

Ici, on a créé une règle qui redirige le port de la machine hôte vers le port de la machine Linux.

## Création des règles pare-feu

Dans le cas où le port utilisé n'est pas ouvert sur la machine hôte, il faut créer une règle dans le pare-feu pour l'autoriser. Pour cela, on utilise la commande `netsh`.

```bash
# Autoriser le trafic entrant sur le port en TCP
New-NetFireWallRule -DisplayName <nom de la règle> -Direction Outbound -LocalPort <port> -Action Allow -Protocol TCP

# Autoriser le trafic sortant sur le port en TCP
New-NetFireWallRule -DisplayName <nom de la règle> -Direction Inbound -LocalPort <port> -Action Allow -Protocol TCP
```

De cette manière, grâce à ces règles, on peut accéder aux serveurs cibles depuis le serveur WSL.

#### Liens utiles

- [WSL 2 Port Forwarding : comment accéder à sa machine virtuelle à distance ?](https://www.it-connect.fr/wsl-2-port-forwarding-comment-acceder-a-sa-machine-virtuelle-a-distance/)
- [Accessing network applications with WSL](https://learn.microsoft.com/en-us/windows/wsl/networking#accessing-a-wsl-2-distribution-from-your-local-area-network-lan)
- [Port Forwarding WSL 2 to Your LAN](https://jwstanly.com/blog/article/Port+Forwarding+WSL+2+to+Your+LAN/)