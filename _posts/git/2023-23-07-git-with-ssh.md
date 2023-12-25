---
title: Use git with SSH for authentication
date: 2023-07-23 00:00:00
categories: [git]
tags: [git, ssh, authentication]
---

If you can use git with HTTPS, it is better to use SSH for authentication. It is more secure and you don't have to enter your credentials each time you want to push your changes. It's even more usefull and secure if you use differents laptops or computers.

## Generate SSH keys

The first step is to generate SSH keys. You can do it on any computer you want to use git with SSH.

```bash
ssh-keygen -t rsa -b 4096 -C "<email>"
```

Use RSA with 4096 bits is a good choice for the algorithm and the key size. You can use a passphrase to protect your private key if you want, but it is not mandatory.

## Add the key to ssh-agent

After generating the SSH keys, it is necessary to add it to the ssh-agent. The ssh-agent is a program that runs in the background and stores the SSH keys. It is used to manage the keys and to use them when you want to connect to a server. If you skip this step, you will not be able to use your SSH keys with git.

First, you need to start the ssh-agent :

```bash
eval "$(ssh-agent -s)"
```

Then, you need to add the SSH key to the ssh-agent :

```bash
ssh-add ~/.ssh/<private key>
```

## Add the key to your git account

Finally, you need to add the public key to your account. You can find the public key in the file `~/.ssh/<public key>.pub`. You can copy the content of the file and paste it in the SSH keys section of your account. This section is usually in the settings of your account : settings > SSH and GPG keys.

#### Sources and useful links

- [Connecting to GitHub with SSH - GitHub Docs](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)
- [Steps for using Public Key Authentication for accessing your GitHub repositories](https://sbme-tutorials.github.io/2019/data-structures/notes/public_key.html)