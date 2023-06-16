echo 'Enter stream id:'
read stream_url
vlc `yt-dlp -x -g $stream_url`