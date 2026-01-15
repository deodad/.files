# Dot Files

My dot file configuration, optimized specifically for macOS using the [fish shell](https://fishshell.com/).

## What's Included

**Configurations** (symlinked to `~/.config/`):
- Fish shell with [hydro](https://github.com/jorgebucaran/hydro) prompt
- Neovim
- Tmux
- Ghostty terminal
- Git (with GPG commit signing)

**Tools** (installed via Homebrew):
- Development: nvim, git, gh, bun, ripgrep, fzf, fd
- Utilities: bat, eza, zoxide, jq, lazygit, direnv
- Apps: Ghostty, 1Password, Raycast, Chrome, Slack, Spotify

**Other**:
- Caps Lock remapped to Left-Ctrl
- GPG/SSH key generation and configuration

## Installation

Assuming you're on a brand-new machine, run:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/deodad/.files/HEAD/bootstrap.sh)"
```

## Configuration

The `bootstrap.sh` script handles first-time setup: it installs Homebrew, clones this repo, and runs `./install`.

The `./install` script can be run independently to update an existing setup. It:
- Installs Homebrew formulae, casks, and fish plugins
- Creates symlinks from `~/.config/` to this repository
- Sets fish as the default shell
- Generates GPG/SSH keys if none exist

Both scripts are idempotent and safe to run multiple times.
