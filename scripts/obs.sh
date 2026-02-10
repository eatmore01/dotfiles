#!/usr/bin/env bash

readonly PKGS=(
  obs-studio xdg-desktop-portal xdg-desktop-portal-wlr
)

echo "Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${PKGS[@]}"
