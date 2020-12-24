# Installation steps

## Install Arch
* locale en_GB.UTF-8 cause week starts from Monday not from Sunday like in en_US.UTF-8
* install networkmanager dnsmasq
* set KillUserProcesses=yes in /etc/systemd/logind.conf to kill user processes on logout
* enable multilib in pacman conf
* enable color output in pacman conf
* start/enable systemd-timesyncd
* set vm.swappiness=10
* on SSD enable fstrim.timer from util-linux
* install video drivers
* hardware acceleration

## Install basic configs for cli
* install pacman -S --needed base-devel git
* install yay
* mkdir ~/.config/pulse  ~/.local/share/applications 
* install openssh, stow, rustup
* run `rustup default stable`
* install zsh, zsh-completions, starship, powerline-fonts
* install udisks2 to mount usb drives
* use usb drive to copy ssh config & certificates
* clone dotfiles from github
* stow zsh & git; switch user to zsh
* install vim, cd dotfiles/vim; ./install.sh, then stow vim
* stow linux, utils, kdiff etc.
* install and stow emacs
* install just
* clone typed-v and install mb-binutils
* install pulseaudio, pulseaudio bluetooth modules
* if laptop, install tlp and enable service

# Dev tools
* cargo-outdated
* rust-analyzer
* Node.js
* npm
* yarn
* kdiff3
* editorconfig
* install yarn global typescript typescript-language-server

# Tools
* sway
* swaylock
* swayidle
* waybar, otf-font-awesome
* xwayland
* kanshi - automatically switch display configurations
* wl-clipboard - cli tools for interacting with clipboard
* clipman - clipboard manager
* mako - notification daemon
* light - to control backlight
* nnn - file manager
* ripgrep - search in files
* jq - filter json
* fd - better "find"
* tokei - count lines of code
* htop
* udisks2 - mount usb drives
* zip
* aspell, en - FIXME switch emacs to hunspell
* hunspell, en_GB
* ntfs-3g
* upower
* polkit-gnome
* gnome-keyring
* libsecret
* xdg-utils
* xrdb
* xhost
* wmname
* xorg-xinput
* imagemagick
* xdg-desktop-portal-wlr - for screensharing (enable pipewire user service) (enable chrome://flags/#enable-webrtc-pipewire-capturer)
* man-db

# Apps
* Firefox - install config from dotfiles
* Thunderbird
* Liferea
* file roller
* Chromium
* transmission
* gparted
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

# UI
* nordic - dark GTK3 theme
* adwaita - light GTK3 theme
* papirus - icon theme
* simple-and-soft - cursor theme
* Fonts: JetBrains Mono, dejavu, droid, noto (including emoji)


## Work
* slack
* skype
* google chrome
