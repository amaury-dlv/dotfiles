#!/bin/bash

# Install Homebrew packages
if command -v brew &> /dev/null; then
    echo "Installing Homebrew packages..."
    brew bundle install
else
    echo "Homebrew not found, skipping package installation"
fi

# Symlink dotfiles
stow -t $HOME/ . "$@"
