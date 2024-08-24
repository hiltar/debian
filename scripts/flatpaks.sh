#!/bin/bash

if [ "$EUID" -ne 0 ] ; then
  flatpak install flathub com.brave.Browser
  flatpak install flathub com.github.tchx84.Flatseal
  flatpak install flathub org.mozilla.firefox
  flatpak install flathub org.telegram.desktop
  flatpak install flathub org.telegram.desktop.webview
else
  echo "Run as non-root"
fi
