#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

log INFO "Restoring GNOME background images..."
if_not_dry find "$DOTFILES/gnome-files/backgrounds" -type f -exec cp -a {} "$HOME/.local/share/backgrounds/" \; >/dev/null

log INFO "Setting wallpaper..."
gsettings set org.gnome.desktop.background picture-uri "file://$HOME/.local/share/backgrounds/Northern_lights_by_matthieugo.png"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/.local/share/backgrounds/Northern_lights_by_matthieugo.png"
gsettings set org.gnome.desktop.background picture-options 'zoom'

log INFO "Loading GNOME config..."
if_not_dry dconf load / <"$DOTFILES/gnome-files/gnome.dconf"

log OK "GNOME setup complete!\n"
