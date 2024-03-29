#!/usr/bin/zsh

# this script will not run from the "source" command on some platforms
LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/platform_config.sh"

platform_config

# import move window function
source $LIBRARY_DIR/move_window.sh

echo 'Enter streamer id:'
read streamer_id

streamer_id=$(echo $streamer_id | awk -F/ '{print $NF}')
streamer_id=$(echo $streamer_id | sed 's/[^[:alnum:]_\?=]//g')

if [[ "$(uname -o)" == 'Android' ]]
then
    zsh -c "$PLAYER_COMMAND $(yt-dlp -x -g https://twitch.tv/$streamer_id)"
else
    gnome-terminal --title "Streamlink" \
        --working-directory $HOME_DIR \
        -- $PLAYER_COMMAND $(yt-dlp -x -g https://twitch.tv/$streamer_id)
    move_window "Streamlink" 1
fi
