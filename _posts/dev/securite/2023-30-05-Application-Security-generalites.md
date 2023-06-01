---
title: Généralités et bonnes pratiques de développement sécurisé
date: 2023-05-30 00:00:00
categories: [dev, securité]
tags: [dev, bonnes pratiques, sécurité, développement sécurisé]
---

Le développement sécurisé est un aspect essentiel de la création d'applications et de systèmes fiables et robustes. Ainsi, pour garantir la sécurité des applications, il est important de prendre en compte la sécurité dès les premières phases de développement.

En appliquant quelques bonnes pratiques, il est possible de réduire les risques d'exploitation, de vol de données et d'attaques malveillantes. 

# Gestion des données sensibles

La gestion des identifiants et des mots de passe est un aspect essentiel de la sécurité des applications. Il est important de mettre en place des mécanismes de sécurité pour protéger les données sensibles, les informations d'identification des utilisateurs mais également les données de l'application elle-même.

## Banir les données sensibles en clair

Il ne faut jamais stocker les mots de passe en clair. La bonne pratique est de stocker les mots de passe sous forme de **hash sécurisés**. Pour cela, il est possible d'utiliser des fonctions de hachage telles que **SHA-256** ou **SHA-512**. La plupart des langages de programmation modernes proposent des fonctions de hachage sécurisé, que ce soit nativement ou via des bibliothèques externes. En ***Python***, il est possible d'utiliser la bibliothèque `hashlib` pour hacher des données.

Cependant, il ne faut pas utiliser n'importe quelle fonction de hachage. Certaines fonctions de hachage sont obsolètes et ne sont plus considérées comme sécurisées. C'est le cas des fonctions de hachage **MD5** et **SHA-1**. Il est donc important de choisir une fonction de hachage sécurisée et de se tenir informé des dernières avancées en matière de sécurité.

## Utiliser des mots de passe forts

Il est important d'encourager les utilisateurs à choisir des mots de passe forts. Pour cela, il est possible de mettre en place des règles de complexité des mots de passe. Par exemple, il est possible d'exiger que les mots de passe contiennent au moins 8 caractères, dont au moins une lettre majuscule, une lettre minuscule, un chiffre et un caractère spécial.

Pour cela, il suffit simplement d'imposer ces règles lors de la création du mot de passe. Il est également possible de vérifier la complexité du mot de passe lors de la création du compte utilisateur et d'éviter la création du compte si le mot de passe ne respecte pas les règles de complexité.

## Renforcer les hash avec un sel

Pour renforcer la sécurité des mots de passe hachés, utilisez des techniques de salage. Le salage consiste à ajouter une chaîne aléatoire (le sel) aux mots de passe avant de les hacher. Chaque utilisateur peut avoir son propre sel unique. Cela rend les attaques par tables arc-en-ciel et les attaques par force brute beaucoup plus difficiles.

Pour ajouter un sel aux mots de passe, il suffit de concaténer le sel au mot de passe avant de le hacher. Le sel peut être stocké dans la base de données avec le mot de passe haché. Il est également possible de stocker le sel dans un fichier de configuration ou dans une variable d'environnement.

## Eviter de pousser les mots de passe dans les dépôts de code

Il est important de ne jamais pousser les mots de passe dans les dépôts de code. En effet, les dépôts de code sont souvent publics et accessibles à tous. Ainsi, si un mot de passe est poussé dans un dépôt de code, il est possible que des personnes malveillantes puissent l'exploiter.

Pur cela, est il recommander d'utilser un fichier de configuration dédié, ou dans un fichier `.env` ou dans une variable d'environnement. Il est également possible de chiffrer les mots de passe avant de les stocker dans un fichier de configuration.

L'intérêt de cette pratique est de pouvoir ajouter le fichier de configuration dans le fichier `.gitignore` afin qu'il ne soit pas poussé dans le dépôt de code.

# Protéger l'application contre les attaques par injection

De nombreuses attaques peuvent être menées contre les applications. La plupart des attaques communes utilisent les entrées utilisateur comme vecteur d'attaque, mais pas uniquement. Il existe de très nombreuses attaques qui exploitent les vulnérabilités des applications. Une liste non-exhaustive des attaques les plus courantes est disponible [ici](2023-30-05-web-app-attaques.md).

