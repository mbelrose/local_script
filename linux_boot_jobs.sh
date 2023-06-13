#!/usr/bin/zsh

windows_home='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'

# break reminder
nohup gnome-terminal --title "Break Reminder" -- $windows_home/Documents/local_script/break_reminder.sh  >/dev/null 2>/dev/null &


# prompt the user to run discord
if zenity --question --text="Do you want to run Discord?"; then
    nohup sleep 30 && chromium https://discord.com/channels/@me >/dev/null 2>/dev/null &
fi

# prompt the user to run google voice
if zenity --question --text="Do you want to run Google Voice?"; then
    nohup sleep 60 && chromium https://voice.google.com/ >/dev/null 2>/dev/null &
fi

# clear thumbnails
trash-put /home/mint/.cache/thumbnails/


nohup sleep 120 && /usr/bin/variety --profile /home/mint/.config/variety/ >/dev/null 2>/dev/null &