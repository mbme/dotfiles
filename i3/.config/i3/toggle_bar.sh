#!/bin/bash

DIR="$HOME/.config/i3"
STATE_FILE=$DIR/bar_state

function write_mode {
    touch $STATE_FILE
    echo "$1" > $STATE_FILE
}

function set_mode {
    i3-msg bar mode $1 1>/dev/null
    write_mode $1
}

case "$1" in
toggle)
    state="$(cat $STATE_FILE)"
    case "$state" in
        invisible)
            set_mode dock
        ;;
        dock)
            set_mode invisible
        ;;
        *)
            echo "Bad bar mode in file: $state"
            set_mode dock
        ;;
    esac
;;
clear)
    write_mode invisible
;;
*)
    echo "Accepted arguments are: toggle and clear."
    exit 1
;;
esac

exit 0
