#!/usr/bin/zsh

LIBRARY_DIR="$( dirname -- $0)/lib"
source "$LIBRARY_DIR/get_os_platform.sh"

if [ is_desktop() ]; then
    HOME_DIR='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
    cd $HOME_DIR/Videos/videos_to_move
elif [ is_android() ]; then
    HOME_DIR='/data/data/com.termux/files/home'
    cd $HOME_DIR/storage/shared/Download
else
    echo 'Unknown OS'
    return 1
fi

echo 'Enter video id:'
read video_url
yt-dlp -f "best[height<=1080]" --exec vlc $video_url
