#!/usr/bin/env bash

set -e

readonly PACMAN_CORE_PKGS=(
  alacritty
  vlc
  vlc-plugin-ffmpeg
  nmap
  bind
  wl-clipboard
  nautilus
  trash-cli
  ffmpegthumbnailer
  go
  unzip
)

readonly YAY_CORE_PKGS=(
  tofi
  i3status-rust
)

echo "Installing pacman packages..."
sudo pacman -Sy --needed --noconfirm "${PACMAN_CORE_PKGS[@]}"

if ! command -v yay &>/dev/null; then
  echo "yay not found. Installing yay..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/yay
fi

echo "Installing AUR packages with yay..."
yay -Sy --noconfirm --cleanafter --removemake "${YAY_CORE_PKGS[@]}"

echo "All packages installed successfully!"
