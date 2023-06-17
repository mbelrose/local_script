#!/usr/bin/zsh

LIBRARY_DIR="$( dirname -- $BASH_HOME)/lib"
source "$LIBRARY_DIR/platform_config.sh"

platform_config

echo 'Enter video id:'
read stream_url
yt-dlp -x \
    --exec $PLAYER_COMMAND \
    $stream_url