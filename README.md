# ~/.dotfiles/ 

This is all the important config files in my home directory. The configs are divided into 3 categories. Only config files in `~/.config` and `~/` are included--
the majotiry from `~/.config`  
Any file which stores data as in hashes or history mut **NOT** be tracked  
Any app that has minimal configuratin need not be tracked, except in some cases

## Folder Structure

### cli

All applications with a command line interface or a TUI are placed here

### env

Anything that is controlling any hardware, or files that controls system activities like `$HOME/` generation by xdg or also could be where environment vars to launch a specific app might be in here

### gui

All things with a gui that don't fall in env are here, most everyday use app configs are here.


## Setup 


### Linking

- No folders except the above three in the root
- There must be no stray config files in either root or any of the categories(except env)
- If multiple versions of an app generate different configs they must be grouped under a folder
- The structure of the config files in `$HOME/` can be ignored if there is a better structure which is more categorizing and intuitive
- Scripts used by applications and scripts meant to replace the applications by making them better/custom must be saved under the applications' respective folder
- All plugins, themes must be cloned into `~/.local/share/<app-name>/plugins/`  
- No external repo should be cloned into  `~/.dotfiles/`

### Plugins

⚠️**DO THIS ONLY AFTER LINKING**  
Plugins with repos inside of them are ignored. So some plugins must be installed manually

#### tmux

After linking run

```
git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
```

Then `C-Space`+`I` to install all the plugins when inside a tmux session 

#### zsh

Due to minimal plugins in zsh, a plugin manager is ommited and the needed plugins are manually cloned

##### p10k

```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/plugins/p10k
```

##### zsh-autosuggestion

```
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.local/share/zsh/plugins/zsh-autosuggestions
```

## Current Folder structure

Generated with `eza -TL 1`

```
cli
├── alacritty
├── btop
├── clipse
├── fastfetch
├── git
├── kitty
├── nvim
├── tmux
├── yazi
└── zsh
env
├── mimeapps.list
├── pavucontrol.ini
├── user-dirs.conf
├── user-dirs.dirs
└── user-dirs.locale
gui
├── fuzzel
├── gtk
├── hypr
├── mako
├── qt
├── waybar
└── xsettingsd
README.md
```



