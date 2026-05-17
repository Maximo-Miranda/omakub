#!/bin/bash

ULAUNCHER_VERSION="5.15.15"
cd /tmp
wget -qO ulauncher.deb "https://github.com/Ulauncher/Ulauncher/releases/download/${ULAUNCHER_VERSION}/ulauncher_${ULAUNCHER_VERSION}_all.deb"
sudo apt install -y ./ulauncher.deb
rm ulauncher.deb
cd -

# Start ulauncher to have it populate config before we overwrite
mkdir -p ~/.config/autostart/
cp ~/.local/share/omakub/configs/ulauncher.desktop ~/.config/autostart/ulauncher.desktop
gtk-launch ulauncher.desktop >/dev/null 2>&1
sleep 2 # ensure enough time for ulauncher to set defaults
cp ~/.local/share/omakub/configs/ulauncher.json ~/.config/ulauncher/settings.json
