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
nohup wmctrl -s 1 \
&& gnome-terminal --title "Break Reminder" \
-- $windows_home/Documents/local_script/break_reminder.sh \
>/dev/null 2>/dev/null \
&& nohup wmctrl -s 0 &

# run twitch alerts
if [ $twitch_alerts -eq 0 ]; then
    nohup wmctrl -s 1 \
&& gnome-terminal --title "Twitch Live Alert" \
--working-directory $working_directory \
-- node server/TwitchLiveAlert.js  \
>/dev/null 2>/dev/null \
&& nohup wmctrl -s 0 &
fi

# run discord
if [ $discord -eq 0 ]; then
    nohup sleep 1 && wmctrl -s 1 \
&& chromium https://discord.com/channels/@me \
>/dev/null 2>/dev/null \
&& nohup wmctrl -s 0 &
fi

# run google voice
if [ $google_voice -eq 0 ]; then
    nohup sleep 1 && wmctrl -s 1 \
&& chromium https://voice.google.com/ \
>/dev/null 2>/dev/null \
&& nohup wmctrl -s 0 &
fi

# clear thumbnails
trash-put /home/mint/.cache/thumbnails/

# change wallpaper
nohup sleep 120 \
&& /usr/bin/variety --profile /home/mint/.config/variety/ \
>/dev/null 2>/dev/null &