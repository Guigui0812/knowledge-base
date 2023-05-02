---
title: Configurer le réseau sur debian
date: 2023-04-30 00:00:00
categories: [sysadmin, linux]
tags: [sysadmin, linux, reseau, debian]
---

Configurer le réseau sur debian est une tâche de base pour un administrateur système.

## Configuration manuelle

Pour configurer le réseau manuellement, il faut modifier le fichier `/etc/network/interfaces`. De préférence, il faut exécuter `nano` en tant que super utilisateur :

```bash
sudo nano /etc/network/interfaces
```

Le fichier est un fichier de configuration qui se présente comme suit :

```bash
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug ens18
iface ens18 inet static
     address 192.168.1.28/24
     gateway 192.168.1.1
# This is an autoconfigured IPv6 interface
iface ens18 inet6 auto
``` 

Pour configurer le réseau, il faut modifier les lignes suivantes :

```bash
# The primary network interface
allow-hotplug ens18
iface ens18 inet static
    address <adresse IP>/<masque>
    gateway <adresse IP de la passerelle>
```

Pour configurer l'interface en DHCP, il faut modifier la ligne suivante :

```bash
# The primary network interface
allow-hotplug ens18
iface ens18 inet dhcp
```

Si l'on souhaite configurer une adresse IPv6, il faut modifier la ligne suivante :

```bash
# This is an autoconfigured IPv6 interface
iface ens18 inet6 auto
```

Si l'on souhaite configurer une adresse IPv6 statique, il faut modifier la ligne suivante :

```bash
# This is an autoconfigured IPv6 interface
iface ens18 inet6 static
    address <adresse IPv6>/<masque>
    gateway <adresse IPv6 de la passerelle>
```

Enfin, lorsque les modifications sont terminées, il faut redémarrer le service réseau :

```bash
sudo systemctl restart networking
```

#### Liens utiles

- [Add IPV6 on Debian](https://www.snel.com/support/how-to-add-additional-ipv6-on-debian/)
- [How to configure network settings in debian](https://www.serverlab.ca/tutorials/linux/administration-linux/how-to-configure-network-settings-in-debian/)