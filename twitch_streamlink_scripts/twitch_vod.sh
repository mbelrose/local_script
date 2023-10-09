#!/usr/bin/zsh

# this script will not run from the "source" command on some platforms
LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/platform_config.sh"

platform_config

# import move window function
source $LIBRARY_DIR/move_window.sh

echo 'Enter vod id:'
read streamer_id
streamer_id=$(echo $streamer_id | awk -F/ '{print $NF}')
streamer_id=$(echo $streamer_id | sed 's/[^[:alnum:]_\?=]//g')
gnome-terminal --title "Streamlink" \
    --working-directory $HOME_DIR \
    -- streamlink https://twitch.tv/videos/$streamer_id
move_window "Streamlink" 1