---
title: Astuces Excel
date: 2023-04-08 00:00:00
categories: [bureautique]
tags: [bureautique, excel, astuces, trucs, astuces excel, trucs excel]
---

Excel est un logiciel de tableur très puissant. Il est possible de faire beaucoup de choses avec. Dans cet article, je centralise quelques astuces que j'ai pu découvrir au fil du temps.

# La fonction "RECHERCHEV"

La fonction `RECHERCHEV` permet de rechercher une valeur dans une plage de cellules. Elle renvoie la position de la valeur recherchée dans la plage de cellules. Si la valeur n'est pas trouvée, elle renvoie `#N/A`.

La syntaxe de la fonction est la suivante :

```excel
RECHERCHEV(élément à rechercher, plage de cellules, [indice de la colonne])
```

**Lien** : [Fonction RECHERCHEV - Support Microsoft](https://support.microsoft.com/fr-fr/office/fonction-recherchev-0bbc8083-26fe-4963-8ab8-93a18ad188a1)

# Faire plusieurs "SI"

Il est possible de faire plusieurs `SI` en une seule formule. La syntaxe est la suivante :

```excel
SI(condition1;valeur1;SI(condition2;valeur2;SI(condition3;valeur3;...)))
```

**Lien** : [SI imbriqués - excel-exercice](https://www.excel-exercice.com/si-imbriques/)

# Extraire une partie d'une chaîne de caractères

Il est possible d'extraire une partie d'une chaîne de caractères avec différentes fonctions.

La fonction `GAUCHE` permet d'extraire les caractères de gauche. La syntaxe est la suivante :

```excel
GAUCHE(texte;nombre de caractères)
```

**Lien** : [Fonction pour extraire le texte des cellules - tuto excel](https://tuto-excel.com/excel-formules-texte-extraire.html)