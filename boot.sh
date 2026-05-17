#!/bin/bash

set -e

ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

echo -e "$ascii_art"
echo "=> Omakub Debian is for fresh Debian 13 (Trixie) GNOME installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning Omakub..."
rm -rf ~/.local/share/omakub
git clone "${OMAKUB_REPO:-https://github.com/Maximo-Miranda/omakub.git}" ~/.local/share/omakub >/dev/null
if [[ ${OMAKUB_REF:-debian-13} != "master" ]]; then
	cd ~/.local/share/omakub
	git fetch origin "${OMAKUB_REF:-debian-13}" && git checkout "${OMAKUB_REF:-debian-13}"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/omakub/install.sh
