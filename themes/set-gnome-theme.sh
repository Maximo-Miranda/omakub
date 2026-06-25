#!/bin/bash

set_gnome_if_available() {
  local schema="$1"
  local key="$2"
  local value="$3"

  if gsettings writable "$schema" "$key" >/dev/null 2>&1; then
    gsettings set "$schema" "$key" "$value"
  fi
}

reset_gnome_if_available() {
  local schema="$1"
  local key="$2"

  if gsettings writable "$schema" "$key" >/dev/null 2>&1; then
    gsettings reset "$schema" "$key" || true
  fi
}

is_debian() {
  [ -r /etc/os-release ] && . /etc/os-release && [ "${ID:-}" = "debian" ]
}

gtk_theme="Yaru-$OMAKUB_THEME_COLOR-dark"
if [ ! -d "/usr/share/themes/$gtk_theme" ]; then
  if [ -d "/usr/share/themes/Yaru-dark" ]; then
    gtk_theme="Yaru-dark"
  else
    gtk_theme=""
  fi
fi

# Debian's Yaru package ships accent index themes but relies on symbolic folder
# icons, which makes Nautilus' large home-folder icons look monochrome. Keep
# normal GNOME/Adwaita folder icons on Debian while retaining Omakub's dark mode
# and wallpaper. Ubuntu keeps the original Yaru accent icon theme.
if is_debian && [ -f /usr/share/icons/Adwaita/index.theme ]; then
  icon_theme="Adwaita"
else
  icon_theme="Yaru-$OMAKUB_THEME_COLOR"
  [ -f "/usr/share/icons/$icon_theme/index.theme" ] || icon_theme="Yaru"
  [ -f "/usr/share/icons/$icon_theme/index.theme" ] || icon_theme="Adwaita"
fi

cursor_theme="Yaru"
[ -f "/usr/share/icons/$cursor_theme/index.theme" ] || cursor_theme="Adwaita"

set_gnome_if_available org.gnome.desktop.interface color-scheme 'prefer-dark'
set_gnome_if_available org.gnome.desktop.interface cursor-theme "$cursor_theme"
set_gnome_if_available org.gnome.desktop.interface icon-theme "$icon_theme"
set_gnome_if_available org.gnome.desktop.interface accent-color "$OMAKUB_THEME_COLOR" 2>/dev/null || true

if [ -n "$gtk_theme" ]; then
  set_gnome_if_available org.gnome.desktop.interface gtk-theme "$gtk_theme"
else
  reset_gnome_if_available org.gnome.desktop.interface gtk-theme
fi

BACKGROUND_ORG_PATH="$HOME/.local/share/omakub/themes/$OMAKUB_THEME_BACKGROUND"
BACKGROUND_DEST_DIR="$HOME/.local/share/backgrounds"
BACKGROUND_DEST_PATH="$BACKGROUND_DEST_DIR/$(echo $OMAKUB_THEME_BACKGROUND | tr '/' '-')"

if [ ! -d "$BACKGROUND_DEST_DIR" ]; then mkdir -p "$BACKGROUND_DEST_DIR"; fi

[ ! -f "$BACKGROUND_DEST_PATH" ] && cp "$BACKGROUND_ORG_PATH" "$BACKGROUND_DEST_PATH"
gsettings set org.gnome.desktop.background picture-uri "$BACKGROUND_DEST_PATH"
gsettings set org.gnome.desktop.background picture-uri-dark "$BACKGROUND_DEST_PATH"
gsettings set org.gnome.desktop.background picture-options 'zoom'
