#!/bin/bash

# Set the cursor theme name and download URL
THEME_NAME="bibata-modern-ice"
CURSOR_THEME_URL="https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz"

# Download and extract the theme
wget -O ~/themes/$THEME_NAME.tar.gz $CURSOR_THEME_URL
tar -xvf ~/themes/$THEME_NAME.tar.gz -C ~/.themes
rm -f ~/themes/$THEME_NAME.tar.gz
echo "Cursor theme installed"

# Shell theme
SHELL_THEME_URL="https://github.com/catppuccin/gtk/releases/download/v1.0.3/catppuccin-frappe-blue-standard+default.zip"
SHELL_THEME_NAME="catppuccin-frappe-blue"
wget -O ~/themes/$SHELL_THEME_NAME.tar.gz $SHELL_THEME_URL
tar -xvf ~/themes/$SHELL_THEME_NAME.tar.gz -C ~/.themes
rm -f ~/themes/$SHELL_THEME_NAME.tar.gz

# Papirus icons
sudo dnf install papirus-icon-theme

# dconf files
wget -O ~/gnome_settings.dconf https://github.com/hiltar/debian12/blob/main/theme/gnome-settings-backup.conf
dconf load /org/gnome/ < ~/gnome_settings.dconf
rm ~/gnome_settings.dconf
wget -O ~/gnome_terminal.dconf https://github.com/hiltar/debian12/blob/main/terminal_themes/gnome-terminal-profiles.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < ~/gnome-terminal-profiles.dconf
rm ~/gnome-terminal-profiles.dconf
