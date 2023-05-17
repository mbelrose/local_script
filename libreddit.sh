#!
# docker run -d --name libreddit -p 8180:8080 libreddit/libreddit &

timeout=60

# initialize firefox so further calls don't fork processes
firefox -private >/dev/null 2>/dev/null &

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

if ! docker ps | grep libreddit;
then
        docker start libreddit
fi

libreddit_loop_counter=0
while [[ $libreddit_loop_counter -le $timeout ]]
do
        sleep 1
        if docker ps | grep libreddit; 
        then
        
                firefox -private "http://127.0.0.1:8180/settings/restore/?theme=laserwave&front_page=popular&layout=compact&wide=off&post_sort=top&comment_sort=top&show_nsfw=off&blur_nsfw=off&use_hls=on&hide_hls_notification=off&subscriptions=&filters=" >/dev/null 2>/dev/null
                break
        fi
        ((libreddit_loop_counter++))
done

# -------
# -------
# -------
                break
        fi
        ((docker_loop_counter++))
done
