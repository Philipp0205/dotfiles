#!/bin/sh
# Usage: curl -fsLS https://raw.githubusercontent.com/Philipp0205/dotfiles/main/bootstrap.sh | sh
set -eu
REPO="${SETUPIFY_REPO:-https://github.com/Philipp0205/dotfiles.git}"
SRC="$HOME/.local/share/chezmoi"

if ! command -v ansible-playbook >/dev/null; then
  if command -v apt-get >/dev/null; then sudo apt-get update && sudo apt-get install -y git curl ansible
  else sudo dnf install -y git curl ansible-core || { sudo dnf install -y epel-release && sudo dnf install -y git curl ansible-core; }
  fi
fi

[ -d "$SRC/.git" ] || git clone "$REPO" "$SRC"

cd "$SRC/ansible"
ansible-playbook site.yml --limit localhost -K

export PATH="$HOME/.local/bin:$PATH"
chezmoi apply
echo "Done. Run: gh auth login && gh extension install dlvhdr/gh-dash"
