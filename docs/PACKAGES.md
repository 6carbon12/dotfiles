# PACKAGES

## 1. Desktop Core
*Core apps that are needed to have well configured Desktop.*

* **hyprland**: Compositor.
* **hyprpaper**: Wallpaper utility.
* **hypridle**: Idle daemon.
* **hyprlock**: Lock screen.
* **hyprsunset**: Blue light filter.
* **hyprpolkitagent**: GUI authentication agent.
* **ly**: Display manager
* **keyd**: Key remapper
* **zram-generator**: Systemd unit generator for zram devices
* **xorg-xhost**: Lets GUI apps launched with `sudo` to run on user wayland session (used in `exec-once`)
* **waybar**: Status bar.
    * *Requires:* `socat` (for IPC data streaming).
* **eww**: Widget system.
* **mako**: Notification daemon.
* **libnotify**: Notification sending library used by `firefox`
* **wofi**: App launcher.
* **nordzy-hyprcursors**: Cursor theme.
* **brightnessctl**: Backlight control (Main interface).
* **tlp**: Power management

#### Desktop Portals
* **xdg-desktop-portal**: Main desktop portal
* **xdg-desktop-portal-hyprland**: Desktop portal recommended by Hyprland
* **xdg-desktop-portal-gtk**: To fill in stuff not implemented in hyprland backend

#### Theming and Styling
*Packages used to theme other apps.*
* **tokyonight-gtk-theme-git**: Tokyonight theme for GTK apps
* **kvantum**: Qt theme manager
* **qt6ct**: Qt theme putter thingy?
* **papirus-icon-theme**: Main icon theme

## 2. Interactive Shell Environment
*Terminal/Shell stuff.*

#### Base Layers
* **kitty**: Terminal Emulator.
* **zsh**: Interactive Shell.
* **tmux**: Terminal Multiplexer.

#### Must Have Utilities 
*Modern replacements for standard unix tools.*
* **zoxide**: Directory jumping (`cd` replacement).
* **fzf**: Fuzzy finder.
* **eza**: `ls` replacement.
* **bat**: `cat` replacement.
* **ripgrep**: `grep` replacement.
* **fd**: `find` replacement.

#### Non-Essential / Flair
* **btop**: System Monitor (Task Manager).
* **fastfetch**: System info fetcher.

## 4. TUI Frontends
*Self explanatory.*

* **impala**: Wifi management (iwd wrapper).
* **pulsemixer**: Audio control (PulseAudio/PipeWire).

## 5. Desktop Actions
*Specific workflows involving multiple tools.*

#### Screenshot
* **grim**: Backend (Grab pixels).
* **slurp**: Frontend (Select region).

#### Clipboard History
* **clipse**: History UI.
* **wl-clipboard**: Backend.

## 6. Applications 
*Standalone applications for specific tasks.*

* **emote**: Emoji Picker.
* **firefox**: Web Browser.
* **mpv**: Media Player.
* **neovim**: Text editor
    * *Requires:* `fzf`, `ripgrep`, `fd` (used by Telescope plugin)
* **qpdfview**: PDF Viewer.
* **yazi**: File Manager (TUI).
    * *Requires:* **7zip** (for archive preview/extraction).

## 7. Script Dependancies
*Invisible tools used purely by scripts/IPC.*

* **socat**: Used by `eww`/Hyprland IPC scripts.
* **rsync**: Used in `system-setup.sh` and other scripts
* **jq**: Used in `hypr/script/screenshot.sh`

## 8. Assets
* **ttf-jetbrains-mono-nerd**
* **ttf-orbitron**
* **noto-fonts**
