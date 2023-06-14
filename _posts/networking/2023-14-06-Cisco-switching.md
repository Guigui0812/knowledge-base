---
title: Cisco switching - Généralités et commandes
date: 2023-06-14 00:00:00
categories: [Réseau, Cisco]
tags: [switch, cisco, vlan, trunk, etherchannel, spanning-tree, vtp, lacp, pagp, stp]
---

# Généralités

A venir

# Commandes

## Commandes de base

### Passer en mode privilégié

```
Switch> enable
```

### Passer en mode de configuration globale

```
Switch# configure terminal
```

ou 

```
Switch# conf t
```

### Afficher la configuration

```
Switch# show running-config
```

ou 

```
Switch# show run
```

### Sauvegarder la configuration

```
Switch# copy running-config startup-config
```

ou 

```
Switch# copy run start
```

ou 

```
Switch# write mem
```

### Afficher des informations sur les interfaces

```
Switch# show interfaces <interface>
```

ou 

```
Switch# show int <interface>
```

### Accéder à une interface

```
Switch# interface <interface>
```

ou

```
Switch# int <interface>
```

### Accéder à plusieurs interfaces

```
Switch# interface range <interface1> <interface2>
```

ou

```
Switch# int range <interface1> <interface2>
```

***Exemple :***

```
Switch# int range fa0/1 - 24
```

## VLANs

### Afficher les VLANs

```
Switch# show vlan
```

### Afficher les VLANs configurés sur une interface

```
Switch# show vlan interface <interface>
```

### Attribution d'un VLAN à une interface

```
Switch# interface <interface>
Switch(config-if)# switchport access vlan <vlan_id>
```

### Suppression d'un VLAN d'une interface

```
Switch# interface <interface>
Switch(config-if)# no switchport access vlan <vlan_id>
```

### Création d'un VLAN

```
Switch# vlan <vlan_id>
```

***Exemple :***

```
Switch# vlan 10
```

### Suppression d'un VLAN

```
Switch# no vlan <vlan_id>
```

