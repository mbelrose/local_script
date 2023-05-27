#!
echo 'Enter search term'
read search_term
search_term_clean=$(echo $search_term | sed 's/[^a-zA-Z0-9]/_/g')
echo 'enter list length'
read list_length
list_length=$(echo $list_length | sed 's/[^0-9]//g')
working_directory=/media/mint/Local\ Disk/Users/user.DESKTOP-6UBKKRI/Videos/videos_to_move/random_playlist/$(echo $search_term_clean)_$(date "+%Y%m%d")_$(openssl rand -hex 4)
mkdir -p $working_directory && cd $working_directory
yt-dlp ytsearch$list_length:$search_term --match-filter \!is_live --no-playlist -f'best[filesize<50M][height<=480]' -x -i --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36' --referer 'https://www.youtube.com/'
vlc --random --loop