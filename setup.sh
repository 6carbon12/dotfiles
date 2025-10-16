#!/usr/bin/env bash
set -eu

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"
ZSHRC="$HOME/.zshrc"

declare -A DOTFILES_MAP=(
  [alacritty]="$DOTFILES_DIR/cli/alacritty"
  [btop]="$DOTFILES_DIR/cli/btop"
  [clipse]="$DOTFILES_DIR/cli/clipse"
  [fastfetch]="$DOTFILES_DIR/cli/fastfetch"
  [kitty]="$DOTFILES_DIR/cli/kitty"
  [nvim]="$DOTFILES_DIR/cli/nvim"
  [tmux]="$DOTFILES_DIR/cli/tmux"
  [yazi]="$DOTFILES_DIR/cli/yazi"
  [zsh]="$DOTFILES_DIR/cli/zsh"
  [fuzzel]="$DOTFILES_DIR/gui/fuzzel"
  [gtk-3.0]="$DOTFILES_DIR/gui/gtk/gtk-3.0"
  [hypr]="$DOTFILES_DIR/gui/hypr"
  [mako]="$DOTFILES_DIR/gui/mako"
  [walker]="$DOTFILES_DIR/gui/walker"
  [waybar]="$DOTFILES_DIR/gui/waybar"
  [wofi]="$DOTFILES_DIR/gui/wofi"
  [xsettingsd]="$DOTFILES_DIR/gui/xsettingsd"
  [user-dirs.conf]="$DOTFILES_DIR/env/user-dirs.conf"
  [user-dirs.dirs]="$DOTFILES_DIR/env/user-dirs.dirs"
  [user-dirs.locale]="$DOTFILES_DIR/env/user-dirs.locale"
  [mimeapps.list]="$DOTFILES_DIR/env/mimeapps.list"
)

declare -A ROOT_DOTFILES_MAP=(
  [.gitconfig]="$DOTFILES_DIR/cli/git/.gitconfig"
  [.gitignore]="$DOTFILES_DIR/cli/git/.gitignore"
  [.gtkrc-2.0]="$DOTFILES_DIR/gui/gtk/.gtkrc-2.0"
  [.p10k.zsh]="$DOTFILES_DIR/cli/zsh/.p10k.zsh"
  [.zshrc]="$DOTFILES_DIR/cli/zsh/.zshrc"
  [.zprofile]="$DOTFILES_DIR/cli/zsh/.zprofile"
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
    mv "$dest" "$dest.bak"
    echo "  Backed up existing $dest -> $dest.bak"
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
}

finalize() {
  echo -e "${YELLOW}[*] Sourcing zsh config...${RESET}"
  if [[ -f "$ZSHRC" ]]; then
    zsh -c "source $ZSHRC"
  else
    echo "No $ZSHRC found. Skipping."
  fi

  echo -e "\n${GREEN}✔ Setup complete!${RESET}"
  echo -e "${YELLOW}Next steps:${RESET}"
  echo -e "1. Open tmux: ${GREEN}tmux${RESET}"
  echo -e "2. Press ${GREEN}Ctrl + Space, then I${RESET} (capital i) to install tmux plugins."
}

# --- Main ---
link_dotfiles
link_dotfiles_root
install_plugins
finalize
