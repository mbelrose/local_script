echo 'Enter video URL:'
read stream_url
vlc `yt-dlp -f "best[height<=1080]" -g $stream_url`