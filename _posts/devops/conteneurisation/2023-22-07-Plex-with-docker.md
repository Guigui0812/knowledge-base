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
```

It's important to create a specific user for Plex, because it will be easier to manage permissions and security.

## Create the directories for Plex and copy the configuration files

I create a `.env` file with the following content:

```bash
TZ=Europe/Paris
DATADIR=/media
SERVER_IP=<ip_de_mon_serveur>
```	

Then, I add a few lines to the `plex.yml` file to add the directories and copy the configuration files:

```yaml
- name: create the plex directory
  file:
      path: "./plex"
      state: directory
      owner: plex
      group: plex

- name: copy the config file
  copy:
      src: .env
      dest: "./plex/.env"
      owner: plex
      group: plex
      mode: 0644
```

As the `.env` is still incomplete, I need to add some informations. But these informations are the PUID and PGID of the user `plex`. As these informations can change from one server to another, I decided to automate the process. 

So I add these lines to retrieve the PUID and PGID of the user `plex` and add them to the `.env` file :

```yaml
- shell: id -u plex
    register: plex_user_id

- name: write plex gid to the .env config file
  lineinfile:
      line: "PLEX_UID={{ plex_user_id.stdout }}"
      path: ./plex/.env

- name: wirte plex gid to the .env config file
  lineinfile:
      line: "PLEX_GID={{ plex_user_id.stdout }}"
      path: ./plex/.env

- shell: cat ./plex/.env
  register: plex_env

- debug:
      msg: "{{ plex_env.stdout_lines }}"
```

## Plex and docker-compose

To install Plex, I used docker-compose. I created a `docker-compose.yml` file with the following content:

```yaml
version: '3'
services:
  plex:
    image: plexinc/pms-docker
    container_name: plex
    restart: always
    ports:
      - "32400:32400/tcp"
      - "3005:3005/tcp"
      - "8324:8324/tcp"
      - "32469:32469/tcp"
      - "1900:1900/udp"
      - "32410:32410/udp"
      - "32412:32412/udp"
      - "32413:32413/udp"
      - "32414:32414/udp"
    volumes:
      - ./plex/config:/config
      - <media_directory>:/media
      - ./plex/transcode:/transcode
    environment:
      - TZ="${TZ}"
      - PLEX_UID="${PLEX_UID}"
      - PLEX_GID="${PLEX_GID}"
      - PLEX_CLAIM="${CLAIM}"
      - ADVERTISE_IP="http://${SERVER_IP}:32400/"
    network_mode: host
```

The lines with `$` are variables. These variables are defined in the `.env` file. 

Somes explanations about the docker-compose file :
- `image: plexinc/pms-docker` : this is the official image of Plex.
- `restart: always` : this is to restart the container if it stops, for any reason.
- `ports` : these are the ports used by Plex. I used the default ports.
- `volume` : these are the volumes used by Plex to keep the data persistent. I used the default volumes.
- `environment` : these are the environment variables used by Plex. It's used to customize the configuration of Plex.
- `network_mode: host` : this is to use the host network. This type of network allows to use the network of the host. It's useful to use the network of the host, without having to configure the network of the container. It's needed in this configuration to use the Plex server outside of the local network.

For the directories : 

- `./plex/config:/config` : this is the directory where the configuration files of Plex will be stored.
- `/media:/media` : this is the directory where my media files are stored.
- `.plex/transcode:/transcode` : this is the directory where the transcoded files will be stored.

## Map a network drive for the media files

TO manage the media files, I thought it would be easier to host them on a share attached to my NAS. So I created a share on my NAS and I mapped it on my server. 

I used the following command to map the network drive:

```bash
sudo mount -t cifs -o username=<username>,password=<password> //<ip_of_the_nas>/<share_name> /media
```

When the disk is mappaed, the content of the share is available in the `/media` directory. So the plex library will be `/media`. That allows me to manage the media files from my NAS when I want to add new files.

## Execute the docker-compose file with Ansible

It's possible to execute the docker-compose file with Ansible. I added these lines to the `plex.yml` file:

```yaml
- name: copy the docker compose file
  copy:
      src: docker-compose.yml
      dest : ./plex/docker-compose.yml

- name: execute the docker compose
  docker_compose:
      project_src: ./plex
      state: present
```

## Execute the playbook

To execute the playbook, I use the following command:

```bash
ansible-playbook plex.yml --ask-become-pass
```

Unfortunately, I have an error when I execute the playbook because of the `docker_compose` module. So I decided to execute the docker-compose file manually and I encountered the following error:

```bash
Removing plex
Recreating a78ebe4b1913_plex ... error

ERROR: for a78ebe4b1913_plex  Cannot start service plex: cgroups: cgroup mountpoint does not exist: unknown

ERROR: for plex  Cannot start service plex: cgroups: cgroup mountpoint does not exist: unknown
ERROR: Encountered errors while bringing up the project.
```

After some research, I found that the solution of this problem is to execute theses commands:

```bash
sudo mkdir /sys/fs/cgroup/systemd
sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
```

After executing these commands, I can execute the docker-compose file without any problem. And so, I can execute the playbook without any problem too.

Unfortunately, it's a temporary solution. To make it permanent, I had to completely reinstall docker. I followed the procedure in the [documentation](https://docs.docker.com/engine/install/debian/).



#### Useful links and resources

- [Plex Media Server- Official Docker Image](https://hub.docker.com/r/plexinc/pms-docker)
- [4 Ways to Install Plex (one is unexpected) - Techno Tim](https://www.youtube.com/watch?v=MG_1XQxWns0)
- [Error's solution "cgroups: cgroup mountpoint does not exist: unknown"](https://github.com/docker/for-linux/issues/219)
- [Set up Plex Server with Docker Compose - The Smarthome Book](https://www.thesmarthomebook.com/2022/01/18/set-up-plex-server-with-docker-compose/)
- [Use environment variables in Docker Compose - Stackoverflow](https://stackoverflow.com/questions/29377853/how-can-i-use-environment-variables-in-docker-compose)
- [Docker Compose - Ansible Documentation](https://docs.ansible.com/ansible/latest/collections/community/general/docker_compose_module.html)