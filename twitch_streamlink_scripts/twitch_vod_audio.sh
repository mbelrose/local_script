echo 'Enter vod id:'
read streamer_id
streamer_id=$(echo $streamer_id | awk -F/ '{print $NF}')
streamer_id=$(echo $streamer_id | sed 's/[^[:alnum:]_\?=]//g')
streamlink https://twitch.tv/videos/$streamer_id audio_only,audio

