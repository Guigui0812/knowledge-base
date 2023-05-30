---
title: Créer un labo virtuel de tests pour sysadmin
date: 2023-04-05 00:00:00
categories: [sysadmin, linux, network, pfsense, pare-feu]
tags: [sysadmin, linux, terminal, pfsense, securité, virtualisation, tests, network, pare-feu, ESIEE Amiens]
---

Article relatant la création d'un réseau virtuel de tests pour sysadmin dans le cadre du TP d'administration système de l'*ESIEE Amiens*. Le but est de mettre en place un réseau d'entreprise basique avec un pare-feu, un DHCP, un serveur DNS, un serveur web, un LDAP et un serveur de fichiers.

---

# Pré-requis

- *VMware Workstation Player* ou *Oracle VirtualBox*
- ISO de *pfSense*
- ISO *Ubuntu Server* 20.04
- Connaissances en réseau
- Connaissances de base en linux

**Remarque** : Il est possible d'utiliser *Docker* afin de déployer efficacement les différents services. Cependant, le but de ce TP est de mettre en place un réseau d'entreprise basique avec un pare-feu, un DHCP, un serveur DNS, un serveur web, un LDAP et un serveur de fichiers. Il est donc préférable d'utiliser des machines virtuelles afin de pouvoir les manipuler facilement.

# Aperçu et schéma du réseau

// Faire un schéma

# Configuration du pare-feu

La solution choisie pour ce TP est *pfSense*. Il s'agit d'un pare-feu open source basé sur *BSD*. Il est possible de l'installer sur une machine physique ou virtuelle. Dans ce TP, nous allons l'installer sur une machine virtuelle.

Le pfsense est la machine qui va relier le réseau interne et le réseau externe. Il va donc être configuré en mode routeur. Il va donc avoir deux interfaces réseau : une interface réseau externe et une interface réseau interne.

L'ISO de *pfSense* est disponible sur le site officiel : https://www.pfsense.org/download/. Une fois téléchargée, il faut la monter dans la machine virtuelle. Il faut ensuite démarrer la machine virtuelle et suivre les instructions d'installation.

**Remarque** : sur *Dell XPS*, j'ai eu des soucis avec la carte réseau WIFI qu'il n'est pas possible d'utiliser en réseau "bridgé". J'ai donc du utiliser un adaptateur réseau USB. Il faut donc brancher l'adaptateur réseau USB sur le PC et sélectionner l'inteface réseau correspondante dans la machine virtuelle.

La procédure d'installation est assez trivial. Il suffit de suivre les instructions. Une fois l'installation terminée, il faut configurer le pare-feu. Pour cela, il faut se connecter à l'interface web du pare-feu. La configuration est basique puisqu'il s'agit d'un labo.

## Les étapes en images 

Sélection de l'installation :

![Cliquer sur installer](../../assets/admin-linux/Installation_1.png)

Choix de la langue du clavier : 

![Changer la langue du clavier](../../assets/admin-linux/Installation_2.png)

Choix du mode de partition du disque dur :

![Auto UFS ou ZFS](../../assets/admin-linux/Installation_3.png)

Choix du type de disque disque virtuel :

![Choisir Stripe](../../assets/admin-linux/Installation_4.png)

Choix du disque dur et validation:

![Choisir le disque et valider](../../assets/admin-linux/Installation_5.png)

## Aperçu de la configuration du pare-feu

![Choisir le disque et valider](../../assets/admin-linux/Installation_6.png)

![Choisir le disque et valider](../../assets/admin-linux/Installation_7.png)

![Choisir le disque et valider](../../assets/admin-linux/Installation_10.png)

![Choisir le disque et valider](../../assets/admin-linux/Installation_11.png)

**Paramétrage de l'interface réseau externe** pour accéder à l'interface web du pare-feu:

![Choisir le disque et valider](../../assets/admin-linux/Installation_8.png)

![Choisir le disque et valider](../../assets/admin-linux/Installation_9.png)

Ici, cette carte réseau virtuelle permet au PC d'accéder à l'interface web du pare-feu. Notre PC sera donc virtuellement connecté au réseau virtuel.

