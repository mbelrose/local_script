#!/usr/bin/zsh

WINDOWS_HOME='/mnt/8cba077b-050c-47b9-9e82-8c8b0730ca1e'
LIB_DIRECTORY=$WINDOWS_HOME/Documents/local_script/lib
WORKING_DIRECTORY=$HOME/opt/twitch_live_alert
NVM_BIN='/home/mint/.nvm/versions/node/v21.7.3/bin'

# import move window function
source $LIB_DIRECTORY/move_window.sh

zenity --question --text="Do you want to run Google Voice?"
google_voice=$?
zenity --question --text="Do you want to run Twitch Alerts?"
twitch_alerts=$?

# break reminder
gnome-terminal --title "Break Reminder" \
    -- $WINDOWS_HOME/Documents/local_script/break_reminder.sh

# run twitch alerts
if [ $twitch_alerts -eq 0 ]; then
    gnome-terminal --title "Twitch Live Alert" \
        --working-directory $WORKING_DIRECTORY \
        -- $NVM_BIN/node server/TwitchLiveAlert.js
fi

# run discord
nohup /usr/share/discord/Discord \
    >/dev/null 2>/dev/null &

# run elemet for matrix
nohup /opt/Element/element-desktop %U \
    >/dev/null 2>/dev/null &

if [ $google_voice -eq 0 ]; then
    # run google voice
    nohup firefox \
        -new-window https://voice.google.com/u/0/messages \
        -private-window \
        >/dev/null 2>/dev/null &
else
    # just run firefox
    nohup firefox \
    -private-window \
    >/dev/null 2>/dev/null &
fi

# clear thumbnails
trash-put /home/mint/.cache/thumbnails/ \
    >/dev/null 2>/dev/null &

# change wallpaper
nohup /usr/bin/variety --profile /home/mint/.config/variety/ \
    >/dev/null 2>/dev/null &

# move windows to second desktop
move_window "Break Reminder" 1
if [ $twitch_alerts -eq 0 ]; then
    move_window "Twitch Live Alert" 1
fi
if [ $google_voice -eq 0 ]; then
    move_window "Voice" 1
fi
move_window "Element" 1
move_window "Discord" 1

# switch to main desktop in case got pulled
wmctrl -s 0