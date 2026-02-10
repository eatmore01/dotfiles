#!/usr/bin/env bash

set -euo pipefail

# readonly make variable immutable during script execution
readonly GREEN='\033[0;32m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(dirname "$SCRIPT_DIR")"
readonly CONFIG_SOURCE="$REPO_ROOT/.config"
readonly CONFIG_TARGET="$HOME/.config"
readonly ROOT_CONFIG_SOURCE="$REPO_ROOT"

readonly CONFIGS=(
  "sway"
  "i3status-rust"
  "alacritty"
  "nvim"
  "tofi"
  #  "i3"
  #  "ghostty"
)

readonly ROOT_CONFIGS=(
  ".zshrc"
  ".terraformrc"
  ".vimrc"
)

print_success() {
  echo -e "${GREEN}✓${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1" >&2
}

sync_config() {
  local config_name="$1"
  local source="$CONFIG_SOURCE/$config_name"
  local target="$CONFIG_TARGET/$config_name"

  if [[ ! -d "$source" ]]; then
    print_error "Source directory not found: $source"
    return 1
  fi

  mkdir -p "$CONFIG_TARGET"

  if [[ -e "$target" ]]; then
    local backup="$target.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$target" "$backup"
    print_success "Backed up existing $config_name to: $backup"
  fi

  cp -r "$source" "$target"
  print_success "Synced $config_name"
}

sync_root_config() {
  local config_name="$1"
  local source="$ROOT_CONFIG_SOURCE/$config_name"
  local target="$HOME/$config_name"

  if [[ ! -f "$source" ]]; then
    print_error "Source file not found: $source"
    return 1
  fi

  if [[ -e "$target" ]]; then
    local backup="$target.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$target" "$backup"
    print_success "Backed up existing $config_name to: $backup"
  fi

  cp "$source" "$target"
  print_success "Synced $config_name"
}

main() {
  echo "Starting dotfiles sync..."
  echo "Repository root: $REPO_ROOT"
  echo ""

  local failed=0

  # Sync .config directories
  echo "Syncing .config directories..."
  for config in "${CONFIGS[@]}"; do
    if ! sync_config "$config"; then
      ((failed++))
    fi
  done

  echo ""
  echo "Syncing root config files..."

  # Sync root config files
  for config in "${ROOT_CONFIGS[@]}"; do
    if ! sync_root_config "$config"; then
      ((failed++))
    fi
  done

  echo ""
  if [[ $failed -eq 0 ]]; then
    print_success "All configurations synced successfully!"
  else
    print_error "Failed to sync $failed configuration(s)"
    exit 1
  fi
}

main "$@"
