#!/usr/bin/zsh

# might need to sudo apt install trash-cli to use this

HOME_DIRECTORY='/mnt/8cba077b-050c-47b9-9e82-8c8b0730ca1e'
LIB_DIRECTORY=$HOME_DIRECTORY/Documents/local_script/lib
WORKING_DIRECTORY=$HOME_DIRECTORY/opt/twitch_live_alert
NVM_BIN='/home/mint/.nvm/versions/node/v21.7.3/bin'

# import move window function
source $LIB_DIRECTORY/move_window.sh

zenity --question --text="Do you want to run Google Voice?"
google_voice=$?
zenity --question --text="Do you want to run Twitch Alerts?"
twitch_alerts=$?

# run firefox
nohup firefox \
    -private-window \
    >/dev/null 2>/dev/null &

# run discord
nohup /usr/bin/flatpak \
    run --branch=stable --arch=x86_64 \
    --command=com.discordapp.Discord com.discordapp.Discord \
    >/dev/null 2>/dev/null &

# break reminder
gnome-terminal --title "Break Reminder" \
    -- $HOME_DIRECTORY/Documents/local_script/break_reminder.sh

# run twitch alerts
if [ $twitch_alerts -eq 0 ]; then
    gnome-terminal --title "Twitch Live Alert" \
        --working-directory $WORKING_DIRECTORY \
        -- $NVM_BIN/node server/TwitchLiveAlert.js
fi

if [ $google_voice -eq 0 ]; then
    # run google voice
    nohup firefox \
        -new-window https://voice.google.com/u/0/messages \
        >/dev/null 2>/dev/null &
fi

# Signal messenger
nohup /opt/Signal/signal-desktop \
    --no-sandbox %U \
    >/dev/null 2>/dev/null &


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

move_window "Discord" 1

# switch to main desktop in case got pulled
wmctrl -s 0