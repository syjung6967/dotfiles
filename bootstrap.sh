#!/usr/bin/env bash
set -euo pipefail

apt_updated=0
apt_install() {
	[ "$apt_updated" -eq 1 ] || { sudo apt-get update; apt_updated=1; }
	sudo apt-get install -y "$@"
}

summary=()

# ensure <name> <command> <version cmd> <install cmd>
ensure() {
	local status="already installed"
	if ! command -v "$2" >/dev/null; then
		echo "==> Installing $1..."
		eval "$4"
		status="newly installed"
	fi
	local ver; ver=$(eval "$3")
	echo "==> $1 $status ($ver)"
	summary+=("$(printf '%-12s %-18s %s' "$1" "$status" "$ver")")
}

ensure "Git"         git         "git --version | awk '{print \$3}'" \
	"apt_install git"
ensure "ssh-askpass" ssh-askpass "dpkg-query -W -f='\${Version}' ssh-askpass" \
	"apt_install ssh-askpass"
ensure "ripgrep"     rg          "rg --version | awk 'NR==1{print \$2}'" \
	"apt_install ripgrep"
ensure "fd"          fdfind      "fdfind --version | awk '{print \$2}'" \
	"apt_install fd-find"
ensure "Neovim"      nvim        "nvim --version | awk 'NR==1{print \$2}'" \
	"curl -fLo /tmp/nvim.deb https://github.com/neovim/neovim-releases/releases/download/stable/nvim-linux-x86_64.deb; apt_install /tmp/nvim.deb; rm -f /tmp/nvim.deb"
ensure "Claude Code" claude      "claude --version | awk '{print \$1}'" \
	"curl -fSL https://claude.ai/install.sh | bash"

echo
echo "==> Summary"
printf '  %s\n' "${summary[@]}"
