#!/bin/bash

# Debian 13 does not install Ubuntu/Yaru themes by default. Omakub's theme
# scripts reference Yaru GTK themes, so install the Debian-packaged variants
# when available. Icons are still selected defensively in themes/set-gnome-theme.sh.
if apt-cache show yaru-theme-gtk >/dev/null 2>&1 && apt-cache show yaru-theme-icon >/dev/null 2>&1; then
  sudo apt install -y yaru-theme-gtk yaru-theme-icon yaru-theme-gnome-shell yaru-theme-sound
fi

sudo apt install -y adwaita-icon-theme
