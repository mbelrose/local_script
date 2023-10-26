#!/usr/bin/zsh

# this script will not run from the "source" command on some platforms
LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/platform_config.sh"

platform_config

# import move window function
source $LIBRARY_DIR/move_window.sh

if [[ $# -eq 0 ]]
then
    echo 'Enter streamer id:'
    read streamer_id
else
    streamer_id=$1
fi

streamer_id=$(echo $streamer_id | awk -F/ '{print $NF}')
streamer_id=$(echo $streamer_id | sed 's/[^[:alnum:]_\?=]//g')

if [[ "$(uname -o)" == 'Android' ]]
then
    zsh -c "$PLAYER_COMMAND $(yt-dlp -f "480p,480p30" -g https://twitch.tv/$streamer_id)"
else
    gnome-terminal --title "Streamlink" \
        --working-directory $HOME_DIR \
        -- $PLAYER_COMMAND $(yt-dlp -f "480p,480p30" -g https://twitch.tv/$streamer_id)
    move_window "Streamlink" 1
fi
