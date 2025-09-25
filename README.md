# ~/.dotfiles/

This is all the important config files in my home directory. The configs are divided into 3 categories. Only config files in `~/.config` and `~/` are included--
the majority from `~/.config`  
Any file which stores data as in hashes or history must **NOT** be tracked  
Any app that has minimal configuratin need not be tracked, except in some cases

## Folder Structure

### cli

All applications with a command line interface or a TUI are placed here

### env

Anything that is controlling any hardware, or files that controls system activities like `$HOME/` generation by xdg or also could be where environment vars to launch a specific app might be in here

### gui

All things with a gui that don't fall in env are here, most everyday use app configs are here.

## Rules

- No folders except the above three in the root
- There must be no stray config files in either root or any of the categories(except env)
- If multiple versions of an app generate different configs they must be grouped under a folder
- The structure of the config files in `$HOME/` can be ignored if there is a better structure which is more categorizing and intuitive
- Scripts used by applications and scripts meant to replace the applications by making them better/custom must be saved under the applications' respective folder
- All plugins, themes must be cloned into `~/.local/share/<app-name>/plugins/`
- No external repo should be cloned into `~/.dotfiles/`

## Setup

- Install git: <br>
  `sudo pacman -S git`
- Clone this repo: <br>
  `git clone https://github.com/6carbon12/dotfiles.git ~/.dotfiles`
- Go into .dotfiles dir <br>
  `cd .dotfiles`
- Install packages <br>
  `./install.sh`
- Setup the .dotfiles <br>
  `./setup.sh`
