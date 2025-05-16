# ~/.dotfiles/ 

This is all the configured config file in my home directory. The configs are divided into 3 categories. Only config files in `~/.config` and `~/` are included.
Most are from `~/.config`

## Folder Structure

### cli

All applications with a command line interface or a TUI are placed here

### env

Anything that is kinda hardware control, or stuff that controls system activities like `$HOME/` generation by xdg or also could be where environment vars to lauch a specific app might be in here

### gui

All things with a gui that dont't fall in env are here, most everyday use app configs are here.

## Linking

- No folders except the above three in the root. There must be no stray files in either root or any of the categories. If mutiple versions of an app generate different configs they must be grouped under a folder.
- The structure of the config files in `$HOME/` can be ignored if there is a better structure which is more catagorizing and intuvitaive
- Scripts used by applications and scripts meant to replace the applications by making them better/custom must be saved under the applications' respective folder

## Setup 

DO THIS ONLY AFTER LINKING
Plugins with repos inside of them are ignored. So some plugins must be installed manually

### tmux

After linking run

```
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Then `C-Space`+`I` to install all the plugins when inside a tmux session 

### zsh

I think I won't get more plugins for zsh so I will manually install p10k and autosuggestion

#### p10k

```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
```

#### zsh-autosuggestion

```
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
```

## Current Folder structure

Generated with `eza -TaL 2`

```
.
├── cli
│   ├── alacritty
│   ├── btop
│   ├── clipse
│   ├── fastfetch
│   ├── git
│   ├── kitty
│   ├── nvim
│   ├── tmux
│   ├── yazi
│   └── zsh
├── env
│   ├── mimeapps.list
│   ├── pavucontrol.ini
│   ├── pulse
│   ├── systemd
│   ├── user-dirs.conf
│   ├── user-dirs.dirs
│   └── user-dirs.locale
├── gui
│   ├── dconf
│   ├── fuzzel
│   ├── gtk
│   ├── hypr
│   ├── menus
│   ├── qt
│   ├── spotify
│   ├── vlc
│   ├── waybar
│   └── xsettingsd
└── README.md
```


