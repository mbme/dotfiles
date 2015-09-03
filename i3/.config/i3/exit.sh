#!/bin/sh

zenity --question --text="Do you really want to exit?" --ok-label="Exit" --cancel-label="Cancel" --class="i3-exit"

if [[ "$?" -eq 0 ]]; then
	echo "exit from i3"
	i3-msg exit
else
	echo "exit canceled"
fi
exit 0
