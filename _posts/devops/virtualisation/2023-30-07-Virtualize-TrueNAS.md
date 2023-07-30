---
title: Virtualize TrueNAS
date: 2023-07-30 00:00:00
categories: [virtualisation, TrueNAS]
tags: [virtualisation, TrueNAS, linux, home-server]
---

In order to store my media and personal data, I decided to use TrueNAS. TrueNAS is a storage operating system based on FreeBSD and OpenZFS. As I don't have a dedicated server, I decided to virtualize TrueNAS with Proxmox on my home server.

## Create a VM for TrueNAS

First, I created a Virtual Machine on Proxmox with the following settings:
- 1 CPU
- 8GB of RAM
- 32GB of disk space

It's important to allocate a lot of RAM to TrueNAS, because ZFS needs a lot of RAM to work properly. I also added a second disk of 1TB to store my data. It's possible to add a disk to the virtual machine via the Proxmox web interface.

Then, I launched the VM and followed the installation process. I chose the option to install TrueNAS on the first disk and to use the second disk as a storage disk.

## Configure TrueNAS

### Create a dedicated user for each purpose

To manage permissions and security, I decided to create a dedicated user for each purpose. As I don't have much services for the moment, I created a user for Plex and a user for my personal data. That allows me to precisely manage the permissions of each user : plex doesn't need to access my personnal data, and doestn't need a write permission to the media files.

I created a user for Plex, a user for Nextcloud, a user for my personal data, etc. I also created a user for my personal data, with the same UID and GID as my user on my computer. This way, I can easily mount my data on my computer.

### Create a dataset

In order to store my data, I created a dataset. I chose the ZFS file system, because it's the most reliable file system. I also enabled the compression and the deduplication.

### Create a share

To access to the storage, I created a share. I chose the SMB protocol, because it's the most compatible protocol. I also enabled the compression and the deduplication. 

#### Resourses and useful links

- [TrueNAS documentation](https://www.truenas.com/docs/hub/)
- [My Proxmox Home Server Walk-Through: Part 1 (TrueNAS, Portainer, Wireguard) - 
Hardware Haven](https://www.youtube.com/watch?v=_sfddZHhOj4)
- [How to install TrueNAS on Proxmox - wundertech](https://www.wundertech.net/how-to-install-truenas-on-proxmox/)
- 
