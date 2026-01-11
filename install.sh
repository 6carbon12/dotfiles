#!/usr/bin/env bash
set -euo pipefail

# -----------------------
# Colors
# -----------------------
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

log()     { echo -e "${YELLOW}[*] $*${RESET}"; }
success() { echo -e "${GREEN}✔ $*${RESET}"; }
error()   { echo -e "${RED}✖ $*${RESET}"; }

# -----------------------
# Package Groups
# -----------------------
CORE_PACKAGES=(hyprland hyprpaper hypridle hyprlock hyprsunset hyprpolkitagent xhost wl-clipboard waybar impala socat eww wofi grim slurp mako brightnessctl clipse kitty neovim tmux zsh btop yazi 7zip pulsemixer)
FONTS=(ttf-jetbrains-mono-nerd ttf-orbitron noto-fonts)
MISC_PACKAGES=(fd ripgrep fzf bat eza zoxide fastfetch rsync firefox okular mpv emote nordzy-hyprcursors)

# -----------------------
# Functions
# -----------------------

check_arch() {
  source /etc/os-release
  if [[ "$ID" != "arch" && "$ID_LIKE" != *"arch"* ]]; then
    error "This script is only for Arch-based distributions!"
    exit 1
  fi
  log "Confirmed Arch-based system."
}

install_yay() {
  if ! command -v yay &>/dev/null; then
    log "Installing yay..."
    sudo pacman -S --noconfirm --needed base-devel git
    tmpdir=$(mktemp -d)
    pushd "$tmpdir" > /dev/null
    git clone https://aur.archlinux.org/yay.git .
    makepkg -si --noconfirm
    popd > /dev/null
    rm -rf "$tmpdir"
    success "yay installed."
  else
    success "yay is already installed."
  fi
}

install_packages() {
  local packages=("$@")
  local failed=()

  for pkg in "${packages[@]}"; do
    log "Installing $pkg..."
    if yay -S --needed --noconfirm "$pkg"; then
      success "Installed $pkg"
    else
      error "Failed to install $pkg"
      failed+=("$pkg")
    fi
  done

  if [[ ${#failed[@]} -gt 0 ]]; then
    error "The following packages failed: ${failed[*]}"
  fi
}

uninstall_all() {
  log "Removing all packages..."
  yay -Rns --noconfirm "${CORE_PACKAGES[@]}" "${FONTS[@]}" "${MISC_PACKAGES[@]}" || true
  success "Uninstallation complete."
}

prompt_install_misc() {
  read -rp "Install Misc/Extras (Firefox, fd, etc.)? [y/N]: " ans
  if [[ "$ans" =~ ^[Yy]$ ]]; then
    install_packages "${MISC_PACKAGES[@]}"
  else
    log "Skipping Misc packages."
  fi
}

# -----------------------
# Main
# -----------------------
check_arch

if [[ "${1:-}" == "--clean" ]]; then
  uninstall_all
  exit 0
fi

install_yay

log "Installing Core packages..."
install_packages "${CORE_PACKAGES[@]}"

log "Installing Fonts..."
install_packages "${FONTS[@]}"

prompt_install_misc

success "All done! ✅"
