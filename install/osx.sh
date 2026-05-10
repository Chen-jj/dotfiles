#!/bin/bash

set -e

# macOS System Preferences Configuration
# Based on https://github.com/mathiasbynens/dotfiles/blob/main/.macos

echo "Configuring macOS system preferences..."

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Trackpad, Mouse, Keyboard                                                   #
###############################################################################

# Enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Mission Control: swipe up with three fingers
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 0
defaults write com.apple.dock showMissionControlGestureEnabled -bool true

# Switch between full-screen apps: swipe left or right with three fingers
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 0

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

###############################################################################
# Keyboard Shortcuts                                                          #
###############################################################################

SYMBOLIC_HOTKEYS_PLIST="$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"

set_symbolic_hotkey() {
    local key="$1"
    local enabled="$2"
    local character="$3"
    local keycode="$4"
    local modifiers="$5"

    /usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:$key" "$SYMBOLIC_HOTKEYS_PLIST" >/dev/null 2>&1 || true
    /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key dict" "$SYMBOLIC_HOTKEYS_PLIST"
    /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key:enabled bool $enabled" "$SYMBOLIC_HOTKEYS_PLIST"

    if [ -n "$character" ] && [ -n "$keycode" ] && [ -n "$modifiers" ]; then
        /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key:value dict" "$SYMBOLIC_HOTKEYS_PLIST"
        /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key:value:type string standard" "$SYMBOLIC_HOTKEYS_PLIST"
        /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key:value:parameters array" "$SYMBOLIC_HOTKEYS_PLIST"
        /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key:value:parameters:0 integer $character" "$SYMBOLIC_HOTKEYS_PLIST"
        /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key:value:parameters:1 integer $keycode" "$SYMBOLIC_HOTKEYS_PLIST"
        /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key:value:parameters:2 integer $modifiers" "$SYMBOLIC_HOTKEYS_PLIST"
    fi
}

defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys >/dev/null 2>&1 || \
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict

###############################################################################
# Finder                                                                      #
###############################################################################

# Show hidden files by default
# Note: Use Cmd+Shift+. to toggle in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show the ~/Library folder
chflags nohidden ~/Library 2>/dev/null || true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Disable window animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Search scope: current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use column view by default
# defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

###############################################################################
# Dock                                                                        #
###############################################################################

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Position the Dock on the left
defaults write com.apple.dock orientation -string "left"

# Use the Genie effect when minimizing windows
defaults write com.apple.dock mineffect -string "genie"

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don't show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Enable Safari's debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true || true

# Enable the Develop menu and the Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true || true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true || true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true || true

###############################################################################
# TextEdit                                                                    #
###############################################################################

# Use plain text mode for new documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Disable smart quotes/dashes in TextEdit
defaults write com.apple.TextEdit SmartQuotes -bool false
defaults write com.apple.TextEdit SmartDashes -bool false

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Kill affected applications                                                  #
###############################################################################

echo "Restarting affected applications..."

killall cfprefsd &>/dev/null || true
for app in "Dock" "Finder" "Safari" "SystemUIServer"; do
    killall "$app" &>/dev/null || true
done

echo "macOS configuration complete."
