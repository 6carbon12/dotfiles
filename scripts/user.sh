#!/usr/bin/env bash
set -eu

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"

declare -A DOTFILES_MAP=(
  # -- Directories in ~/.config
  [alacritty]="$DOTFILES_DIR/config/alacritty"
  [btop]="$DOTFILES_DIR/config/btop"
  [clipse]="$DOTFILES_DIR/config/clipse"
  [eww]="$DOTFILES_DIR/config/eww"
  [fastfetch]="$DOTFILES_DIR/config/fastfetch"
  [fuzzel]="$DOTFILES_DIR/config/fuzzel"
  [gtk-3.0]="$DOTFILES_DIR/config/gtk/gtk-3.0"
  [hypr]="$DOTFILES_DIR/config/hypr"
  [kitty]="$DOTFILES_DIR/config/kitty"
  [Kvantum]="$DOTFILES_DIR/config/Kvantum"
  [mako]="$DOTFILES_DIR/config/mako"
  [nvim]="$DOTFILES_DIR/config/nvim"
  [qpdfview]="$DOTFILES_DIR/config/qpdfview"
  [qt6ct]="$DOTFILES_DIR/config/qt6ct"
  [tmux]="$DOTFILES_DIR/config/tmux"
  [walker]="$DOTFILES_DIR/config/walker"
  [waybar]="$DOTFILES_DIR/config/waybar"
  [wofi]="$DOTFILES_DIR/config/wofi"
  [yazi]="$DOTFILES_DIR/config/yazi"
  [zsh]="$DOTFILES_DIR/config/zsh"
  # --- Loose Files in ~/.config
  [mimeapps.list]="$DOTFILES_DIR/config/mime/mimeapps.list"
  [pavucontrol.ini]="$DOTFILES_DIR/config/pavucontrol/pavucontrol.ini"
  [user-dirs.conf]="$DOTFILES_DIR/config/user-dirs/user-dirs.conf"
  [user-dirs.dirs]="$DOTFILES_DIR/config/user-dirs/user-dirs.dirs"
  [user-dirs.locale]="$DOTFILES_DIR/config/user-dirs/user-dirs.locale"
)

declare -A ROOT_DOTFILES_MAP=(
  [.gitconfig]="$DOTFILES_DIR/config/git/.gitconfig"
  [.gitignore]="$DOTFILES_DIR/config/git/.gitignore"
  [.gtkrc-2.0]="$DOTFILES_DIR/config/gtk/.gtkrc-2.0"
  [.p10k.zsh]="$DOTFILES_DIR/config/zsh/.p10k.zsh"
  [.zshrc]="$DOTFILES_DIR/config/zsh/.zshrc"
  [.zprofile]="$DOTFILES_DIR/config/zsh/.zprofile"
)

backup_and_link() {
  local src="$1"
  local dest="$2"

  # If correct symlink exists, skip
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "  Skipping $dest (already linked)"
    return
  fi

  # Backup existing file
  if [[ -e "$dest" || -L "$dest" ]]; then
    mv "$dest" "$dest.bak-$(date +%Y%m%d-%H%M%S)"
    echo "  Backed up existing $dest -> $dest.bak-$(date +%Y%m%d-%H%M%S)"
  fi

  ln -s "$src" "$dest"
  echo "  Linked $dest -> $src"
}

link_dotfiles() {
  echo -e "${YELLOW}[*] Linking dotfiles into ~/.config/${RESET}"
  mkdir -p "$CONFIG_DIR"

  for target in "${!DOTFILES_MAP[@]}"; do
    backup_and_link "${DOTFILES_MAP[$target]}" "$CONFIG_DIR/$target"
  done
}

link_dotfiles_root() {
  echo -e "${YELLOW}[*] Linking root-level dotfiles...${RESET}"
  for target in "${!ROOT_DOTFILES_MAP[@]}"; do
    backup_and_link "${ROOT_DOTFILES_MAP[$target]}" "$HOME/$target"
  done
}

install_plugins() {
  echo -e "${YELLOW}[*] Installing plugins...${RESET}"

  mkdir -p "$HOME/.local/share/tmux/plugins"
  mkdir -p "$HOME/.local/share/zsh/plugins"

  # tpm
  if [[ ! -d "$HOME/.local/share/tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.local/share/tmux/plugins/tpm" || echo "Failed to clone tpm"
  else
    echo "  tpm already exists"
  fi

  # p10k
  if [[ ! -d "$HOME/.local/share/zsh/plugins/p10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.local/share/zsh/plugins/p10k" || echo "Failed to clone p10k"
  else
    echo "  powerlevel10k already exists"
  fi

  # zsh-autosuggestions
  if [[ ! -d "$HOME/.local/share/zsh/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.local/share/zsh/plugins/zsh-autosuggestions" || echo "Failed to clone zsh-autosuggestions"
  else
    echo "  zsh-autosuggestions already exists"
  fi

  # zsh-vi-mode
  if [[ ! -d "$HOME/.local/share/zsh/plugins/zsh-vi-mode" ]]; then
    git clone https://github.com/jeffreytse/zsh-vi-mode.git "$HOME/.local/share/zsh/plugins/zsh-vi-mode" || echo "Failed to clone zsh-vi-mode"
  else
    echo "  zsh-vi-mode already exists"
  fi

  echo "  Installing yazi pkgs"
  ya pkg install > /dev/null

}

finalize() {
  echo -e "${YELLOW}[*] Linking ~/.local/bin ${RESET}"
  backup_and_link ~/.dotfiles/bin ~/.local/bin

  echo -e "${YELLOW}[*] Setting up fonts ${RESET}"
  mkdir -p ~/.local/share/fonts/
  cp -r ~/.dotfiles/assets/fonts/* ~/.local/share/fonts/
  fc-cache -f
  echo -e "${GREEN}[*] Fonts loaded ${RESET}"

  echo -e "\n${GREEN}✔ Setup complete!${RESET}"
  echo -e "${YELLOW}Next steps:${RESET}"
  echo -e "1. Open tmux: ${GREEN}tmux${RESET}"
  echo -e "2. Press ${GREEN}Ctrl + Space, then I${RESET} (capital i) to install tmux plugins."
}

# --- Main ---
# Setup git filters
git config filter.qpdf-scrubber.clean "sed -E '/^(openPath|recentlyUsed|state|geometry|currentTabIndex|scaleFactor|rotation|.*DialogSize)=/d'"
link_dotfiles
link_dotfiles_root
install_plugins
finalize
