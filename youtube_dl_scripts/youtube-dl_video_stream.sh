#!/usr/bin/zsh

LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/platform_config.sh"

platform_config

echo 'Enter video id:'
read video_url

$PLAYER_COMMAND `yt-dlp -f "best[height<=1080]" -g $stream_url`