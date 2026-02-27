#!/usr/bin/env bash

set -e

readonly PACMAN_PKGS=(
  telegram-desktop
  firefox
  bitwarden
  neovim
  nodejs
  npm
  obsidian
)

# node and npm for correct scheme selector and mapper work

readonly YAY_PKGS=(
  amneziavpn-bin
)

echo "Installing pacman packages..."
sudo pacman -Sy --needed --noconfirm "${PACMAN_PKGS[@]}"

echo "Installing AUR packages..."
yay -Sy --needed --noconfirm --cleanafter --removemake "${YAY_PKGS[@]}"

echo "All packages installed successfully!"
