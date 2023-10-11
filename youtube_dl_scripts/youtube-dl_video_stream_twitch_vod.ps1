cd  $env:USERPROFILE\Videos\videos_to_move\

$streamer_id = Read-Host "Enter stream url"
$streamer_id = $streamer_id -split "/"
$streamer_id = $streamer_id[-1]

& 'C:\Program Files\VideoLAN\VLC\vlc.exe' $( & yt-dlp -f "480p,480p30" -g ("https://www.twitch.tv/videos/" + $streamer_id) )