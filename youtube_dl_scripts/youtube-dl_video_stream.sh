#!/usr/bin/zsh
LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/set_directory.sh"

set_directory

echo 'Enter stream id:'
read stream_url
vlc `yt-dlp -f "best[height<=1080]" -g $stream_url`