# Création d'une machine virtuelle template

- Installer *Ubuntu Server* 20.04
- Finaliser l'installation (changer le mot de passe root, créer un utilisateur, etc., laisser les paramètres par défaut)
- Faire les mises à jour : `sudo apt-get update` / `sudo apt-get upgrade`.
- Changer la configuration réseau dans le fichier /etc/netplan/50-cloud-init.yaml : `sudo nano /etc/netplan/50-cloud-init.yaml`. 
- Une fois les modifications effectuées, il faut appliquer la configuration réseau : `sudo netplan apply`.
- Changer le nom de la machine : `sudo hostnamectl set-hostname <nom-de-la-machine>`.
  
Ce template sera utilisé pour créer les autres machines virtuelles (serveur web, serveur DNS, serveur LDAP, serveur de fichiers, etc.).

# Création d'un serveur DHCP/DNS

- Cloner la machine virtuelle template
- Changer le nom de la machine virtuelle
- Changer l'adresse IP de la machine virtuelle

## Le serveur DHCP

- Installer le serveur DHCP/DNS : `sudo apt-get install isc-dhcp-server`
- Se rendre dans le fichier de configuration du serveur DHCP : `sudo nano /etc/dhcp/dhcpd.conf`
- Adapter les lignes suivantes du fichier de configuration du serveur DHCP :

```bash
subnet 10.5.5.0 netmask 255.255.255.224 {
  range 10.5.5.26 10.5.5.30;
  option domain-name-servers ns1.internal.example.org;
  option domain-name "internal.example.org";
  option subnet-mask 255.255.255.224;
  option routers 10.5.5.1;
  option broadcast-address 10.5.5.31;
  default-lease-time 600;
  max-lease-time 7200;
}
```

Il faut adapter le bloc en fonction du réseau que l'on souhaite créer. Par exemple : 

```bash
subnet 192.168.101.0 netmask 255.255.255.0 {
  range 192.168.101.10 192.168.101.30;
  option domain-name-servers 192.168.101.201;
  option domain-name "grp08.lab";
  option subnet-mask 255.255.255.0;
  option routers 192.168.101.254;
}
```

Il faut ensuite spécifier l'inteface réseau sur laquelle le serveur DHCP va écouter. Pour connaître le nom de l'interface réseau, il faut taper la commande `ip a`. Ensuite, il faut se rendre dans le fichier de configuration du serveur DHCP : `sudo nano /etc/default/isc-dhcp-server`. Il faut ensuite adapter la ligne suivante :

```bash
INTERFACESv4="enp0s3"
```

Le nom change en fonction de l'interface réseau sur laquelle le serveur DHCP va écouter.

Enfin, il faut redémarrer le serveur DHCP : `sudo systemctl restart isc-dhcp-server`. On peut ensuite vérifier le statut du serveur DHCP : `sudo systemctl status isc-dhcp-server`.

Pour la démonstration, on crée une nouvelle machine qui va se connecter au réseau virtuel. On peut voir que la machine virtuelle a bien récupéré une adresse IP du serveur DHCP.

## Le serveur DNS

Dans un premier temps, il faut installer le serveur DNS : `sudo apt-get install bind9`. Il faut également installer le paquet `dnsutils` pour pouvoir utiliser la commande `dig` : `sudo apt-get install dnsutils`. Ensuite, il faut se rendre dans le fichier de configuration du serveur DNS : `sudo nano /etc/bind/named.conf.local`. Il faut ensuite adapter la ligne suivante :

```bash
zone "example.com" {
  type master;
  file "/etc/bind/db.example.com";
};
```

Il faut ensuite créer le fichier de configuration du domaine : `sudo nano /etc/bind/db.example.com`. Il faut ensuite adapter le fichier de configuration du domaine en fonction du réseau que l'on souhaite créer. On peut simplement copier le fichier de configuration du domaine de la machine virtuelle template : `sudo cp /etc/bind/db.local /etc/bind/db.example.com`. Ensuite, il faut adapter le fichier de configuration du domaine en fonction du réseau que l'on souhaite créer.

