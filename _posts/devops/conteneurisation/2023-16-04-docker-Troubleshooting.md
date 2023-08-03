---
title: Solutions to problems with Docker
date: 2023-03-24 00:00:00
categories: [devops, conteneurisation, docker]
tags: [devops, docker, troubleshooting, conteneurisation, sysadmin]
---

Some solutions to problems I encountered with Docker.

## An attempt was made to access a socket in a way forbidden by its access permissions.

This error message is often encountered when using Docker Desktop on Windows. It is often related to a network card problem. To solve this problem, you need to disable the Hyper-V Network Service (HNS) service and restart it. To do this, you need to use the PowerShell terminal as an administrator and run the following commands:

```bash
net stop hns
net start hns
```

## Cannot start service plex: cgroups: cgroup mountpoint does not exist: unknown

```bash
Removing plex
Recreating a78ebe4b1913_plex ... error

ERROR: for a78ebe4b1913_plex  Cannot start service plex: cgroups: cgroup mountpoint does not exist: unknown

ERROR: for plex  Cannot start service plex: cgroups: cgroup mountpoint does not exist: unknown
ERROR: Encountered errors while bringing up the project.
```

A temporary solution is to use these commands : 

```bash
sudo mkdir /sys/fs/cgroup/systemd
sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
```

But to solve the problem definitively, docker needs to be reinstall. I followed the procedure in the [documentation](https://docs.docker.com/engine/install/debian/).