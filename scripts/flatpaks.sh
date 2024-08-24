#!/bin/bash

if [ "$EUID" -ne 0 ] ; then
  flatpak install -y --noninteractive flathub com.brave.Browser
  flatpak install -y --noninteractive flathub com.github.tchx84.Flatseal
  flatpak install -y --noninteractive flathub org.mozilla.firefox
  flatpak install -y --noninteractive flathub org.telegram.desktop
  flatpak install -y --noninteractive flathub org.telegram.desktop.webview
else
  echo "Run as non-root"
fi
