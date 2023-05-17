echo 'Enter streamer id:'
read streamer_id
streamer_id=$(echo $streamer_id | sed -E s/https...\(www.\)?twitch.tv.//)
streamlink --twitch-disable-ads https://twitch.tv/$streamer_id audio_only,audio
