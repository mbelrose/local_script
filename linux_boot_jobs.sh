#!/usr/bin/zsh

windows_home='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
working_directory=$HOME/webdev_repositories_personal/twitch_live_alert

zenity --question --text="Do you want to run Discord?"
discord=$?
zenity --question --text="Do you want to run Google Voice?"
google_voice=$?
zenity --question --text="Do you want to run Twitch Alerts?"
twitch_alerts=$?

# break reminder
nohup gnome-terminal --title "Break Reminder" -- $windows_home/Documents/local_script/break_reminder.sh  >/dev/null 2>/dev/null &

# run discord
if [ $discord -eq 0 ]; then
    nohup sleep 30 && chromium https://discord.com/channels/@me >/dev/null 2>/dev/null &
fi

# run google voice
if [ $google_voice -eq 0 ]; then
    nohup sleep 60 && chromium https://voice.google.com/ >/dev/null 2>/dev/null &
fi

# run twitch alerts
if [ $twitch_alerts -eq 0 ]; then
    nohup gnome-terminal --working-directory $working_directory -- node server/TwitchLiveAlert.js  >/dev/null 2>/dev/null &
fi


# clear thumbnails
trash-put /home/mint/.cache/thumbnails/

# change wallpaper
nohup sleep 120 && /usr/bin/variety --profile /home/mint/.config/variety/ >/dev/null 2>/dev/null &