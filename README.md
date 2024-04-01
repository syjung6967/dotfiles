# Dotfiles
**Use at your own risk.**

Dotfiles do not specify a desktop environment or window manager becuase none is compatible with all operating systems (Windows, Mac OS, Linux, BSD).

Dotfiles do not specify a terminal emulator.

`dotfiles` alias is equivalent to `git` except for working directory is set to `$HOME`.

## Packages
* Shell: zsh
* Editor: vim
* Multiplexer: tmux
* System monitor: htop
* File manager: [Midnight Commander](https://midnight-commander.org/)
* Package manager: [Homebrew](https://brew.sh/) (BSD not supported)

## Installation
Run bootstrap first.

```sh
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo !! >> ~/.zshrc

# Init git repo.
mkdir ~/.dotfiles
dotfiles init

# Overwrite dotfiles.
dotfiles remote add origin https://github.com/syjung6967/dotfiles.git
dotfiles pull
dotfiles reset --hard origin/main
dotfiles checkout main

# Update submodules.
dotfiles submodule update --init
```

Install and upgrade all dependant packages from bundle.
```sh
brew bundle --global
```

## Post Installation

## Modification
```sh
dotfiles add <new files>
dotfiles rm <files or submodules>
dotfiles commit -a
dotfiles push origin main
```
