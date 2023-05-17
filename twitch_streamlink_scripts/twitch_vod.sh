echo 'Enter vod id:'
read streamer_id
streamer_id=$(echo $streamer_id | sed -E s/https...\(www.\)?twitch.tv.videos.//)
streamlink --twitch-disable-ads --player-no-close https://twitch.tv/videos/$streamer_id

