#!/usr/bin/zsh
windows_home='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
cd $windows_home/Videos/videos_to_move

echo 'Enter vod id:'
read streamer_id
# strip out the id/timestamp from the url
streamer_id=$(echo $streamer_id | awk -F/ '{print $NF}')
streamer_id=$(echo $streamer_id | sed 's/[^[:alnum:]_\?=]//g')

streamlink --output "{author} - {id} - {title}.mp4" https://twitch.tv/videos/$streamer_id

echo "Press enter key to continue"
read
