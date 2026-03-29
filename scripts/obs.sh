#!/usr/bin/env bash

readonly PKGS=(
  obs-studio
)

echo "Installing pacman packages..."
sudo pacman -Sy --needed --noconfirm "${PKGS[@]}"
