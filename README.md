# ~/.dotfiles/

This repository contains the configuration files for my Arch Linux + Hyprland system.
This repository follows logical segregation over script complexity principle, all the configs/related data must be arranged in a logical consistent structure and the original path of the config can be disregarded fully.

## Folder Structure

This repository is organized by **Resource Type**, ensuring a clean separation between logic (configs), executables (scripts), and data (assets).

### 1. `config/`
Contains configuration directories that map to `~/.config/` and/or `~/`.
* **Application Configs:** (e.g., `hypr`, `nvim`, `waybar`) are mapped directory-to-directory.
* **System Definitions:** (e.g., `mime`, `user-dirs`) contain loose system files, these are wrapped in logical parent directories to prevent root clutter.
* **Grouped Configs:** Complex setups like `gtk` (which manages both `~/.gtkrc-2.0` and `~/.config/gtk-3.0`) are grouped logically under one folder here.

### 2. `bin/`
Contains custom executable scripts.
* **Strict Override:** This directory **completely replaces** `~/.local/bin`.
* Any script existing locally in `~/.local/bin` that is *not* in this repo will be moved to a backup during setup.

### 3. `assets/`
Contains binary data and media. These files are **copied** (merged), not symlinked, to prevent git bloating and filesystem issues.
* `fonts/`: Custom OTF/TTF fonts (e.g., Anurati). Copied to `~/.local/share/fonts`.
* `pics/`: Any pictures or icons use ANYWHERE in the repo, not copied nor symlinked

## Rules

- **Plugins:** All plugins and themes are installed into `~/.local/share/<app-name>/plugins/` (handled by `setup.sh`), never cloned inside this repo.
- **Package Lists:** `pkglist-native.txt` and `pkglist-foreign.txt` are auto-generated via Pacman hooks to track installed software.
- **History and Hashes:** Any file which stores data as in hashes or history must **NOT** be tracked  

## Setup

1.  **Install Git:**
    ```bash
    sudo pacman -S git
    ```

2.  **Clone the Repository:**
    ```bash
    git clone https://github.com/6carbon12/dotfiles.git ~/.dotfiles
    ```

3.  **Enter Directory:**
    ```bash
    cd ~/.dotfiles
    ```

4.  **Install Packages:**
    ```bash
    ./install.sh
    ```

5.  **Link Configs & Setup Assets:**
    ```bash
    ./setup.sh
    ```
    * *Note: This script will backup existing configurations before overwriting.*
