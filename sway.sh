#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_PATH="$SCRIPT_DIR/scripts"

if ! command -v yay &>/dev/null; then
  echo "yay not found. Installing yay..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/yay
fi

echo "Running package installation scripts..."
bash "$SCRIPTS_PATH/00-pkgs.sh"
bash "$SCRIPTS_PATH/devops-utils.sh"
bash "$SCRIPTS_PATH/user-pkgs.sh"

if [ -z "$SKIP_OBS" ]; then
  read -p "Do you want to install OBS? (y/n): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$SCRIPTS_PATH/obs.sh"
  fi
else
  echo "Skipping OBS installation (SKIP_OBS is set)"
fi

# if [ -z "$SKIP_OBS" ]; then
#   read -p "Do you want to install OBS? (y/n): " -n 1 -r
#   echo
#   if [[ $REPLY =~ ^[Yy]$ ]]; then
#     bash "$SCRIPTS_PATH/obs.sh"
#   fi
# else
#   echo "Skipping OBS installation (SKIP_OBS is set)"
# fi
#
#
# zsh setup
echo "Setting up zsh..."
yay -S --needed --noconfirm zsh

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
  echo "Default shell changed to zsh. Please log out and log back in."
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Git config
echo "Configuring git..."
git config --global user.email "etm@etm.com"
git config --global user.name "eatmore01"

echo "Dotfiles setup ..."

if [ -f "$SCRIPTS_PATH/dotfiles.sh" ]; then
  bash "$SCRIPTS_PATH/dotfiles.sh"
fi

echo "Setup completed successfully!"
