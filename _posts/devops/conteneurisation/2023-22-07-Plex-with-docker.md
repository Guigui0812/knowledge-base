---
title: Installation de Plex avec Docker et Ansible
date: 2023-07-22 00:00:00
categories: [devops, conteneurisation, docker]
tags: [devops, conteneurisation, docker, linux, ansible, home-server]
---

Plex Media Server is a media server and cord-cutting app to watch TV, movies, music, news, and share your photos and videos. It can be installed on Linux, Windows, macOS, FreeBSD, and many other platforms. I decided to install it on my home server, with the help of Docker and Ansible.

## Create a user for Plex

First, I need to create a specific user for Plex. I created a `plex.yml` file with the following content:

```yaml
---
- name : setup plex server
  hosts : plex
  become: yes
  become_method: sudo

  tasks:
  - name: create plex user
    user:
        name: plex
        state: present
        password: "{{ 'password' | password_hash('sha512') }}" 

  - name : create the plex directory
    file:
        path: "./plex"
        state: directory
        owner: plex
        group: plex

  - name : create the config file
    file:
        path: "./plex/.env"
        state: touch

  - shell: id -u plex
    register: plex_user_id
  - name: write plex user id to the config file
    lineinfile:
        line: "PLEX_UID={{ plex_user_id.stdout }}"
        path: ./plex/.env

  - shell: cat ./plex/.env
    register: plex_env

  - debug:
        msg: "{{ plex_env.stdout_lines }}"
```

It's important to create a specific user for Plex, because it will be easier to manage permissions and security.

## Plex and docker-compose

To install Plex, I used docker-compose. I created a `docker-compose.yml` file with the following content:

```yaml