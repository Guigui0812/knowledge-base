---
title: Avoir un terminal plus stylé que jamais
date: 2023-11-06 00:00:00
categories: [devops]
tags: [terminal, zsh, oh-my-zsh, powerlevel10k, customisation]
---

<img src="./img/p10k_linux_terminal.png" alt="p10k_linux_terminal" style="zoom:50%;align:center" />

Avec `zsh` et `oh-my-zsh`, il est possible de personnaliser son terminal afin de le rendre plus agréable et plus attrayant.

## Installer zsh et oh-my-zsh

Installer le paquet `zsh` :

```shell
sudo apt-get install zsh
```

Installer `oh-my-zsh` :

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Installer et configurer powerlevel10k

Il faut maintenant installer le thème `powerlevel10k` :

```shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Il faut ensuite modifier le fichier `~/.zshrc` :

```shell
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Il faut ensuite installer les **fonts** nécessaires au thème `powerlevel10k` comme expliqué [ici.](https://github.com/romkatv/powerlevel10k#fonts)

Lorsque les **fonts** sont installées, il faut lancer la commande suivante afin de personnaliser le thème :

```shell
p10k configure
```

## Installer zsh-autosuggestions

Il faut maintenant installer le plugin `zsh-autosuggestions` qui permet d'avoir des suggestions de commandes en fonction de l'historique :

```shell
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Il faut ensuite modifier le fichier `~/.zshrc` afin d'activer le plugin nouvellement installé :

```shell
plugins=(zsh-autosuggestions)
```

## Installer zsh-syntax-highlighting

Installer le plugin `zsh-syntax-highlighting` qui permet d'avoir une coloration syntaxique des commandes :

```shell
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Il faut ensuite modifier le fichier `~/.zshrc` afin d'activer le plugin nouvellement installé :

```shell
plugins=(zsh-syntax-highlighting)
```

## Astuces

Pour appliquer les modifications apportées au fichier `~/.zshrc` :

```shell
source ~/.zshrc
```

#### Sources

- [Oh My Zsh + PowerLevel10k = 😎 terminal](https://dev.to/abdfnx/oh-my-zsh-powerlevel10k-cool-terminal-1no0)
- [powerlevel10k - github](https://github.com/romkatv/powerlevel10k#installation)
- [zsh-highlighting - github](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
- [zsh-autosuggestion](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
- [A Guide to the Zsh Completion with Examples](https://thevaluable.dev/zsh-completion-guide-examples/)
- [Oh My Zsh - official website](https://ohmyz.sh/)
- [How to make a beautiful terminal](https://dev.to/techschoolguru/how-to-make-a-beautiful-terminal-j11)
- [Setup Zsh + Oh my Zsh + Powerlevel10k + Dracula theme with auto-suggestions and syntax-higlighting](https://medium.com/@satriajanaka09/setup-zsh-oh-my-zsh-powerlevel10k-on-ubuntu-20-04-c4a4052508fd)
