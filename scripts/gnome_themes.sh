#!/bin/bash

# Set the cursor theme name and download URL
THEME_NAME="bibata-modern-ice"
CURSOR_THEME_URL="https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz"

# Download and extract the theme
wget -O /usr/share/themes/$THEME_NAME.tar.gz $CURSOR_THEME_URL
tar -xvf /usr/share/themes/$THEME_NAME.tar.gz -C /usr/share/themes/
rm -f /usr/share/themes/$THEME_NAME.tar.gz
echo "Cursor theme installed"

# Papirus icons
sudo apk install papirus-icon-theme

# dconf files
wget -O ~/gnome_settings.dconf https://github.com/hiltar/debian12/blob/main/theme/gnome-settings-backup.conf
dconf load /org/gnome/ < ~/gnome_settings.dconf
rm ~/gnome_settings.dconf
wget -O ~/gnome_terminal.dconf https://github.com/hiltar/debian12/blob/main/terminal_themes/gnome-terminal-profiles.dconf
dconf load /org/gnome/terminal/legacy/profiles:/ < ~/gnome-terminal-profiles.dconf
rm ~/gnome-terminal-profiles.dconf
