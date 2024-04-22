#!/usr/bin/zsh

WINDOWS_HOME='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
LIB_DIRECTORY=$WINDOWS_HOME/Documents/local_script/lib
WORKING_DIRECTORY=$HOME/webdev_repositories_personal/twitch_live_alert
NVM_BIN='/home/mint/.nvm/versions/node/v20.9.0/bin'

# import move window function
source $LIB_DIRECTORY/move_window.sh

zenity --question --text="Do you want to run Google Voice?"
google_voice=$?
zenity --question --text="Do you want to run Twitch Alerts?"
twitch_alerts=$?

# run firefox and discord
nohup firefox \
    -new-window https://discord.com/channels/@me \
    -private-window \
    >/dev/null 2>/dev/null &

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