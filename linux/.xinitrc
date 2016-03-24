#!/usr/bin/env bash

#
# ~/.xinitrc
#
# Executed by startx

log () {
    echo "mblin: $1"
}

# add and use display mode 1600x900
#xrandr --newmode "1600x900"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
#xrandr --addmode eDP1 1600x900
# xrandr --output eDP1 --mode 1600x900 --primary

# log "display mode 1600x900"

$HOME/bin/mb-monitor-toggle &

### ---------------

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
        log "running file $f"
    done
    unset f
fi

# start polkit agent to ask for password when GUI soft needs root access
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
# for gnome keyring daemon
export SSH_AUTH_SOCK
log "started Gnome keyring"

start-pulseaudio-x11
log "started PulseAudio"

xbindkeys &
log "loaded keybindings"

# disable touchpad
synclient TouchpadOff=1

# update x resources db
xrdb -merge $HOME/.Xresources

# set cursor
xsetroot -cursor_name left_ptr

# autodetect connected monitor
srandrd mb-monitor-toggle

# enable auto screenlock
xautolock -time 15 -locker "mb-lock-screen" &

nitrogen --restore

# disable mouse clicks for 2 seconds if typing
#syndaemon -t -k -i 2 -d
#log "started synaptics daemon"

# compton -b &

kupfer --no-splash &

# redshift-gtk &
redshift & # start without UI

unclutter -idle 3 -jitter 5 -noevents -root &

kbdd -n &

#conky -c $home/.config/conkyrc &

# dpms monitor setting (standby -> suspend -> off) (seconds)
# xset dpms 300 600 900 &

# set keyboard layout
# switch layout on right control
# use caps lock led on layout change
# bind escape to caps lock
# setxkbmap -layout 'us,ua' -option 'grp:rctrl_toggle,grp_led:caps,caps:escape'

#wmname lg3d
#xflux -l 49.82 -g 24.05
#dex -ave gnome

# without DBUS_SESSION_BUS_ADDRESS terminal started
# from emacs can't communicate with gnome keyring daemon
systemctl --user import-environment PATH SSH_AUTH_SOCK HOME DBUS_SESSION_BUS_ADDRESS GOPATH
systemctl --user start emacs &

log "starting i3 wm"
exec i3

log "stopping i3 wm"


#shutdown
pkill kbdd && sleep 1
pkill kupfer

for win in $(wmctrl -l | awk '{print $1}'); do
    wmctrl -i -c $win
done

wait
log "killed child processes"
