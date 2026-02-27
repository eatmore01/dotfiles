#!/usr/bin/env bash

set -e

readonly PACMAN_PKGS=(
  kubectl
  terraform
  k9s
  helm
  kubectx
  terragrunt
)

readonly YAY_PKGS=(
)

echo "Installing pacman packages..."
sudo pacman -Sy --needed --noconfirm "${PACMAN_PKGS[@]}"

echo "Installing AUR packages..."
yay -Sy --needed --noconfirm --cleanafter --removemake "${YAY_PKGS[@]}"

echo "Building kubeswitches..."
TEMP_DIR=$(mktemp -d)
git clone https://github.com/eatmore01/kubeswitches.git "$TEMP_DIR/kubeswitches"
cd "$TEMP_DIR/kubeswitches"
go build -o kubeswitches main.go
sudo mv kubeswitches /usr/local/bin/
cd -
rm -rf "$TEMP_DIR"

echo "All packages and tools installed successfully!"

echo "Mkdir dir for KUBESWITCHES contexts ~/.kube/all-configs"

mkdir -p ~/.kube/all-configs

echo "Crreated success"
