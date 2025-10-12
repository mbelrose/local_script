#!/usr/bin/zsh

# this script will not run from the "source" command on some platforms
LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/platform_config.sh"

platform_config

echo 'Enter video id:'
read stream_url

if [[ -z "$stream_url" ]]; then
    echo "No video id provided."
    echo "Press Enter to get the video id from the clipboard."
    read
    stream_url=$(xclip -o -selection c )
fi

if [[ -z "$stream_url" ]]; then
    `$PLAYER_COMMAND $(yt-dlp -f "best[height<=1080]" -g $stream_url)`
fi
