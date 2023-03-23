---
title: Tailwindcss pour des styles rapides
date: 2023-03-20 00:00:00
categories: [web, css, framework]
tags: [dev, web, css, framework, tailwindcss, design, style]
---

*Tailwindcss* est un framework CSS qui permet de créer des styles rapidement et simplement. Il est basé sur la philosophie *utility-first*. Il est facile à prendre en main et à intégrer dans un projet existant, surtout si on a déjà utilisé *Bootstrap* et qu'on a des bases en *CSS* classique.

Pour l'utiliser, il suffit de se rendre sur la documentation officielle et de suivre les instructions. Il est possible de l'installer avec *npm* ou *yarn*.

## Installation

### Avec npm

```bash
npm install tailwindcss
```

### Avec yarn

```bash
yarn add tailwindcss
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
npx tailwindcss build input.css -o output.css
```

## Documentation

- [Tailwindcss - Documentation](https://v2.tailwindcss.com/docs)