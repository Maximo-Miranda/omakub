#!/bin/bash
set -euo pipefail

sudo apt install -y gnome-shell-extension-manager gir1.2-gtop-2.0 gir1.2-clutter-1.0 unzip
pipx install gnome-extensions-cli --system-site-packages || true

# Turn off Ubuntu/Debian default extensions when present. Missing extensions are OK.
gnome-extensions disable tiling-assistant@ubuntu.com || true
gnome-extensions disable ubuntu-appindicators@ubuntu.com || true
gnome-extensions disable ubuntu-dock@ubuntu.com || true
gnome-extensions disable ding@rastersoft.com || true

# Pause to assure user is ready to accept confirmations
gum confirm "To install Gnome extensions, you need to accept some confirmations. Ready?"

install_extension_zip() {
  local uuid="$1"
  local shell_version
  local download_url
  local tmpdir

  shell_version="$(gnome-shell --version | grep -oE '[0-9]+' | head -1)"
  download_url="$(python3 - "$uuid" "$shell_version" <<'PY'
import json, sys, urllib.parse, urllib.request
uuid, shell_version = sys.argv[1], sys.argv[2]
url = "https://extensions.gnome.org/extension-info/?" + urllib.parse.urlencode({"uuid": uuid, "shell_version": shell_version})
with urllib.request.urlopen(url, timeout=30) as response:
    data = json.load(response)
print("https://extensions.gnome.org" + data["download_url"])
PY
)"

  tmpdir="$(mktemp -d)"
  mkdir -p "$HOME/.local/share/gnome-shell/extensions/$uuid"
  wget -qO "$tmpdir/extension.zip" "$download_url"
  rm -rf "$HOME/.local/share/gnome-shell/extensions/$uuid"
  mkdir -p "$HOME/.local/share/gnome-shell/extensions/$uuid"
  unzip -q "$tmpdir/extension.zip" -d "$HOME/.local/share/gnome-shell/extensions/$uuid"
  rm -rf "$tmpdir"
}

# Install new extensions without relying on GNOME Shell's interactive D-Bus remote installer.
# gext/InstallRemoteExtension can timeout in headless, RDP, or first-login environments even
# when the extension zip itself is compatible. Direct zip install is deterministic.
extensions=(
  'tactile@lundal.io'
  'just-perfection-desktop@just-perfection'
  'blur-my-shell@aunetx'
  'space-bar@luchrioh'
  'undecorate@sun.wxg@gmail.com'
  'tophat@fflewddur.github.io'
  'AlphabeticalAppGrid@stuarthayhurst'
)

for extension in "${extensions[@]}"; do
  install_extension_zip "$extension"
done

# Compile gsettings schemas in order to be able to set them
copy_schema() {
  local schema="$1"
  local found
  found="$(find "$HOME/.local/share/gnome-shell/extensions" -path "*/schemas/$schema" -print -quit)"
  if [[ -n "$found" ]]; then
    sudo cp "$found" /usr/share/glib-2.0/schemas/
  fi
}

copy_schema org.gnome.shell.extensions.tactile.gschema.xml
copy_schema org.gnome.shell.extensions.just-perfection.gschema.xml
copy_schema org.gnome.shell.extensions.blur-my-shell.gschema.xml
copy_schema org.gnome.shell.extensions.space-bar.gschema.xml
copy_schema org.gnome.shell.extensions.tophat.gschema.xml
copy_schema org.gnome.shell.extensions.AlphabeticalAppGrid.gschema.xml
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

# Enable extensions by writing GNOME Shell settings directly. This works before the next
# graphical login and avoids requiring a live org.gnome.Shell.Extensions D-Bus service.
python3 - <<'PY'
import subprocess
extensions = [
    'undecorate@sun.wxg@gmail.com',
    'AlphabeticalAppGrid@stuarthayhurst',
    'space-bar@luchrioh',
    'just-perfection-desktop@just-perfection',
    'blur-my-shell@aunetx',
    'tophat@fflewddur.github.io',
    'tactile@lundal.io',
]
value = '[' + ', '.join(repr(extension) for extension in extensions) + ']'
subprocess.run(['gsettings', 'set', 'org.gnome.shell', 'enabled-extensions', value], check=True)
PY

# Configure Tactile
gsettings set org.gnome.shell.extensions.tactile col-0 1
gsettings set org.gnome.shell.extensions.tactile col-1 2
gsettings set org.gnome.shell.extensions.tactile col-2 1
gsettings set org.gnome.shell.extensions.tactile col-3 0
gsettings set org.gnome.shell.extensions.tactile row-0 1
gsettings set org.gnome.shell.extensions.tactile row-1 1
gsettings set org.gnome.shell.extensions.tactile gap-size 32

# Configure Just Perfection
gsettings set org.gnome.shell.extensions.just-perfection animation 2
gsettings set org.gnome.shell.extensions.just-perfection dash-app-running true
gsettings set org.gnome.shell.extensions.just-perfection workspace true
gsettings set org.gnome.shell.extensions.just-perfection workspace-popup false

# Configure Blur My Shell
gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder blur false
gsettings set org.gnome.shell.extensions.blur-my-shell.lockscreen blur false
gsettings set org.gnome.shell.extensions.blur-my-shell.screenshot blur false
gsettings set org.gnome.shell.extensions.blur-my-shell.window-list blur false
gsettings set org.gnome.shell.extensions.blur-my-shell.panel blur false
gsettings set org.gnome.shell.extensions.blur-my-shell.overview blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.overview pipeline 'pipeline_default'
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock brightness 0.6
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock sigma 30
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock static-blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 0

# Configure Space Bar
gsettings set org.gnome.shell.extensions.space-bar.behavior smart-workspace-names false
gsettings set org.gnome.shell.extensions.space-bar.shortcuts enable-activate-workspace-shortcuts false
gsettings set org.gnome.shell.extensions.space-bar.shortcuts enable-move-to-workspace-shortcuts true
gsettings set org.gnome.shell.extensions.space-bar.shortcuts open-menu "@as []"

# Configure TopHat
gsettings set org.gnome.shell.extensions.tophat show-icons false
gsettings set org.gnome.shell.extensions.tophat show-cpu false
gsettings set org.gnome.shell.extensions.tophat show-disk false
gsettings set org.gnome.shell.extensions.tophat show-mem false
gsettings set org.gnome.shell.extensions.tophat show-fs false
gsettings set org.gnome.shell.extensions.tophat network-usage-unit bits

# Configure AlphabeticalAppGrid
gsettings set org.gnome.shell.extensions.alphabetical-app-grid folder-order-position 'end'
