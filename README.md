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

### 4. `root/`
Contains a copy of real root with config files that have been modified/need to be tracked 
* All files are safely *copied* to root using `scripts/root.sh` (uses `rsync`)
* Any update to root config files must first be done in `root/` then be copied to real root using `scripts/root.sh`
* **Safety**: The `scripts/root.sh` script automatically backs up any existing system files (with a timestamp) before overwriting them.
    * `scripts/clean.sh` script can be used to remove these backup files

### 5. `scripts/`
Contains the automation logic. Unlike `bin/`, these scripts are not added to `$PATH`; they are intended to be executed via the `Makefile`.
* `install.sh`: Installs all necessary packages
* `user.sh`: Non-destructively symlinks the contents of `config/` to `~/.config` and `~/`.
* `root.sh`: Merges the `root/` directory into the system `/` (requires sudo).
* `clean.sh`: Utility to purge timestamped backup files (.bak)

## Rules

- **Plugins:** All plugins and themes are installed into `~/.local/share/<app-name>/plugins/` (handled by `user.sh`), never cloned inside this repo.
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

4. **Run setup:**
    ```bash
    make all
    ```
    * *Note: All script will backup existing configurations before overwriting.*
