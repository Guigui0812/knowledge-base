---
title: Avoir un terminal plus stylé que jamais
date: 2023-11-06 00:00:00
categories: [devops]
tags: [terminal, zsh, oh-my-zsh, powerlevel10k, customisation]
---

Avec `zsh` et `oh-my-zsh`, il est possible de personnaliser son terminal afin de le rendre plus agréable et plus attrayant. 

## Installer zsh et oh-my-zsh

Installer le paquet `zsh` :

```bash
sudo apt-get install zsh
```

Installer `oh-my-zsh` :

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Installer et configurer powerlevel10k

Il faut maintenant installer le thème `powerlevel10k` :

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Il faut ensuite modifier le fichier `~/.zshrc` :

```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Il faut ensuite installer les **fonts** nécessaires au thème `powerlevel10k` comme expliqué [ici.](https://github.com/romkatv/powerlevel10k#fonts)

Lorsque les **fonts** sont installées, il faut lancer la commande suivante afin de personnaliser le thème :

```bash
p10k configure
```

## Installer zsh-autosuggestions

Il faut maintenant installer le plugin `zsh-autosuggestions` qui permet d'avoir des suggestions de commandes en fonction de l'historique :

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Il faut ensuite modifier le fichier `~/.zshrc` afin d'activer le plugin nouvellement installé :

```bash
plugins=(zsh-autosuggestions)
```

## Installer zsh-syntax-highlighting

Installer le plugin `zsh-syntax-highlighting` qui permet d'avoir une coloration syntaxique des commandes :

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Il faut ensuite modifier le fichier `~/.zshrc` afin d'activer le plugin nouvellement installé :

```bash
plugins=(zsh-syntax-highlighting)
```

## Astuces

Pour appliquer les modifications apportées au fichier `~/.zshrc` :

```bash
source ~/.zshrc
```

#### Sources

- [Oh My Zsh + PowerLevel10k = 😎 terminal](https://dev.to/abdfnx/oh-my-zsh-powerlevel10k-cool-terminal-1no0)
- [powerlevel10k - github](https://github.com/romkatv/powerlevel10k#installation)
- [zsh-highlighting - github](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
- [zsh-autosuggestion](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)

