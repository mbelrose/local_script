#!
windows_home='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
cd $windows_home/Videos/videos_to_move
echo 'Enter video id:'
read video_url
yt-dlp -x --exec vlc --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36' --referer 'https://www.youtube.com/' $video_url
