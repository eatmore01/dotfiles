#!/usr/bin/env bash

set -e

readonly PACMAN_PKGS=(
  telegram-desktop
  firefox
  bitwarden
  neovim
)

readonly YAY_PKGS=(
  #happ-desktop-bin
  obsidian
  amneziavpn-bin
)

echo "Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

echo "Installing AUR packages..."
yay -S --needed --noconfirm --cleanafter --removemake "${YAY_PKGS[@]}"

echo "All packages installed successfully!"
