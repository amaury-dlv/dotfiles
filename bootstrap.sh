#!/bin/bash

set -e

echo "🚀 Setting up dotfiles..."

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi

# Install Homebrew packages
echo "📦 Installing Homebrew packages..."
brew bundle install

# Symlink dotfiles
echo "🔗 Symlinking dotfiles..."
stow -t $HOME/ . "$@"

# Ask user if they want to configure macOS defaults
echo ""
read -p "🍎 Configure macOS defaults (keyboard, Finder, Dock, etc.)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./macos-defaults.sh
fi

echo "✨ Setup complete!"
