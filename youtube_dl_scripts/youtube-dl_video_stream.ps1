cd  $env:USERPROFILE\Videos\videos_to_move\
$video_url = Read-Host "Enter video url"
& 'C:\Program Files\VideoLAN\VLC\vlc.exe' $( & yt-dlp -f 'best[height<=1080]' -g $video_url)