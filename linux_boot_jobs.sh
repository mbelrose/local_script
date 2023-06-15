#!/usr/bin/zsh

windows_home='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
working_directory=$HOME/webdev_repositories_personal/twitch_live_alert

# move a window to a differnt desktop
function move_window_to_desktop() {
    local window_title=$1
    local desktop_number=$2
    window_list=$( \
        wmctrl -l \
        | awk -v title="$window_title" \
        'BEGIN {IGNORECASE=1} $0 ~ title { print $1 }' \
    )
    while read -r window_id; do
        wmctrl -ir "$window_id" -t "$desktop_number"
    done <<< "$window_list"
}


zenity --question --text="Do you want to run Discord?"
discord=$?
zenity --question --text="Do you want to run Google Voice?"
google_voice=$?
zenity --question --text="Do you want to run Twitch Alerts?"
twitch_alerts=$?

# break reminder
nohup gnome-terminal --title "Break Reminder" \
-- $windows_home/Documents/local_script/break_reminder.sh \
>/dev/null 2>/dev/null &
move_window_to_desktop "Break Reminder" 1

# run twitch alerts
if [ $twitch_alerts -eq 0 ]; then
    nohup gnome-terminal --title "Twitch Live Alert" \
--working-directory $working_directory \
-- node server/TwitchLiveAlert.js  \
>/dev/null 2>/dev/null &
    move_window_to_desktop "Twitch Live Alert" 1
fi

# run discord
if [ $discord -eq 0 ]; then
    nohup chromium https://discord.com/channels/@me \
>/dev/null 2>/dev/null &
    move_window_to_desktop "Discord" 1
fi

# run google voice
if [ $google_voice -eq 0 ]; then
    nohup chromium https://voice.google.com/ \
>/dev/null 2>/dev/null &
    move_window_to_desktop "Voice" 1
fi

# clear thumbnails
trash-put /home/mint/.cache/thumbnails/

# change wallpaper
/usr/bin/variety --profile /home/mint/.config/variety/ \
>/dev/null 2>/dev/null &