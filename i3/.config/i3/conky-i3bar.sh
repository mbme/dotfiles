#!/bin/bash

# Send the header so that i3bar knows we want to use JSON:
echo '{"version":1}'

# Begin the endless array.
echo '['

# We send an empty first array of blocks to make the loop simpler:
echo '[],'

primary_config=conkyrc
secondary_config=conkyrc2

declare config
if [ "$1" = "primary" ]; then
    config="$primary_config"
else
    config="$secondary_config"
fi

# Now send blocks with information forever:
current_dir=$( cd "$(dirname "$0")" ; pwd -P )
exec conky -c "$current_dir"/"$config"
