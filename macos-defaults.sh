#!/bin/bash

set -e

echo "🍎 Configuring macOS defaults..."

# Close System Preferences to prevent overriding settings
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# Keyboard & Input                                                            #
###############################################################################

echo "⌨️  Setting keyboard preferences..."

# Set blazingly fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Finder                                                                      #
###############################################################################

echo "📁 Setting Finder preferences..."

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

###############################################################################
# Dock                                                                        #
###############################################################################

echo "🎯 Setting Dock preferences..."

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Misc                                                                        #
###############################################################################

echo "🔧 Setting misc preferences..."

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

###############################################################################
# Restart affected applications                                              #
###############################################################################

echo "🔄 Restarting affected applications..."

for app in "Activity Monitor" \
    "Dock" \
    "Finder" \
    "SystemUIServer"; do
    killall "${app}" &> /dev/null || true
done

echo "✨ macOS defaults configured!"
echo "⚠️  Note: Some changes require a logout/restart to take full effect."
