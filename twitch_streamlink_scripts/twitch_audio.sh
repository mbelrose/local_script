#!/usr/bin/zsh

WINDOWS_HOME='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
LIB_DIRECTORY=$WINDOWS_HOME/Documents/local_script/lib
WORKING_DIRECTORY=$HOME/webdev_repositories_personal/twitch_live_alert

# import move window function
source $LIB_DIRECTORY/move_window.sh

echo 'Enter streamer id:'
read streamer_id
streamer_id=$(echo $streamer_id | awk -F/ '{print $NF}')
streamer_id=$(echo $streamer_id | sed 's/[^[:alnum:]_\?=]//g')
gnome-terminal --title "Streamlink" \
    --working-directory $WORKING_DIRECTORY \
    -- streamlink https://twitch.tv/$streamer_id audio_only,audio
move_window "Streamlink" 1