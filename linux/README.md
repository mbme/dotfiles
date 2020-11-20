# settings
* locale en_GB.UTF-8 cause week starts from Monday not from Sunday like in en_US.UTF-8
* set KillUserProcesses=yes in /etc/systemd/logind.conf to kill user processes on logout

# tools
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
* blueman - bluetooth
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
* libpipewire02, xdg-desktop-portal-wlr - for screensharing

# UI
* nordic - dark GTK3 theme
* adwaita - light GTK3 theme
* papirus - icon theme
* simple-and-soft - cursor theme
* JetBrains Mono - monospace font 

# Installation steps

## Install Arch
* install network manager
* use locale en_GB.UTF-8 (so that week starts in Monday)
* enable multilib in pacman conf
* enable color output in pacman conf

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
* install pulseaudio 

* firefox
* thunderbird
* liferea
* chromium
* transmission

* slack
* skype
* google chrome
