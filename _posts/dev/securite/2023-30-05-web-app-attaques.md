---
title: Les attaques d'applications web
date: 2023-05-30 00:00:00
categories: [dev, securité]
tags: [dev, bonnes pratiques, sécurité, web, attaques]
---

Les applications web sont de plus en plus utilisées et sont devenues un élément essentiel de la vie quotidienne. Cependant, elles sont également devenues une cible privilégiée. Les attaques d'applications web sont de plus en plus fréquentes et de plus en plus sophistiquées.

- **Injection SQL** : Les attaquants insèrent des commandes SQL malveillantes dans les champs d'entrée de l'application, exploitant les failles de sécurité pour exécuter des commandes non autorisées dans la base de données.

- **Cross-Site Scripting (XSS)** : Les attaquants injectent du code JavaScript malveillant dans les champs d'entrée, qui est ensuite exécuté sur les navigateurs des utilisateurs. Cela leur permet de voler des informations sensibles, de rediriger les utilisateurs vers des sites frauduleux ou d'effectuer des actions non autorisées au nom de celui-ci

- **Cross-Site Request Forgery (CSRF)** : Les attaquants exploitent la confiance entre le navigateur de l'utilisateur et le site web en forgeant des requêtes HTTP légitimes. Lorsque l'utilisateur visite un site malveillant, des actions non autorisées sont effectuées sur d'autres sites auxquels l'utilisateur est authentifié.

- **Xpath Injection** : Les attaquants insèrent des commandes XPath malveillantes dans les champs d'entrée de l'application, exploitant les failles de sécurité pour exécuter des commandes non autorisées dans la base de données.

- **LDAP Injection** : Les attaquants insèrent des commandes LDAP malveillantes dans les champs d'entrée de l'application, exploitant les failles de sécurité pour exécuter des commandes non autorisées dans la base de données.

- **Command Injection** : Les attaquants insèrent des commandes système malveillantes dans les champs d'entrée de l'application, exploitant les failles de sécurité pour exécuter des commandes non autorisées dans le système d'exploitation.

- **CRLF Injection** : Les attaquants insèrent des caractères de retour chariot et de saut de ligne dans les champs d'entrée de l'application, exploitant les failles de sécurité pour exécuter des commandes non autorisées dans le système d'exploitation.

Ces attaques peuvent être évitées en appliquant quelques bonnes pratiques à retrouver [ici](2023-30-05-Dev-secure-generalites.md). Le groupe OWASP a également établi une [liste des 10 attaques les plus courantes](https://owasp.org/www-project-top-ten/). Cette liste permet d'avoir une vue d'ensemble des attaques les plus courantes et de mettre en place des mesures de sécurité pour les contrer.

#### Liens utiles

- [Les attaques par injection d'applications Web populaires ](https://geekflare.com/fr/web-application-injection-attacks/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)