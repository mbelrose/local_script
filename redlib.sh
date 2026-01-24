#!/usr/bin/zsh

#the script must run as a user with permission to run systemctl as root

timeout=60
working_directory=$HOME/.local/opt/redlib
redlib_server_url="http://127.0.0.1:8160/"
settings="settings/restore/?theme=dark&front_page=default&layout=compact&wide=off&blur_spoiler=off&show_nsfw=off&blur_nsfw=off&hide_hls_notification=off&video_quality=medium&hide_sidebar_and_summary=off&use_hls=on&autoplay_videos=on&fixed_navbar=on&disable_visit_reddit_confirmation=off&comment_sort=top&post_sort=hot&subscriptions=&filters=&hide_awards=off&hide_score=off&remove_default_feeds=off"
# initialize web browser so further calls don't fork processes
nohup chromium --incognito >/dev/null 2>/dev/null &

cd $working_directory

# start docker
if ! systemctl is-active --quiet docker;
then 
        systemctl start docker
fi

# wait for docker to start
docker_loop_counter=0
while [[ $docker_loop_counter -le $timeout ]]
do
        sleep 1
        if systemctl is-active --quiet docker;
        then

# --------
# --------
# --------

# start invidious server
if !  curl -s $redlib_server_url --output /dev/null;
then
        docker compose up -d
fi

# wait for invidious server to start
redlib_container_loop_counter=0
while [[ $redlib_container_loop_counter -le $timeout ]]
do
        sleep 1
        if  curl -s $redlib_server_url --output /dev/null;
        then
                # open invidious server in web browser
                chromium --incognito $redlib_server_url$settings >/dev/null 2>/dev/null

                break
        fi
        ((redlib_container_loop_counter++))
done

# -------
# -------
# -------
                break
        fi
        ((docker_loop_counter++))
done