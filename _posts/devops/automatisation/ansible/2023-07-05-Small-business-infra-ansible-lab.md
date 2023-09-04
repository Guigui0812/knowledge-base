---
title: Ansible automation lab - Small business infrastructure
date: 2023-08-22 00:00:00  
categories: [devops, automatisation, ansible]
tags: [sysadmin, automatisation, ansible, devops, infrastructure]
---

Dans un précédent article, j'avais expliqué la [création d'un laboratoire virtuel pour SysAdmin](../../2023-05-04-Creation-lab-virtuel-sysadmin.md) qui permet de représenter l'infrastructure d'une petite entreprise : DHCP, DNS, LDAP, serveur de fichiers, serveur NFS et firewall. Dans cet article, je vais refaire ce laboratoire, mais cette fois-ci avec Ansible et Vagrant.

Mon réseau sera composé de 4 machines virtuelles :
- Un pare-feu (Firewall) pfSense
- Un serveur DNS/DHCP
- Un serveur LDAP/NFS
- Un client pour les tests

Pour Ansible et Vagrant, j'ai décidé d'utiliser mon WSL2 sous Windows 10 afin de pouvoir tester les playbooks sur mon ordinateur portable.

# Prerequisites

Firstly, we need to setup the lab. To do that, we need to install some tools and create the virtual machines.

## Vagrant

### Installation

Depending of the OS you use, the installation process can be different.

As I use Windows 10, I will install Vagrant with the [installer](https://www.vagrantup.com/downloads) available on the official website. Vagrant will be used to create the virtual machines on Oracle VirtualBox.

For other OS, you can follow the [official documentation](https://www.vagrantup.com/docs/installation).

### Provisioning

Now that Vagrant is installed, we can create the virtual machines. To do that, we need to create a `Vagrantfile` in a directory. This file will contain the configuration of the virtual machines.

To init the `Vagrantfile`, we can use the following command:

```bash
vagrant init
```

In the file that has been created, we can add the following content:

```ruby
Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = "1"
  end

  config.vm.define "ansible-control-node" do |ansible|
    ansible.vm.box = "bento/ubuntu-22.04"
    ansible.vm.hostname = "ansible-control"
    ansible.vm.network "private_network", ip: "172.16.0.2" 
    ansible.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh"
  end

  config.vm.define "ldap-nfs-node" do |ldap|
    ldap.vm.box = "bento/ubuntu-22.04"
    ldap.vm.hostname = "ldap-nfs"
    ldap.vm.network "private_network", ip: "172.16.0.3"
    ldap.vm.network "forwarded_port", guest: 22, host: 2223, id: "ssh"
  end

  config.vm.define "dhcp-dns-node" do |dhcp|
    dhcp.vm.box = "bento/ubuntu-22.04"
    dhcp.vm.hostname = "dhcp-dns"
    dhcp.vm.network "private_network", ip: "172.16.0.4"
    dhcp.vm.network "forwarded_port", guest: 22, host: 2224, id: "ssh"
  end

  config.vm.define "client-node" do |client|
    client.vm.box = "bento/ubuntu-22.04"
    client.vm.hostname = "client"
    client.vm.network "private_network", type: "dhcp"
    client.vm.network "forwarded_port", guest: 22, host: 2225, id: "ssh"
  end
end
```

This configuration will create 4 virtual machines with Ubuntu 22.04. The first one will be used to run Ansible. The other ones will be used to test the playbooks as they will be the servers of the infrastructure and the client to test the services.

To create the virtual machines, we can use the following command:

```bash
vagrant up
```

It is possible to connect to the virtual machines with the following command:

```bash
vagrant ssh <vm-name>
```

But even if we connect from the host to the virtual machines, the Ansible node will not be able to connect to the other virtual machines. So, we need to configure the SSH access from the Ansible node to the other virtual machines.

### SSH Access for Ansible

## Installation d'Ansible

Dans un premier temps, il faut installer Ansible sur le serveur qui va orchestrer les tâches. Il faut également paramétrer les serveurs cibles pour qu'ils soient accessibles en SSH depuis le serveur Ansible.

Pour cela, il faut suivre [cet article](../../2023-05-05-Ansible-Setup.md) qui explique les étapes d'installation et de configuration d'Ansible.

# Setup the lab with Vagrant

As we installed Vagrant, we can now create the lab. To do that, we need to create a `Vagrantfile` with the following content:






## Configuration du serveur DNS/DHCP

Il est possible de configurer de nombreux services avec Ansible. Dans un premier temps je vais commencer par le serveur DNS/DHCP.

Il y a plusieurs manières d'utiliser ***Ansible*** pour configurer un serveur. Mon choix est de créer un playbook par service. Cela permet de séparer les tâches et de pouvoir les réutiliser plus facilement. Chaque playbook est lié à un répertoire dans lequel sont présents certains fichiers de configuration qu'il faut copier sur le serveur cible.

## Déployer un serveur DHCP





#### Usefull links and resources
