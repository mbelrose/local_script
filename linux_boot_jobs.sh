#!/usr/bin/zsh

windows_home='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
working_directory=$HOME/webdev_repositories_personal/twitch_live_alert

# move a window to a different desktop
function move_window() {
    local window_title=$1
    local desktop_number=$2
    window_list=$(wmctrl -l)
    if [[ $(echo "$window_list" | wc -l) -lt 1 ]]; then
        return 1
    fi
    window_list=$(
        awk -v title="$window_title" \
        'BEGIN {IGNORECASE=1} $0 ~ title { print $1 }' \
        <<< "$window_list")
    while read -r window_id; do
        if echo "$window_id" | grep -q '^[0-9x]\+$'
        then
            wmctrl -ir "$window_id" -t "$desktop_number"
        fi
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

# run twitch alerts
if [ $twitch_alerts -eq 0 ]; then
    nohup gnome-terminal --title "Twitch Live Alert" \
        --working-directory $working_directory \
        -- node server/TwitchLiveAlert.js  \
        >/dev/null 2>/dev/null &
    
fi

# run discord
if [ $discord -eq 0 ]; then
    nohup chromium https://discord.com/channels/@me \
        >/dev/null 2>/dev/null &
    
fi

# run google voice
if [ $google_voice -eq 0 ]; then
    nohup chromium https://voice.google.com/ \
        >/dev/null 2>/dev/null &
    
fi

# clear thumbnails
trash-put /home/mint/.cache/thumbnails/ \
    >/dev/null 2>/dev/null &

# sleep because weird timing issue on wmctrl
sleep 15 \
    && move_window "Voice" 1 \
    && move_window "Discord" 1 \
    && move_window "Twitch Live Alert" 1 \
    && move_window "Break Reminder" 1

# change wallpaper
/usr/bin/variety --profile /home/mint/.config/variety/