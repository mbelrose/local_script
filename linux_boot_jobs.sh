#!/usr/bin/zsh

# might need to sudo apt install trash-cli to use this

HOME_DIRECTORY='/mnt/8cba077b-050c-47b9-9e82-8c8b0730ca1e'
LIB_DIRECTORY=$HOME_DIRECTORY/Documents/local_script/lib
WORKING_DIRECTORY=$HOME_DIRECTORY/opt/twitch_live_alert
NVM_BIN='/home/mint/.nvm/versions/node/v21.7.3/bin'

KEEPASSXC_LOCAL_PATH=/home/mint/.local/opt/keepassxc/keepassxc_database_20251118a
KEEPASSXC_REMOTE_PATH=google_drive_drmutant_gmail_com:keepassxc/keepassxc_database_20251118a

# import move window function
source $LIB_DIRECTORY/move_window.sh

# query user for what apps to run
# using plaintext match, so make sure no tag text is contained in another 
zenity --list --checklist \
--title="What do you want to run?" --height=600 --width=600 \
--multiple --print-column=2 --hide-column=2 \
--column=checkbox --column=number --column=label \
TRUE twitch_live_alert "Twitch Live Alert" \
TRUE google_voice "Google Voice" \
FALSE signal_messenger "Signal Messenger" \
| read apps_to_run


# preload web browser
nohup chromium \
    --incognito \
    >/dev/null 2>/dev/null &

# run discord
nohup chromium \
    --new-window \
    https://discord.com/channels/@me \
    >/dev/null 2>/dev/null &

# break reminder
gnome-terminal --title "Break Reminder" \
    -- $HOME_DIRECTORY/Documents/local_script/break_reminder.sh

# run twitch alerts
if [[ $apps_to_run =~ twitch_live_alert ]]; then
    gnome-terminal --title "Twitch Live Alert" \
        --working-directory $WORKING_DIRECTORY \
        -- $NVM_BIN/node server/TwitchLiveAlert.js
fi

# run google voice
if [[ $apps_to_run =~ google_voice ]]; then
    nohup chromium \
        --new-window \
        https://voice.google.com/u/0/messages \
        >/dev/null 2>/dev/null &
fi

# run Signal messenger
if [[ $apps_to_run =~ signal_messenger ]]; then
    nohup /opt/Signal/signal-desktop \
        --no-sandbox %U \
        >/dev/null 2>/dev/null &
fi


# sync keepassxc database
gnome-terminal --title "KeepassXC Sync" \
    -- rclone sync --verbose $KEEPASSXC_LOCAL_PATH $KEEPASSXC_REMOTE_PATH

# launch keepassxc
nohup /usr/bin/flatpak \
    run --branch=stable --arch=x86_64 \
    --command=keepassxc \
    --file-forwarding org.keepassxc.KeePassXC @@ %f @@ \
    >/dev/null 2>/dev/null &

# run joplin note app
nohup /home/mint/.joplin/Joplin.AppImage \
    >/dev/null 2>/dev/null &

# clear thumbnails
trash-put /home/mint/.cache/thumbnails/ \
    >/dev/null 2>/dev/null &


# move windows to second desktop
move_window "Break Reminder" 1
if [[ $apps_to_run =~ twitch_live_alert ]]; then
    move_window "Twitch Live Alert" 1
fi

if [[ $apps_to_run =~ google_voice ]]; then
    move_window "Voice" 1
fi

move_window "Discord" 1 
move_window KeePassXC 1
move_window "Joplin" 1

# switch to main desktop in case got pulled
wmctrl -s 0