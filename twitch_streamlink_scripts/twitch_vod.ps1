$streamer_id = Read-Host "Enter stream url"
$streamer_id = $streamer_id -split "/"
$streamer_id = $streamer_id[-1]
streamlink ("https://www.twitch.tv/videos/" + $streamer_id)



