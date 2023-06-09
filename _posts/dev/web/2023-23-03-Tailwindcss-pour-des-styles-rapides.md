---
title: Tailwindcss pour des styles rapides
date: 2023-03-20 00:00:00
categories: [dev, web]
tags: [dev, web, css, framework, tailwindcss, design, style]
---

*Tailwindcss* est un framework CSS qui permet de créer des styles rapidement et simplement. Il est basé sur la philosophie *utility-first*. Il est facile à prendre en main et à intégrer dans un projet existant, surtout si on a déjà utilisé *Bootstrap* et qu'on a des bases en *CSS* classique.

Pour l'utiliser, il suffit de se rendre sur la documentation officielle et de suivre les instructions. Il est possible de l'installer avec *npm* ou *yarn*.

## Installation

### Avec npm

```bash
npm install tailwindcss
```

## Configuration

Il faut ensuite configurer le fichier `tailwind.config.js` pour définir les couleurs, les tailles, les polices, etc. qui seront utilisées dans le projet.

```js
module.exports = {
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
}
```

## Utilisation

Il faut ensuite créer un fichier `input.css` qui va contenir les styles de base du projet et un autre fichier `output.css` qui va contenir les styles générés par *Tailwindcss*.

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Il faut ensuite compiler les fichiers `input.css` et `output.css` pour générer le fichier `output.css` qui contient les styles.

```bash
npx tailwindcss -i .\app\static\input.css -o .\app\static\output.css --watch
```

Pour exécuter la commande, il faut se placer dans le dossier du projet où se trouve les fichiers `package.json` et `tailwind.config.js`. Il faut spécifier les chemins des fichiers `input.css` et `output.css` et ajouter l'option `--watch` pour que la commande s'exécute à chaque modification du fichier `input.css`.

Il ne reste plus qu'à intégrer les classes *Tailwindcss* dans le code HTML. Par exemple, pour créer un bouton avec un fond rouge et un texte blanc, il suffit d'ajouter la classe `bg-red-500` au bouton et la classe `text-white` au texte. La syntaxe est intuitive et facile à retenir. Il suffit de lire la documentation pour comprendre comment utiliser les classes.




## Documentation et liens utiles

- [Tailwindcss - Documentation](https://v2.tailwindcss.com/docs)
- [Tailwindcss - Installation](https://v2.tailwindcss.com/docs/installation)
- [Tailwindcss - Configuration](https://v2.tailwindcss.com/docs/configuration)
- [Flowbite - Tailwindcss Layouts examples](https://flowbite.com/)
- [Interesting post about using a CSS framework - Quora](https://www.quora.com/Should-I-use-my-own-CSS-or-Bootstrap)