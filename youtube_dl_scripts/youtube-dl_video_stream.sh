echo 'Enter video URL:'
read stream_url
vlc `yt-dlp -f "best[height<=1080]" --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36' --referer 'https://www.youtube.com/' -g $stream_url`

