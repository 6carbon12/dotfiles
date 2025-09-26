#!/usr/bin/env bash

set -eu

# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

# Groups
CORE_PACKAGES=(hyprland hyprpaper hypridle hyprlock wl-clipboard waybar wofi grim slurp mako brightnessctl clipse kitty neovim tmux zsh btop yazi pulsemixer)
FONTS=(ttf-jetbrains-mono-nerd woff2-font-awesome noto-fonts)
MISC_PACKAGES=(fd ripgrep fzf bat eza fastfetch firefox mpv emote nordzy-hyprcursors)

check_arch() {
  if ! grep -qi "arch" /etc/os-release; then
    echo -e "${RED}✖ This script is only for Arch-based distros!${RESET}"
    exit 1
  fi
}

install_yay() {
  if ! command -v yay &>/dev/null; then
    echo -e "${YELLOW}[*] Installing yay...${RESET}"
    sudo pacman -S --noconfirm --needed base-devel git > /dev/null
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir" > /dev/null
    (cd "$tmpdir" && makepkg -si --noconfirm > /dev/null)
    rm -rf "$tmpdir"
  else
    echo -e "${GREEN}[*] yay is already installed.${RESET}"
  fi
}

install_packages() {
  local packages=("$@")
  FAILED_PKGS=()

  for pkg in "${packages[@]}"; do
    echo -e "${YELLOW}>>> Installing $pkg...${RESET}"
    if yay -S --noconfirm --needed "$pkg" > /dev/null; then
      echo $?
      echo -e "${GREEN}✔ Finished installing $pkg${RESET}"
    else
      echo -e "${RED}⚠ Failed to install $pkg${RESET}"
      FAILED_PKGS+=("$pkg")
    fi
  done

  if [[ ${#FAILED_PKGS[@]} -gt 0 ]]; then
    echo -e "\n${RED}⚠ The following packages failed to install: ${FAILED_PKGS[*]}${RESET}"
  fi
}

uninstall_all() {
  echo -e "${YELLOW}[*] Removing all packages (all groups)...${RESET}"
  yay -Rns --noconfirm "${CORE_PACKAGES[@]}" "${WM_PACKAGES[@]}" "${TERM_PACKAGES[@]}" "${MISC_PACKAGES[@]}" || true
}

# --- Main ---

check_arch

if [[ "${1:-}" == "--clean" ]]; then
  uninstall_all
  exit 0
fi

install_yay
echo -e "\n${YELLOW}Installing Core packages${RESET}"
install_packages "${CORE_PACKAGES[@]}"
echo -e "\n${YELLOW}Installed Core packages${RESET}"

echo -e "\n${YELLOW}Installing FONTS${RESET}"
install_packages "${FONTS[@]}"
echo -e "\n${YELLOW}Installed FONTS${RESET}"

echo -e "\n${YELLOW}3️⃣ Install Misc / Extras (Firefox, zoxide, fd etc.)? (y/N)${RESET}"
read -rp "" ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
  install_packages "${MISC_PACKAGES[@]}"
else
  echo -e "${GREEN}Skipping Misc group.${RESET}"
fi