Les ***attaques par injection*** sont l'une des méthodes d'attaque les plus courantes. Elles consistent à injecter du code malveillant dans les entrées utilisateur afin d'exploiter les vulnérabilités de l'application.

Il existe également des attaques qui exploitent les vulnérabilités des serveurs et des systèmes d'exploitation. Ces attaques peuvent être évitées en appliquant les bonnes pratiques de sécurité des serveurs et des systèmes d'exploitation.

## Valider les entrées utilisateur côté serveur

Le principe est de toujours supposer que les entrées utilisateur sont malveillantes. Ainsi, il est important de valider les entrées utilisateur côté serveur avant de les utiliser. 

Pour cela, on peut utiliser du `Regex` pour valider que les données correspondent bien au format attendu. Il est également possible de valider les données en utilisant des fonctions de validation fournies par les langages de programmation.

## Échappement des caractères spéciaux

Lorsque l'on affiche ou enregistre des données fournies par l'utilisateur sur une page web, il faut s'assurer d'échapper correctement les caractères spéciaux pour éviter les attaques par injection de code (comme les attaques XSS). 

On peut utiliser des fonctions d'échappement appropriées fournies par un framework ou par une bibliothèque pour convertir les caractères spéciaux en entités HTML ou les échapper avec des anti-slashs.

## Limitation des caractères et des formats

Une bonne manière d'empêcher un attaquant d'injecter du code malveillant dans les entrées utilisateur est de limiter les caractères et les formats autorisés en entrée. Ainsi, dans les formulaires, il est possible de limiter les champs de saisie à un certain nombre de caractères. On peut également limiter les champs de saisie à certains formats (par exemple, une date).

Cette méthode permet de réduire les risques d'injection de code malveillant dans les entrées utilisateur, notamment dans les champs de saisie de texte.

## Utilisation de listes blanches plutôt que de listes noires

Préférez utiliser une approche de liste blanche plutôt qu'une liste noire lors de la validation des entrées utilisateur. Au lieu de spécifier ce qui est interdit, spécifiez ce qui est autorisé. Cela réduit les risques d'omission de certains types de vulnérabilités.

Dans le cas de l'autorisation de contenus ou de formats, il est préférable de spécifier les contenus ou les formats autorisés plutôt que les contenus ou les formats interdits. De cette manière, si on omet d'interdire un contenu ou un format, il ne sera pas autorisé.

## Validation des fichiers téléchargés ou déposés

Si l'application permet aux utilisateurs de télécharger des fichiers, il est important de valider ces fichiers pour prévenir les attaques par téléchargement de fichiers malveillants. Il est possible de vérifier les types de fichiers, les extensions, les tailles et d'effectuer des analyses antivirus pour détecter les éventuels codes malveillants. 