Contenu du fichier de configuration du domaine :

```bash
;
; BIND data file for example.com
;
$TTL    604800
@       IN      SOA     example.com. root.example.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

@       IN      NS      ns.example.com.
@       IN      A       192.168.1.10
@       IN      AAAA    ::1
ns      IN      A       192.168.1.10
ldap    IN      A       192.168.1.11
www     IN      A       192.168.1.10
```

A chaque modification il faut ensuite redémarrer le serveur DNS : `sudo systemctl restart bind9`. On peut ensuite vérifier le statut du serveur DNS : `sudo systemctl status bind9`.

Pour vérifier que le serveur DNS est bien installé, on peut utiliser `nslookup`. On spécifie le serveur DNS que l'on souhaite utiliser (ici c'est 192.168.1.10) puis on demande l'adresse IP de l'adresse web que l'on souhaite consulter. Le serveur DNS va alors nous renvoyer l'adresse IP de l'adresse web que l'on souhaite consulter et indiquer si l'adresse web existe ou non.

```bash
nslookup
> server <adresse DNS>
> www.example.com
```

**Problème commun** : Parfois le pare-feu se plante sans raison. Cela a pour effet de casser le réseau virtuel. Il faut alors redémarrer le pare-feu pfSense via VirtualBox.

## Le serveur LDAP

### Installation du serveur LDAP

Le serveur LDAP est une serveur différent. Il faut donc cloner le template, paramétrer son IP et changer son nom. On peut ensuite installer le serveur LDAP : `sudo apt-get install slapd ldap-utils`. 

Il faut aussi installer le paquet `dpkg-reconfigure` pour pouvoir utiliser la commande `dpkg-reconfigure slapd`. Cette commande permet de reconfigurer le LDAP si des éléments ont été omis lors de l'installation (par exemple, le mot de passe de l'administrateur LDAP, le nom du domaine, etc.).

Pour vérifier que le serveur LDAP est bien installé, on peut utiliser la commande `ldapsearch -x -LLL -b dc=nom,dc=lab`. Cette commande permet de lister les éléments du LDAP.

Pour la suite de la configuration du serveur LDAP, on peut utiliser Apache Directory Studio. Cet outil permet de gérer le LDAP et de créer des utilisateurs dans l'annuaire LDAP. Il faut télécharger le logiciel [Apache Directory Studio](https://directory.apache.org/studio/downloads.html). Il faut ensuite lancer le logiciel et se connecter au serveur LDAP. On peut ensuite créer un utilisateur dans le LDAP.

**A savoir** : `Apache Diretory Studio` nécessite Java 11 ou plus. Il faut télécharger le JDK sur le site officiel, puis se rendre dans le répertoire `ProgramFiles` et modifier `ApacheDirectoryStudio.ini` pour ajouter le chemin vers le JDK : 

```bash
-vm
C:\Program Files\Java\jdk-11.0.2\bin
```

Il faut ensuite créer les unités organisationnelles dans le LDAP. Pour cela, il faut constituer un fichier `base.ldif` de ce type :

```bash
dn: ou=Users,dc=ENT-8,dc=loc
objectClass: organizationalUnit
ou: Users

dn: ou=Groups,dc=ENT-8,dc=loc
objectClass: organizationalUnit
ou: Groups

dn: ou=Machines,dc=ENT-8,dc=loc
objectClass: organizationalUnit
ou: Machines
```

Ce fichier permet de créer les unités organisationnelles dans le LDAP. Il peut se situer dans le répertoire personnel de l'utilisateur ldap. 

Il faut ensuite ajouter le fichier `base.ldif` dans le LDAP : `ldapadd -x -D "cn=admin,dc=ENT-8,dc=loc" -W -f base.ldif`. Il faut ensuite entrer le mot de passe de l'administrateur LDAP.

La sortie de la commande doit ressembler à ceci :

```bash
adding new entry "ou=Users,dc=ENT-8,dc=loc"

adding new entry "ou=Groups,dc=ENT-8,dc=loc"

adding new entry "ou=Machines,dc=ENT-8,dc=loc"
```

