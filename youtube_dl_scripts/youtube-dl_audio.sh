#!/usr/bin/zsh

LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/platform_config.sh"

platform_config

echo 'Enter video id:'
read video_url
yt-dlp -x \
    --exec $PLAYER_COMMAND \
    $video_url