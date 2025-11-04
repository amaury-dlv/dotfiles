#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🔗 Symlinking dotfiles..."
mkdir -p $HOME/.claude
ln -sf "$DOTFILES_DIR/.claude-home/CLAUDE.md" $HOME/.claude/CLAUDE.md
stow -t $HOME/ . "$@"
