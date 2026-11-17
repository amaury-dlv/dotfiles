#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🔗 Symlinking dotfiles..."
mkdir -p $HOME/.claude
ln -sf "$DOTFILES_DIR/.claude-home/CLAUDE.md" $HOME/.claude/CLAUDE.md
mkdir -p $HOME/.claude/skills
for skill in "$DOTFILES_DIR"/.claude-home/skills/*/; do
  ln -sfn "${skill%/}" "$HOME/.claude/skills/$(basename "$skill")"
done
# Keep these real dirs so stow doesn't fold them into the repo: apps write
# local state there (gh tokens, jj repos/, ...). Subdirs fold as usual.
mkdir -p "$HOME/.config" "$HOME/.config/jj"
stow -t $HOME/ . "$@"