Dorénavant, le LDAP est configuré. Il faut maintenant passer à la configuration des clients. Pour cela, il faut installer les ldapscripts : `sudo apt-get install ldapscripts` puis les configurer. Il faut ensuite créer un fichier de configuration pour les ldapscripts : `sudo nano /etc/ldapscripts/ldapscripts.conf`. Il peut être prudent de sauvegarder le fichier de configuration par défaut : `sudo cp /etc/ldapscripts/ldapscripts.conf /etc/ldapscripts/ldapscripts.conf.bck`. 

Dans ce fichiers, plusieurs éléments à modifier :

- Décommenter la ligne `SERVER=ldap://` puis ajouter l'adresse IP du serveur LDAP : `SERVER=ldap://<ip_address>`.
- Décommmenter la ligne `SUFFIX=dc=example,dc=com` puis ajouter le nom du domaine : `SUFFIX=dc=ENT-8,dc=loc`.
- Décommenter la ligne `GSUFFIX=ou=Groups`
- Décommenter la ligne `USUFFIX=ou=Users`
- Décommenter la ligne `MSUFFIX=ou=Machines`
- Modifier la ligne `BINDDN=cn=admin,dc=example,dc=com` en `BINDDN=cn=admin,dc=ENT-8,dc=loc` (en fonction du nom du domaine). Ici, on pourrait utiliser un autre utilisateur que l'administrateur LDAP pour des raisons de sécurité.
- Décommenter `USHELL=/bin/sh` et modifier le chemin pour `USHELL=/bin/bash` pour que les utilisateurs aient un shell bash.
- Décommenter `UHOME=/home` et modifier le chemin pour `UHOME=/export/home` pour que les utilisateurs aient un répertoire personnel sur le serveur NFS.
- Pour `CREATEHOMES=no`, il faut mettre `CREATEHOMES=yes` pour que les utilisateurs aient un répertoire personnel.

Il faut ensuite mettre le mot de passe du compte LDAP dans `/etc/ldapscripts/ldapscripts.passwd`. On remplace `secrets` par le mot de passe du compte LDAP. Il faut ensuite s'assurer que seul le root a la persmission d'accéder au fichier. Pour s'en assurer on peut utiliser `sudo chmod 400 /etc/ldapscripts/ldapscripts.passwd`. En cas de problème, on peut utiliser la commande `sudo chmod 600 /etc/ldapscripts/ldapscripts.passwd` pour remettre les droits en écriture.

Si un problème survient pour créer un utilisateur, on peut tenter de passer directement le mot de passe au LDAP. Pour cela, on utiiise `sudo sh -c 'echo -n "<password>" > /etc/ldapscripts/ldapscripts.passwd'`. On peut ensuite créer un groupe avec la commande `sudo ldapaddgroup <group_name>`. On peut ensuite créer un utilisateur avec la commande `sudo ldapadduser <user_name> <group_name>`.

Il faut être vigilant : si un home directory a été paramétré, il faut s'assurer que le répertoire existe sur le serveur NFS. Pour cela, on peut utiliser la commande `sudo mkdir -p /export/home`. Si la commande intervient après la création de l'utilisateur, on peut le supprimer avec la commande `sudo ldapdeleteuser <user_name>`. Il faut ensuite le recréer.

Il faut modifier le mot de passe de l'utilisateur LDAP car celui placé par défaut n'est pas connu. Pour cela, on peut utiliser la commande `sudo ldapsetpasswd`.

### Sécurisation du serveur LDAP

Pour sécuriser le serveur LDAP, il faut utiliser TLS. D'abord on doit installer les paquets `gnu-tls-bin` et `ssl-cert` : `sudo apt-get install gnutls-bin ssl-cert`. 

Il faut ensuite créer un certificat pour l'autorité de certification : `sudo certtool --generate-privkey --bits 4096 --outfile /etc/ssl/private/mycakey.pem`. 

