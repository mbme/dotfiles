# Tools
* sway
* swaylock
* swayidle
* waybar
* xwayland
* zsh
* starship
* kanshi - automatically switch display configurations
* wl-clipboard - cli tools for interacting with clipboard
* clipman - clipboard manager
* mako - notification daemon
* light - to control backlight

# apps
* alacritty - terminal
* safeeyes
* gammastep - adjust display color temperature at night
* wdisplays - display configuration GUI
* blueman - bluetooth manager GUI
* udiskie - automounter for removable media
* network-manager-applet - network manager applet
* nm-connection-editor, networkmanager-openvpn - network manager ui
* wofi - command runner
* gsimplecal - calendar
* grim - capture the screenshot
* slurp - select the part of the screen
* wf-recorder - record the screen
* swappy - simple drawing on top of images
* zathura - pdf viewer
* mpv - video player
* imv - image viewer
* youtube-dl - download videos from video hosting services
* paprefs, pavucontrol - pulseaudio utils
* kdiff

# cli tools
* nnn - file manager
* ripgrep - search in files
* jq - filter json
* fd - better "find"
* tokei - count lines of code
* htop
* udisks2 - mount usb drives

# other
* upower
* polkit-gnome
* gnome-keyring
* libsecret
* xdg-utils
* xrdb
* xhost
* wmname
* imagemagick
* aspell, aspell-en - spellchecker
* editorconfig
* libpipewire02, xdg-desktop-portal-wlr - for screensharing (enable pipewire user service) (enable chrome://flags/#enable-webrtc-pipewire-capturer)
* man-db

# UI
* nordic - dark GTK3 theme
* adwaita - light GTK3 theme
* papirus - icon theme
* simple-and-soft - cursor theme
* JetBrains Mono - monospace font 

# Installation steps

## Install Arch
* install network manager
* locale en_GB.UTF-8 cause week starts from Monday not from Sunday like in en_US.UTF-8
* set KillUserProcesses=yes in /etc/systemd/logind.conf to kill user processes on logout
* enable multilib in pacman conf
* enable color output in pacman conf
* start/enable systemd-timesyncd
* set vm.swappiness=10
* on SSD enable fstrim.timer from util-linux

## Install basic configs for cli
* mkdir ~/.config/pulse  ~/.local/share/applications 
* install ssh, git, stow
* install zsh, zsh-completions, starship, powerline-fonts
* install udisks2 to mount usb drives
* use usb drive to copy ssh config & certificates
* clone dotfiles from github
* stow zsh & git
* install vim, run dotfiles/vim/install.sh, then stow vim
* stow linux, utils
* install rest of CLI tools

## Install 
* install video drivers
* hardware acceleration
* install sway, xwayland and other tools
* clone typed-v and install mb-binutils
* install and stow emacs
* install pulseaudio, pulseaudio bluetooth modules

* firefox
* thunderbird
* liferea
* file roller
* chromium
* transmission
* gparted

## Dev
* rustup
* cargo-outdated
* rust-analyzer
* Node.js
* npm
* yarn

* install yarn global typescript typescript-language-server

## Work
* slack
* skype
* google chrome
