#!/usr/bin/zsh

LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/set_directory.sh"

set_directory

echo 'Enter video id:'
read video_url
yt-dlp -f "best[height<=1080]" --exec vlc $video_url


