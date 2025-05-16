# Install packages by executing `brew bundle --global`.

#
# Formula packages
#

# Version control system
brew "git"

# SSH client
#
# Pre-installed OpenSSH may not support FIDO authenticator even though
# authenticator provider ($SSH_SK_PROVIDER) is specified.
brew "openssh"
#brew "dropbear"

# Security token
#
# List of known vendors and products
# - https://github.com/Yubico/libfido2/blob/main/udev/fidodevs
brew "ykman"
brew "yubico-piv-tool"

# GnuPG
brew "gnupg"

# Text processor
brew "jq"
brew "yq"
brew "biome"

# Enhanced parallel grep
brew "ripgrep"

# Pager
brew "git-delta"

# Static analysis tool
brew "shellcheck"

# Terminal multiplexer
brew "tmux"

# Text editor
#
# Helix is on eager development driven by their vision since May 2021.
# (See https://github.com/helix-editor/helix/blob/master/docs/vision.md)
#
# Commands
# - https://docs.helix-editor.com/master/keymap.html
# - https://docs.helix-editor.com/master/command-line.html
# - https://docs.helix-editor.com/master/commands.html
#
# Helix has brilliant built-in features (e.g., jump to a two-character label)
# but still lacks of lots of convenient commands. For examples:
# - help command
# : https://github.com/helix-editor/helix/issues/12714
# - repeating command or command line. (i.e., ., @:)
# : https://github.com/helix-editor/helix/discussions/5870
# - searching previous command lines beginning with given keyword
# : https://github.com/helix-editor/helix/issues/294
# - one keystroke actions (e.g., <C-Y> for vim, z then k for helix)
# - tagstack
brew "neovim"
#brew "helix"

# Node for language server
brew "node"

# Process viewer
#
# Htop can replace pstree by using tree view (press F5 key).
# For more process details, use `ps`.
brew "htop"

# Periodic monitoring
#
# Use viddy because `watch` does support paging and time machine mode.
# For tracking file changes in real-time, use `less +F` or `tail -f`.
brew "viddy"

# Communication protocol
brew "websocat"
brew "grpcurl"

# Parallel job
#
# Use xargs for few number of large-scale jobs.
# Do not use parallel; it is extremely slow despite of using -X option.
#
# Use purpose-specific program for lots of small-scale jobs because process
# forks can degrade performance.

# Parallel gzip (de)compression
brew "pigz"

# Docker
#
# Do not install "cask" docker; it is for personal or small business.
# Use Rancher Desktop instead.
#brew "docker"
#brew "docker-compose"
#brew "docker-credential-helper"
#brew "docker-credential-helper-ecr"
brew "docker-completion"

#
# Cask packages
#

# FTP client
#
# Mucommander can surf multiple directories so that allows complex transfer.
# Midnight commander is acceptable but it is only suitable for simple transfer.
# Double commander is blocked by Apple security.
cask "mucommander"

# Communication tool
cask "slack"

# Database client
#cask "mongodb-compass"
#cask "mysqlworkbench"

# IDE
cask "visual-studio-code"

# Internet browser
cask "google-chrome"

# Docker for native environment
#cask "rancher"
#cask "podman-desktop"
