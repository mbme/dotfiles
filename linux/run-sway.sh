#!/usr/bin/env zsh

export DESKTOP_SESSION=sway
export XDG_CURRENT_DESKTOP=sway
export TERMINAL=alacritty
export BROWSER=firefox

# Wayland
export XDG_SESSION_TYPE=wayland
export CLUTTER_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORM=xcb
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME=qt5ct
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1

export MOZ_DBUS_REMOTE=1 # https://mastransky.wordpress.com/2020/03/16/wayland-x11-how-to-run-firefox-in-mixed-environment/

# GTK2 theme
export GTK2_RC_FILES=/etc/gtk-2.0/gtkrc:$HOME/.gtkrc-2.0

# Use XToolkit in java applications
export AWT_TOOLKIT=XToolkit
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dsun.java2d.xrender=true'

# to disable gtk3 at-spi warnings
export NO_AT_BRIDGE=1

# disable wine adding win soft menu items
export WINEDLLOVERRIDES=winemenubuilder.exe=d

export CARGO_HOME=$HOME/.cargo
export GOPATH=$HOME/.go

export WINIT_HIDPI_FACTOR=1

# PATH
export NPM_BIN="$HOME/.npm-global/bin"
export YARN_BIN="$HOME/.config/yarn/global/node_modules/.bin"
export RUST_BIN="$HOME/.cargo/bin"
export UTILS_BIN="$HOME/bin"
export PATH=$PATH:$UTILS_BIN:$NPM_BIN:$YARN_BIN:$RUST_BIN

# gnome keyring
eval $(gnome-keyring-daemon)
export SSH_AUTH_SOCK

exec systemd-cat -t sway sway
