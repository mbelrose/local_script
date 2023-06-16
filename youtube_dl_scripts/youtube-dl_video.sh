#!/usr/bin/zsh
windows_home='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
cd $windows_home/Videos/videos_to_move
echo 'Enter video id:'
read video_url
yt-dlp -f "best[height<=1080]" --exec vlc $video_url