Dans un second temps, on crée un fichier `ca.info` en utilisant nano `sudo nano /etc/ssl/ca.info`. Le contenu sera le suivant : 

```bash
cn = Example Company
ca
cert_signing_key
expiration_days = 3650
```

Il faut ensuite créer le certificat CA autosigné : 

```bash	
sudo certtool --generate-self-signed \
--load-privkey /etc/ssl/private/mycakey.pem \
--template /etc/ssl/ca.info \
--outfile /usr/local/share/ca-certificates/mycacert.crt
```

Il faut ensuite faire `sudo update-ca-certificates` pour mettre à jour les certificats.

Il faut ensuite créer une clé privée pour le serveur LDAP : `sudo certtool --generate-privkey --bits 2048 --outfile /etc/ldap/ldap01_slapd_key.pem`. Adaptez le nom du fichier en fonction de votre serveur (exemple : `random_name.pem`).

Il faut ensuite créer un fichier `ldap.info` en utilisant nano `sudo nano /etc/ssl/ldap.info`. Le contenu sera le suivant : 

```bash
organization = Example Company
cn = ldap01.example.com
tls_www_server
encryption_key
signing_key
expiration_days = 365
```

Il faut ensuite créer le certificat pour le serveur LDAP : 

```bash
sudo certtool --generate-certificate \
--load-privkey /etc/ldap/ldap01_slapd_key.pem \
--load-ca-certificate /etc/ssl/certs/mycacert.pem \
--load-ca-privkey /etc/ssl/private/mycakey.pem \
--template /etc/ssl/ldap01.info \
--outfile /etc/ldap/ldap01_slapd_cert.pem
```

Remplacez le nom du fichier en fonction de votre serveur (exemple : `random_name.pem`). Il faut cependant faire attention au fait que la clé privée doit être la même que celle utilisée pour la création du certificat.

Enfin, il faut ajuster les permissions : 
  
```bash
sudo chgrp openldap /etc/ldap/ldap01_slapd_key.pem
sudo chmod 0640 /etc/ldap/ldap01_slapd_key.pem
```

Il faut maintenant créer un fichier `certinfo.ldif` en utilisant nano `sudo nano /etc/ldap/certinfo.ldif`. Le contenu sera le suivant : 

```bash
dn: cn=config
add: olcTLSCACertificateFile
olcTLSCACertificateFile: /etc/ssl/certs/mycacert.pem
-
add: olcTLSCertificateFile
olcTLSCertificateFile: /etc/ldap/ldap01_slapd_cert.pem
-
add: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/ldap/ldap01_slapd_key.pem
```

Il faut ensuite ajouter les informations au fichier de configuration du serveur LDAP : `sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f certinfo.ldif` (adapter le chemin du fichier en fonction de votre serveur).

Grâce à ces étapes, le serveur LDAP est maintenant sécurisé et fonctionnel avec TLS. Nous allons pouvoir effectuer un test de connexion avec un client LDAP.

### Configuration du client LDAP

Pour les clients on utilise le SSSD. Ce service permet de gérer les utilisateurs et les groupes. Il faut installer les paquets `ldap-utils` et `sssd-ldap` : `sudo apt install sssd-ldap ldap-utils`.

Il faut ensuite éditer le fichier de configuration du SSSD : `sudo nano /etc/sssd/sssd.conf`. Le contenu sera le suivant : 

```bash
[sssd]
config_file_version = 2
domains = example.com

[domain/example.com]
id_provider = ldap
auth_provider = ldap
ldap_uri = ldap://ldap01.example.com
cache_credentials = True
ldap_search_base = dc=example,dc=com
```

Il faut adapter les domaines à votre cas. 

Il faut paramétrer les droits du fichier nouvellement créé : `sudo chmod 0600 /etc/sssd/sssd.conf`.

Il faut ensuite redémarrer le service avec `sudo systemctl restart sssd.service`.

Il faut maintenant rajouter le certificat créé sur le serveur LDAP au client. 

Sur le serveur LDAP, on se place dans `/usr/local/share/ca-certificates/` avec `cd /usr/local/share/ca-certificates/` et on `cat` le fichier `mycacert.crt` pour récupérer le contenu du certificat. On copie le contenu du certificat.

