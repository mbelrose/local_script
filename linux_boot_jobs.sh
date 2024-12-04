#!/usr/bin/zsh

# might need to sudo apt install trash-cli to use this

HOME_DIRECTORY='/mnt/8cba077b-050c-47b9-9e82-8c8b0730ca1e'
LIB_DIRECTORY=$HOME_DIRECTORY/Documents/local_script/lib
WORKING_DIRECTORY=$HOME_DIRECTORY/opt/twitch_live_alert
NVM_BIN='/home/mint/.nvm/versions/node/v21.7.3/bin'

# import move window function
source $LIB_DIRECTORY/move_window.sh

# query user for what apps to run
zenity --list --checklist \
--title="What do you want to run?" --height=600 --width=600 \
--multiple --print-column=2 --hide-column=2 \
--column=checkbox --column=number --column=label \
TRUE google_voice "Google Voice" \
FALSE twitch_live_alert "Twitch Live Alert" \
FALSE signal_messenger "Signal Messenger" \
| read apps_to_run


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
if [[ $apps_to_run =~ \W?twitch_live_alert\W? ]]; then
    gnome-terminal --title "Twitch Live Alert" \
        --working-directory $WORKING_DIRECTORY \
        -- $NVM_BIN/node server/TwitchLiveAlert.js
fi

# run google voice
if [[ $apps_to_run =~ \W?google_voice\W? ]]; then
    nohup firefox \
        -new-window https://voice.google.com/u/0/messages \
        >/dev/null 2>/dev/null &
fi

# run Signal messenger
if [[ $apps_to_run =~ \W?signal_messenger\W? ]]; then
    nohup /opt/Signal/signal-desktop \
        --no-sandbox %U \
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

move_window "Discord" 1

# switch to main desktop in case got pulled
wmctrl -s 0