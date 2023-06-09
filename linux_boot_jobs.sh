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
move_window "Break Reminder" 1

# run twitch alerts
if [ $twitch_alerts -eq 0 ]; then
    gnome-terminal --title "Twitch Live Alert" \
        --working-directory $WORKING_DIRECTORY \
        -- node server/TwitchLiveAlert.js
    move_window "Twitch Live Alert" 1
fi

# run discord
nohup chromium --new-window https://discord.com/channels/@me \
    >/dev/null 2>/dev/null &
move_window "Discord" 1

# run elemet for matrix
nohup /usr/bin/flatpak run \
    --branch=stable \
    --arch=x86_64 \
    --command=/app/bin/element \
    --file-forwarding \
    im.riot.Riot @@u %U @@ \
    >/dev/null 2>/dev/null &
move_window "Element" 1

# run google voice
if [ $google_voice -eq 0 ]; then
    nohup chromium --new-window https://voice.google.com/ \
        >/dev/null 2>/dev/null &
    move_window "Voice" 1
fi

# clear thumbnails
trash-put /home/mint/.cache/thumbnails/ \
    >/dev/null 2>/dev/null &

# initialize firefox
nohup firefox -private >/dev/null 2>/dev/null &

# switch to main desktop in case got pulled
wmctrl -s 0

# change wallpaper
nohup /usr/bin/variety --profile /home/mint/.config/variety/ \
    >/dev/null 2>/dev/null &
