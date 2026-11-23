#!/usr/bin/env bash
set -euo pipefail

# Neovim
curl -fLo /tmp/nvim.deb https://github.com/neovim/neovim-releases/releases/download/stable/nvim-linux-x86_64.deb
sudo apt-get install -y /tmp/nvim.deb
rm /tmp/nvim.deb

# Claude Code
curl -fSL https://claude.ai/install.sh | bash
