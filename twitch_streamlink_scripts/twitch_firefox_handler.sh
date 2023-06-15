#!
zenity --question --text="did it work?"
nohup gnome-terminal -- echo '11' >/dev/null 2>/dev/null &

# gconftool-2 -s /desktop/gnome/url-handlers/ext+streamlink/command '/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI/Documents/local_script/twitch_streamlink_scripts/twitch_firefox_handler.sh %s' --type String
# gconftool-2 -s /desktop/gnome/url-handlers/ext+streamlink/enabled --type Boolean true

# echo 'Enter streamer id:'
# read streamer_id
# streamer_id=$(echo $streamer_id | awk -F/ '{print $NF}')
# streamer_id=$(echo $streamer_id | sed 's/[^[:alnum:]_\?=]//g')
# streamlink https://twitch.tv/$streamer_id



# [Desktop Entry]
# Name=twitch_firefox_handler
# Exec=/media/mint/Local\\ Disk/Users/3/Documents/local_script/twitch_streamlink_scripts/twitch_firefox_handler.sh
# Comment=
# Terminal=true
# Icon=cinnamon-panel-launcher
# StartupNotify=false
# Type=Application
# MimeType=x-scheme-handler/ext+streamlink

# xdg-mime default twitch_firefox_handler.desktop x-scheme-handler/ext+streamlink

# echo 'text/x-streamlink=twitch_firefox_handler.desktop' >> ~/.local/share/mime/packages/foo.xml && update-mime-database ~/.local/share/mime/