---
title: Machines virtuelles avec la même ip en DHCP
date: 2023-05-02 00:00:00
categories: [devops, linux, troubleshooting]
tags: [sysadmin, linux, troubleshooting, virtualisation, dhcp, virtualbox, proxmox]
---

Lorsque l'on clone des machines virtuelles sur Virtualbox ou Proxmox, il peut arriver que le DHCP leur assigne la même ip.

La raison est que les machinbes possèdent le même identifiant unique (UUID). Pour le changer, il faut exécuter la commande suivante sur la machine virtuelle :

```bash
sudo rm /etc/machine-id
sudo systemd-machine-id-setup
```

Après avoir redémarré la machine, elle devrait avoir une nouvelle ip.