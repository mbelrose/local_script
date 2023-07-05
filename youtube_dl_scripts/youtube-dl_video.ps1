cd  $env:USERPROFILE\Videos\videos_to_move\
$video_url = Read-Host "Enter video url"
& yt-dlp -f "best[height<=1080]" $video_url 
