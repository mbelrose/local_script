#!/usr/bin/zsh

LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/set_directory.sh"

set_directoryi

echo 'Enter stream id:'
read stream_url
vlc `yt-dlp -x -g $stream_url`