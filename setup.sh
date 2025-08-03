#!/usr/bin/env bash

set -eu

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"
ZSHRC="$HOME/.zshrc"

# Directories and files to symlink (key = target name in .config, value = source in dotfiles)
declare -A DOTFILES_MAP=(
  [alacritty]="$DOTFILES_DIR/cli/alacritty"
  [btop]="$DOTFILES_DIR/cli/btop"
  [clipse]="$DOTFILES_DIR/cli/clipse"
  [fastfetch]="$DOTFILES_DIR/cli/fastfetch"
  [fuzzel]="$DOTFILES_DIR/gui/fuzzel"
  [gtk-3.0]="$DOTFILES_DIR/gui/gtk/gtk-3.0"
  [hypr]="$DOTFILES_DIR/gui/hypr"
  [kitty]="$DOTFILES_DIR/cli/kitty"
  [mako]="$DOTFILES_DIR/gui/mako"
  [nvim]="$DOTFILES_DIR/cli/nvim"
  [tmux]="$DOTFILES_DIR/cli/tmux"
  [user-dirs.conf]="$DOTFILES_DIR/env/user-dirs.conf"
  [user-dirs.dirs]="$DOTFILES_DIR/env/user-dirs.dirs"
  [user-dirs.locale]="$DOTFILES_DIR/env/user-dirs.locale"
  [waybar]="$DOTFILES_DIR/gui/waybar"
  [xsettingsd]="$DOTFILES_DIR/gui/xsettingsd"
  [yazi]="$DOTFILES_DIR/cli/yazi"
  [zsh]="$DOTFILES_DIR/cli/zsh"
  [mimeapps.list]="$DOTFILES_DIR/env/mimeapps.list"
)

# Root-level dotfiles in $HOME
declare -A ROOT_DOTFILES_MAP=(
  [.gitconfig]="$DOTFILES_DIR/cli/git/.gitconfig"
  [.gitignore]="$DOTFILES_DIR/cli/git/.gitignore"
  [.gtkrc-2.0]="$DOTFILES_DIR/gui/gtk/.gtkrc-2.0"
  [.p10k.zsh]="$DOTFILES_DIR/cli/zsh/.p10k.zsh"
  [.zshrc]="$DOTFILES_DIR/cli/zsh/.zshrc"
  [.zprofile]="$DOTFILES_DIR/cli/zsh/.zprofile"
+)

link_dotfiles() {
  echo -e "${YELLOW}[*] Linking dotfiles into ~/.config/${RESET}"
  mkdir -p "$CONFIG_DIR"

  for target in "${!DOTFILES_MAP[@]}"; do
    src="${DOTFILES_MAP[$target]}"
    dest="$CONFIG_DIR/$target"

    # Remove if already exists and is not the correct symlink
    if [[ -e "$dest" && ! -L "$dest" ]]; then
      echo "  Removing existing $dest"
      rm -rf "$dest"
    fi

    if [[ -L "$dest" ]]; then
      echo "  Skipping $target (already linked)"
    else
      ln -s "$src" "$dest"
      echo "  Linked $target"
    fi
  done
}

install_plugins() {
  echo -e "${YELLOW}[*] Installing plugins...${RESET}"
  mkdir -p "$HOME/.local/share/tmux/plugins" "$HOME/.local/share/zsh/plugins"

  # tpm
  if [[ ! -d "$HOME/.local/share/tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.local/share/tmux/plugins/tpm"
    echo "  Installed tpm"
  else
    echo "  tpm already exists"
  fi

  # p10k
  if [[ ! -d "$HOME/.local/share/zsh/plugins/p10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.local/share/zsh/plugins/p10k"
    echo "  Installed powerlevel10k"
  else
    echo "  powerlevel10k already exists"
  fi

  # zsh-autosuggestions
  if [[ ! -d "$HOME/.local/share/zsh/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.local/share/zsh/plugins/zsh-autosuggestions"
    echo "  Installed zsh-autosuggestions"
  else
    echo "  zsh-autosuggestions already exists"
  fi
}

finalize() {
  echo -e "${YELLOW}[*] Sourcing zsh config...${RESET}"
  if [[ -f "$ZSHRC" ]]; then
    source "$ZSHRC"
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
install_plugins
finalize

