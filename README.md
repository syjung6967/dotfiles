# Dotfiles

**Use at your own risk.**

The dotfiles needs aid of [Devbox](https://www.jetify.com/devbox) to isolate development environment and to reduce onboarding time.
- Devbox leverages [Nixpkgs](https://github.com/NixOS/nixpkgs) as package collection.
  - Native Nix is not intuitive for me and it requires too much configuration.

The dotfiles do not specify a desktop environment and window manager becuase none is compatible with all operating systems (WSL, Mac OS, Linux, BSD).

For the same reason, the dotfiles do not specify a terminal emulator.

## Installation
Check Git is set up on your machine before installation.

Run bootstrap first.

```sh
# Install `bash` and `bash-completion`.

# Install Devbox.
curl -fsSL https://get.jetify.com/devbox | bash

# Make shell to use global profile.
echo 'eval "$(devbox global shellenv --init-hook)"' < ~/.bashrc

# Pull global config.
#
# WARN: existing global profile on local will be removed.
devbox global pull <repo>
```

The dotfiles is located on `$DEVBOX_PROJECT_ROOT`.

Add the scripts to bashrc for using the dotfiles.

```sh
eval "$(devbox global shellenv --init-hook)"

. $DEVBOX_PROJECT_ROOT/.config/bash_completion
```

## Update dotfiles

Run `devbox global push <repo>` to update the dotfiles same as local.

## Packages

Version control system
- `git`

SSH client
- `openssh`
  - `dropbear` could be a good replacement but I do not prefer it due to lack of some OpenSSH compatibility.

Security token
- YubiKey: [List of known vendors and products](https://github.com/Yubico/libfido2/blob/main/udev/fidodevs)
  - `yubikey-manager`
  - `yubico-piv-tool`

Text processor
- `ripgrep`: grep in parallel
- `jq`
- `yq`
- `biome`: an replacement of `prettier` ([Differences with Prettier](https://biomejs.dev/formatter/differences-with-prettier/))

Pager
- `delta`

Language support
- Ctags
  - `universal-ctags`
- Shell scripts
  - `shellcheck`
- C/C++/Obj-C
  - `clang`
- Node.js
  - `nodejs`: for running LSP server
- Go
  - `go_1_24`
  - `gopls`
  - `goimports-reviser`
- Rust
  - `rustc`
  - `cargo`
  - `rust-analyzer`
- Solidity
  - `foundry`
  - `solc-select`
- Cross compile
  - `llvm`
  - `lld`
  - `clang-tools`

Terminal multiplexer
- `tmux`

Text editor
- `neovim`
  - `helix` could be a good replacement but I do not prefer it due to lack of plugin system.

Process viewer
- `htop`
  - `htop` can replace pstree by using tree view (press F5 key).
  - For more process details, use `ps`.

File manager
  - None (use Netrw in nvim)

Periodic monitoring
- `viddy`
  - Use `viddy` to support paging and time machine mode.
  - For tracking file changes in real-time, use `less +F` or `tail -f`.

Communication protocol
- `websocat`
- `grpcurl`

Parallel gzip (de)compression
- `pigz`