Pour cela, il est possible d'utiliser des bibliothèques propres à chaque langage de programmation. On peut également utiliser des services tiers pour effectuer des analyses antivirus ou des analyses de vulnérabilités. On peut par exemple intéragir avec [l'API de VirusTotal](https://developers.virustotal.com/reference/overview) pour vérifier si un fichier est malveillant avant de le télécharger.

# Respecter les normes de sécurité

En matière de développement d'applications web, il existe des normes de référence qu'il est important de suivre pour garantir la sécurité des applications. Ces normes sont définies par des organismes de référence comme l'***OWASP*** (Open Web Application Security Project) ou le ***W3C*** (World Wide Web Consortium).

Ce sont des directives et des pratiques établies dans le but de garantir la sécurité des applications. Elles visent à identifier les vulnérabilités courantes et à fournir des recommandations sur la manière de les prévenir ou de les atténuer.

## OWASP

OWASP est une organisation à but non lucratif qui se concentre sur la sécurité des applications web. Elle propose de nombreuses normes et ressources pour aider les développeurs à renforcer la sécurité de leurs applications. Voici quelques-unes des normes les plus populaires :

- **OWASP Top 10** : Il s'agit d'un document qui recense les 10 principales vulnérabilités de sécurité des applications web, telles que les injections SQL, les failles de sécurité XSS (Cross-Site Scripting), l'authentification et la gestion des sessions faibles, etc. Il fournit des conseils et des mesures de prévention pour chaque vulnérabilité.

- **OWASP ASVS (Application Security Verification Standard)** : Il s'agit d'un cadre qui fournit une liste de contrôles de sécurité recommandés à chaque étape du cycle de vie du développement logiciel. Il aide les développeurs à évaluer la sécurité de leurs applications et à s'assurer qu'elles répondent à des normes de sécurité élevées.

- **OWASP Testing Guide** : Ce guide fournit des instructions détaillées sur les techniques de test de sécurité des applications web. Il propose une méthodologie complète pour effectuer des tests de sécurité, y compris des tests d'intrusion, des tests de configuration et des tests de vulnérabilités.

## W3C

Le W3C est un organisme de normalisation qui se concentre sur les technologies du web. Bien que son objectif principal ne soit pas spécifiquement la sécurité, il propose des recommandations et des normes qui contribuent à renforcer la sécurité des applications web.

Parmi les normes de sécurité les plus populaires du W3C, on peut citer :

- CSP (Content Security Policy) : Il s'agit d'une recommandation qui permet aux développeurs de définir des règles de sécurité spécifiques pour leurs applications web, notamment en limitant les sources autorisées pour les ressources (JavaScript, CSS, images, etc.) et en prévenant les attaques de type XSS.

- CORS (Cross-Origin Resource Sharing) : Cette recommandation vise à atténuer les risques liés aux attaques CSRF (Cross-Site Request Forgery) en permettant aux serveurs de définir des politiques de partage des ressources entre différents domaines.

En suivant ces normes de sécurité, les développeurs renforcent la sécurité de leurs applications et réduisent les risques d'attaques et de vulnérabilités. Il est recommandé de se tenir à jour avec les dernières versions des normes et de les appliquer de manière appropriée en fonction des besoins de chaque application et du contexte de leur développement.

# Mise à jour des dépendances

Certaines vulnérabilités peuvent être introduites dans les applications web par des dépendances tierces. Il est donc important de maintenir à jour celles utilisées dans les applications afin de s'assurer qu'elles ne contiennent pas de vulnérabilités connues. 

Par exemple, en janvier 2021, la faille ***Log4Shell*** a été découverte dans la bibliothèque ***Log4j***. Cette faille permettait à un attaquant d'exécuter du code arbitraire à distance sur un serveur. Elle a été corrigée dans la version 2.15.0 de la bibliothèque. Lors de sa découverte, cette CVE a été classée comme critique. De très nombreuses applications, notamment dans le secteur financier, utilisaient cette bibliothèque et étaient donc vulnérables.

Il est donc important de maintenir à jour les dépendances utilisées afin de s'assurer qu'elles ne contiennent pas de vulnérabilités connues.

# Sécuriser les environnements de développement et de production

## Sécuriser les environnements de développement

Les environnements de développement sont souvent moins sécurisés que les environnements de production. Il est donc important de prendre des mesures pour les sécuriser et réduire les risques d'attaques.

***Quelques bonnes pratiques pour sécuriser les environnements de développement*** :

- Gérer les droits d'accès : Il est important de limiter l'accès aux environnements de développement aux personnes qui en ont besoin. Il est également recommandé de limiter les droits d'accès aux ressources et aux données sensibles.
- Utiliser des données de test : Il est recommandé d'utiliser des données de test pour les environnements de développement. Cela permet de réduire les risques liés à la divulgation de données sensibles.
- S'assurer que les images Docker sont sécurisées : Il est important de s'assurer que les images Docker utilisées dans les environnements de développement sont sécurisées. Il est recommandé d'utiliser des images officielles et de les mettre à jour régulièrement.

## Sécuriser les environnements de production

Les environnements de production sont les plus sensibles et les plus critiques. Il est donc important de prendre des mesures pour les sécuriser et réduire les risques d'attaques.

***Plusieurs moyens permettent de sécuriser les environnements de production*** :

- Miser sur l'observabilité : Il est important de surveiller les environnements de production afin de détecter les attaques et les vulnérabilités. Il est recommandé d'utiliser des outils d'observabilité tels que Prometheus, Grafana, etc. Cela permet de détecter une augmentation du nombre de requêtes, des erreurs, etc.
- Mettre en place des outils de détection d'intrusion : Il est recommandé de mettre en place des outils de détection d'intrusion permettant d'empêcher différentes attaques, telles que les attaques par force brute ou par déni de service (DoS). On peut par exemple mettre en place des outils tels que **Fail2ban**, **OSSEC**, etc.
- S'assurer que l'ensemble des microservices sont sécurisés : s'assurer que l'ensemble des microservices sont sécurisés, à jour et correctement configurés. Cela vaut pour les bases de données, les outils de logs... Il est également recommandé de mettre en place des outils de sécurité tels que **Istio**, **Linkerd**, etc.

# L'importance des tests 

Une application correctement développée est une application qui a été testée à plusieurs reprises. Il est donc important de mettre en place des tests unitaires, des tests d'intégration et des tests de bout en bout. C'est ici que la démarche DevOps prend tout son sens. En effet, les tests doivent être automatisés et exécutés à chaque fois qu'un changement est apporté au code source de l'application. De cette façon, on limite le risque de pousser un code vulnérable en production.

**Plusieurs tests à mettre en place** :

- **Tests unitaires** : Les tests unitaires permettent de tester les différentes unités de code de l'application. Ils permettent de s'assurer que chaque unité de code fonctionne correctement et qu'elle renvoie les résultats attendus.
- **Tests d'intégration** : Les tests d'intégration permettent de tester l'application dans son ensemble. Ils permettent de s'assurer que les différentes unités de code fonctionnent bien ensemble et qu'elles collaborent correctement.
- **Tests de bout en bout** : Ici on va tester l'applications comme le ferait un utilisateur. On va simuler des actions et vérifier que l'application fonctionne correctement. C'est le rôle des **ingénieurs QA** (Quality Assurance). Ils vont tester l'application et s'assurer qu'elle répond au cahier des charges. Ces ingénieurs utilisent des outils DevOps comme **Jenkins** ou **GitLab CI** pour automatiser les tests, mais aussi des outils comme **Selenium** pour simuler les actions d'un utilisateur.
- **Tests de sécurité** : Les tests de sécurité permettent de s'assurer que l'application est sécurisée. Ils permettent de détecter les vulnérabilités et les failles de sécurité. On va pouvoir utiliser des outils comme *Niktto* pour analyser la présence de vulnérabilités sur le serveur, ou encore *OWASP ZAP* pour analyser les vulnérabilités de l'application.

# Conclusion

Face à la multiplication des attaques et des vulnérabilités, le développement logiciel a évolué pour intégrer la sécurité dès le début du cycle de développement. Les entreprises, notamment les plus importantes, investissent massivement dans le développement de solutions informatiques, mais elles souhaitent également s'assurer que ces solutions sont sécurisées. 

Evidemment, la sécurisation des processus de développement et de déploiement est un travail chronophage et assez couteux. Dans un but de rationnalisation, de nouvelles approches ont vu le jour. Ces approches consistent à intégrer la sécurité dans les processus de développement et de déploiement. On parle alors de ***DevSecOps***. Cela permet de réduire le temps et les coûts liés à la sécurité en impliquant les équipes de sécurité dès le début du cycle de développement, et en automatisant tout ce qui peut l'être.

Enfin, il faut garder à l'esprit qu'il est bien plus pratique de corriger des failles lors de la phase de développement que lors de la phase de production. 

#### Quelques liens utiles

- [Développement sécurisé : Apprendre à maitriser le risque - Korben](https://korben.info/developpement-securise-apprendre-a-maitriser-risque.html)
- [Le guide de développement sécurisé de l'ANSSI](https://www.ssi.gouv.fr/guide/regles-de-programmation-pour-le-developpement-securise-de-logiciels-en-langage-c/)
- [La sécurité du cycle de développement logiciel - RedHat](https://www.redhat.com/fr/topics/security/software-development-lifecycle-security#cycle-de-d%C3%A9veloppement-logiciel-s%C3%A9curis%C3%A9)
- [What is an Intrusion Detection System? - Palo Alto](https://www.paloaltonetworks.com/cyberpedia/what-is-an-intrusion-detection-system-ids)
- [What is IDS and IPS? - Juniper Networks](https://www.juniper.net/us/en/research-topics/what-is-ids-ips.html)