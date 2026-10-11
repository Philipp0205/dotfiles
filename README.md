# dotfiles

## Machine setup (chezmoi + ansible)

- `home/` – chezmoi source (dotfiles); `.chezmoiroot` points chezmoi here.
- `ansible/` – installs zsh, oh-my-zsh, chezmoi, gh, gh-dash, fzf, yazi, evil-helix, herdr, opencode.
- `bootstrap.sh` – one-liner for a fresh machine (Fedora, RHEL9, Ubuntu/Debian).

Servers: add them to `ansible/inventory.yml`, then `cd ansible && ansible-playbook site.yml --limit vps1 -K`.
Re-run any time; tools are installed once (delete the binary to force an upgrade).
