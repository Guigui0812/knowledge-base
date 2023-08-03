---
title: Good practices and tricks with Ansible
date: 2023-03-08 00:00:00
categories: [devops, automatisation, ansible]
tags: [sysadmin, automatisation, ansible, devops, infrastructure, entreprise]
---

Ansible is a great tool to automate the deployment of your infrastructure. But it's not always easy to use it. Here are I store some good practices and tricks I found.

## Use roles

Ansible comes with a lot of modules, but it's not always easy to use them. To make it easier, you can use roles. Roles are a way to group multiple tasks in a single file. It's easier to read and to maintain.

With roles, you can reuse the same tasks in multiple playbooks. It's also easier to share your work with other people.

For example, if you create a task to install a package, you can use it in multiple playbooks. If you need to change the package name, you only need to change it in one place.

**Structure of a role** : 
    
```bash
roles/
  my_role/
    tasks/
      main.yml
    templates/
    vars/
    defaults/
    handlers/
```

`my_role` is the name of the role. It's important to give a name to your role, because you will use it in your playbooks. It contains multiples folders:
- `tasks` : contains the tasks of the role
- `templates` : contains the templates used by the role
- `vars` : contains the variables files used by the role (ex: `.env` file)
- `defaults` : contains the default variables used by the role
- `handlers` : contains the handlers used by the role

All these folder are not mandatory. You can use only the folders you need.

To use this role in a playbook, you need to add the following lines:

```yaml
---
- name: my playbook
  hosts: all
  become: yes
  become_method: sudo

  roles:
    - my_role
```

This is a good way to optimize your playbooks and make them easier to read, but also reusable. 

For exampe, if you often need to install `docker` on your servers, you can create a role to install it. Then, you can use it in all your playbooks that need this package.