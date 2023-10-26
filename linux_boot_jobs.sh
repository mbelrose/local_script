#!/usr/bin/zsh

WINDOWS_HOME='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
LIB_DIRECTORY=$WINDOWS_HOME/Documents/local_script/lib
WORKING_DIRECTORY=$HOME/webdev_repositories_personal/twitch_live_alert

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
        -- node server/TwitchLiveAlert.js
fi

# run discord
nohup /usr/share/discord/Discord \
    >/dev/null 2>/dev/null &

# run elemet for matrix
nohup /opt/Element/element-desktop %U \
    >/dev/null 2>/dev/null &

# run google voice
if [ $google_voice -eq 0 ]; then
    nohup firefox -new-window https://voice.google.com/u/0/messages \
        >/dev/null 2>/dev/null &
fi

# clear thumbnails
trash-put /home/mint/.cache/thumbnails/ \
    >/dev/null 2>/dev/null &

# run Freetube youtube client
nohup /opt/FreeTube/freetube %U \
    >/dev/null 2>/dev/null &

# initialize firefox
nohup firefox -private-window >/dev/null 2>/dev/null &

# change wallpaper
nohup /usr/bin/variety --profile /home/mint/.config/variety/ \
    >/dev/null 2>/dev/null &

move_window "Break Reminder" 1
move_window "Twitch Live Alert" 1
move_window "Element" 1
move_window "Voice" 1
move_window "Discord" 1
# discord opens two windows out of sync
nohup $(sleep 600 && move_window "Discord" 1)  \
    >/dev/null 2>/dev/null &

# switch to main desktop in case got pulled
wmctrl -s 0