Sur le client, on se place dans `/usr/local/share/ca-certificates/` avec `cd /usr/local/share/ca-certificates/` et on `nano` le fichier `mycacert.crt`. On colle le contenu du certificat dans le fichier.

Enfin, on met à jour les certificats avec `sudo update-ca-certificates`.

On peut maintenant invoquer la commande : `ldapwhoami -x -ZZ -H ldap://ldap01.example.com` pour tester la connexion au serveur LDAP. Normalement, on devrait avoir un retour du type : `anonymous` puisque notre utilisateur admin n'est pas connu du LDAP.

On peut maintenant vérifier que le service SSSD fonctionne : `getent passwd <utilisateur>` et `getent group <grp>`. Les informations des utilisateurs et des groupes devraient être affichées. On peut aussi vérifier qu'on peut se connecter avec un utilisateur du LDAP : `sudo login <utilisateur>`.

## Serveur NFS

### Configuration du serveur NFS

Installation du serveur NFS : `sudo apt install nfs-kernel-server`.

Démarrer le service NFS : `sudo systemctl start nfs-kernel-server.service`.

Accéder à la configuration du serveur NFS : `sudo nano /etc/exports` et ajouter la ligne suivante : 

```bash
/export/home *(rw,async,no_subtree_check,no_root_squash)
```

Elle permet de partager le dossier `/export/home` avec tous les clients du réseau. On peut aussi ajouter des options supplémentaires comme `sync` pour synchroniser les données sur le disque dur.

On peut maintenant confirmer les modifications : `sudo exportfs -a`.

### Configuration du client NFS

Installation du client NFS : `sudo apt install nfs-common`.

Créer le dossier de montage : `sudo mkdir-p /export/home`.

Monter le volume distant : `sudo mount ldap.ENT-8.loc:/export/home /export/home`.

On peut vérifier que le montage est bien effectué avec `ls /export/home`. Le dossier devrait contenir les répertoires des utilisateurs du LDAP.

Il faut maintenant gérer les droits d'accès afin que les utilisateurs LDAP ne puissent pas accéder aux fichiers des autres utilisateurs.

Pour cela, sur le serveur LDAP, sur chaque répertoire, on va changer les droits d'accès : `sudo chmod 700 <repertoire>`. De cette manière, seul le propriétaire du répertoire aura les droits d'accès.


# Conclusion

Cet exercice permet d'avoir une vue d'ensemble de la mise en place d'un environnement de serveurs pour une entreprise. Il permet de comprendre les différents services et les différentes configurations à mettre en place pour que tout fonctionne correctement. Il permet également de se familiariser avec les commandes de base de Linux et de comprendre les différents fichiers de configuration.

#### Sources et documentations

- Cours d'administration systèmes de Stéphane POMPORTES, enseignant chercheur à l'ESIEE Amiens
- [Créer son lab virtuel avec VirtualBox et PfSense - Youtube IT Connect](https://www.youtube.com/watch?v=NzVDjNqchoc)
- [Comment installer pfsense dans virtualbox pour créer un lab virtuel - IT Connect](https://www.it-connect.fr/comment-installer-pfsense-dans-virtualbox-pour-creer-un-lab-virtuel/)
- [Install DNS - Documentation Ubuntu](https://ubuntu.com/server/docs/service-domain-name-service-dns)
- [Install LDAP - Documentation Ubuntu](https://ubuntu.com/server/docs/service-ldap)
- [Service LDAP usage - Documentation Ubuntu](https://ubuntu.com/server/docs/service-ldap-usage)
- [SSSD LDAP - Documentation Ubuntu](https://ubuntu.com/server/docs/service-sssd-ldap)
- [Install NFS - Documentation Ubuntu](https://ubuntu.com/server/docs/service-nfs)
- [DHCP - Documentation Ubuntu](https://ubuntu.com/server/docs/network-dhcp)
- [Example de fichier netplan - Ubuntu](https://netplan.io/examples)