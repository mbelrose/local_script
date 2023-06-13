cd ~\Videos\videos_to_move\
$video_url = Read-Host "Enter video url"
& 'C:\Program Files\VideoLAN\VLC\vlc.exe' $( & 'C:\Program Files (x86)\youtube-dl\yt-dlp.exe' -f 'best[height<=1080]' -g --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36' --referer 'https://www.youtube.com/' $video_url)

