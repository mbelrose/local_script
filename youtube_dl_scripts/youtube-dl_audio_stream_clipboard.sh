#!/usr/bin/zsh

# this script will not run from the "source" command on some platforms
LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/platform_config.sh"

platform_config

`$PLAYER_COMMAND $(yt-dlp -x -g $(xclip -o -selection c ))`