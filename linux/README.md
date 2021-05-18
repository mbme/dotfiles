# Installation steps

## Install Arch
* locale en_GB.UTF-8 cause week starts from Monday not from Sunday like in en_US.UTF-8
* set KillUserProcesses=yes in /etc/systemd/logind.conf to kill user processes on logout, set HandlePowerKey=suspend, set HandleLidSwitch=lock
* enable multilib in pacman conf
* enable color output in pacman conf
* set vm.swappiness=10
* add kernel parameters: mitigations=off random.trust_cpu=on

* if SSD install util-linux; enable fstrim.timer
* start/enable systemd-timesyncd
* install networkmanager dnsmasq, enable/start NetworkManager.service
* if laptop, install tlp and enable service

* install & configure sudo
* create user, set password
```
# useradd -m -G wheel,video -s /bin/zsh <username>
# passwd <username>
```

## Install basic cli and configs
* install pacman -S --needed base-devel git go vim just
* install yay
* install openssh, stow, rustup, sccache, lld
* install zsh, zsh-completions, starship, powerline-fonts
* install udisks2 to mount usb drives
* htop
* zip
* man-db
* tree
* ntfs-3g
* upower
* downgrade
* aspell, en - FIXME switch emacs to hunspell
* hunspell, en_GB
* use usb drive to copy ssh config & certificates, fix permissions:
```
$ chmod 700 ~/.ssh
$ chmod 600 ~/.ssh/key
```
* clone dotfiles from github
* stow zsh & git; switch user to zsh
* stow vim, cd dotfiles/vim; ./install.sh
* mkdir ~/.config/pulse  ~/.config/systemd/user ~/.local/share/applications ~/.cargo
* stow linux, utils, kdiff3, emacs
* install pulseaudio 

## GUI
* install video drivers
 * Radeon: install mesa, lib32-mesa, vulkan-radeon, lib32-vulkan-radeon
 * radeontop - to monitor radeon graphics card
 * intel-gpu-tools - to monitor intel graphics card
* install greetd
 * copy dotfiles/linux/run-sway.sh into /usr/local/bin/
 * Update `/etc/greetd/config.toml`: `command = "agreety --cmd run-sway.sh"`

## Environment
* sway, ttf-dejavu
* swaylock
* swayidle
* waybar, otf-font-awesome
* xorg-xwayland
* kanshi - automatically switch display configurations
* wl-clipboard - cli tools for interacting with clipboard
* clipman - clipboard manager
* mako - notification daemon
* libnotify
* light - to control backlight
* gnome-keyring
* polkit-gnome
* xorg-xrdb
* xorg-xhost
* wmname
* alacritty - terminal
* safeeyes - break reminder
* gammastep - adjust display color temperature at night
* udiskie - automounter for removable media
* network-manager-applet - network manager applet
* nm-connection-editor, networkmanager-openvpn - network manager ui
* paprefs, pavucontrol - pulseaudio utils
* wofi - command runner
* gsimplecal - calendar
* grim - capture the screenshot
* slurp - select the part of the screen
* wf-recorder - record the screen
* swappy - simple drawing on top of images
* nnn - file manager
* translate-shell - Google Translate

* nordic - dark GTK3 theme
* adwaita (gtk default) - light GTK3 theme
* papirus-icon-theme - icon theme
* xcursor-simpleandsoft - cursor theme
* ttf-jetbrains-mono - JetBrains Mono font
* ttf-droid - Droid font 
* noto-fonts, noto-fonts-emoji, noto-fonts-extra - Noto fonts

* if bluetooth
 * install pulseaudio bluetooth modules
 * install bluez bluez-utils
 * start and enable mpris-proxy user service
 * install blueman - bluetooth manager GUI

* trash-cli
* libsecret
* xdg-utils
* imagemagick
* xdg-desktop-portal-wlr - for screensharing 
  * enable pipewire user service 
  * enable chrome://flags/#enable-webrtc-pipewire-capturer

* run `rustup default stable`
* clone typed-v and install mb-binutils
* for backlight, add user to video group; https://wiki.archlinux.org/index.php/Backlight#ACPI

## Apps
* Firefox - install config from dotfiles
* Thunderbird
* Chromium
* transmission-gtk
* telegram-desktop
* newsboat - rss reader
* file-roller - archive manager
* gparted
* wdisplays-git - display configuration GUI
* zathura, zathura-pdf-mupdf - pdf viewer
* mpv - video player
* imv - image viewer
* youtube-dl - download videos from video hosting services

* slack
* skype
* google chrome


## Dev tools
* ripgrep - search in files
* jq - filter json
* fd - better "find"
* tokei - count lines of code
* emacs
* kdiff3
* cargo-outdated cargo-edit
* rust-analyzer
* Node.js
* npm
* yarn
* editorconfig-core-c
* install yarn global typescript typescript-language-server
* android-tools, android-udev


## Configure hardware acceleration
* video acceleration
  * libva-utils for `vainfo`
  * vdpauinfo
  * VA-API support: libva-mesa-driver, lib32-libva-mesa-driver
  * VDPAU support: mesa-vdpau, lib32-mesa-vdpau
* Gstreamer support - gstreamer-vaapi
* tweak video acceleration settings in firefox config
