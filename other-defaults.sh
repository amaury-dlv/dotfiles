#!/bin/bash
# Preferences for apps that only store settings in macOS defaults, with no
# config file. (System-wide settings live in macos-defaults.sh.)

set -e

DOTFILES_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

###############################################################################
# Rex (com.superlogical.rex)                                                  #
###############################################################################
# Key bindings live in .config/rex/init.lua. Everything set in Rex's Settings
# window is stored here instead. To find a key after changing it in the UI:
#   defaults read com.superlogical.rex
# To refresh themes.json after editing a custom theme in the UI:
#   defaults read com.superlogical.rex Workspace.customThemes | xxd -r -p | jq -S . > .config/rex/themes.json

echo "🦖 Setting Rex preferences..."

REX=com.superlogical.rex

# Theme: custom "Monokai Remastered" (imported from Ghostty) for dark mode
defaults write $REX Workspace.customThemes -data "$(xxd -p "$DOTFILES_DIR/.config/rex/themes.json" | tr -d '\n')"
defaults write $REX Workspace.appearance -string dark
defaults write $REX Workspace.darkThemeID -string custom-C1169F68-A78A-460D-A53F-82414ACBB679
defaults write $REX Workspace.lightThemeID -string merino-light
defaults write $REX Workspace.interfaceStyle -string useTheme

# Terminal
defaults write $REX Workspace.terminalFontPointSize -float 13
defaults write $REX Workspace.terminalCustomSchemeLinks -string open

# Panes
defaults write $REX Workspace.focusFollowsMouse -bool true

# Sidebar and tabs
defaults write $REX Workspace.sidebarPosition -string left
defaults write $REX Workspace.sidebarShowsActivity -bool false
defaults write $REX Workspace.tabStyle -string vertical
defaults write $REX Workspace.tabIconCount -int 3
defaults write $REX Workspace.tabIconTintMode -string off
defaults write $REX Workspace.tabsFillAvailableSpace -bool false

# Agents name their sessions
defaults write $REX rex.agents.names-sessions -bool true

# Server
defaults write $REX rex.server.run-mode -string bundled
defaults write $REX rex.server.automatic-restart-enabled -bool true
defaults write $REX rex.server.block-plugin-reload-enabled -bool false
defaults write $REX rex.server.tailnet-enabled -bool false
defaults write $REX rex.server.web-client-origin-patterns -array "https://rex.superlogical.com"

# Updates
defaults write $REX SUEnableAutomaticChecks -bool true
defaults write $REX SUAutomaticallyUpdate -bool true

if pgrep -xq Rex; then
    echo "⚠️  Rex is running: quit and reopen it to pick up the changes."
fi

echo "✨ App defaults configured!"
