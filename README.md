# Dotfiles
**Use at your own risk.**

Dotfiles do not specify a desktop environment and window manager becuase none is compatible with all operating systems (WSL, Mac OS, Linux).

For the same reason, dotfiles do not specify a terminal emulator.

`dotfiles` alias is equivalent to `git` except for working directory is set to `$HOME`.

## Packages
* Shell: zsh, bash
* Editor: Neovim (using vim compatible scripts as possible)
* Multiplexer: tmux
* System monitor: htop
* File manager: Netrw, [muCommander](https://www.mucommander.com/)
* Package manager: [Homebrew](https://brew.sh/)
  * [Nix](https://nixos.org/) could be an alternative, but it is not intuitive for me and it requires too much configuration.

## Installation
Check Git is set up on your machine before installation.

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

Install Homebrew and all packages from bundle file.
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile # MacOS, zsh
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile # MacOS, bash
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc # Linux, zsh
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc # Linux, bash

brew analytics off

brew bundle --global
```

## Post Installation

## Update dotfiles
```sh
dotfiles add <new files>
dotfiles submodule add <repo> <path>
dotfiles rm <files or submodules>

dotfiles commit -a
dotfiles push origin main
```
