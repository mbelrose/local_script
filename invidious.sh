#!/usr/bin/zsh

#the script must run as a user with permission to run systemctl as root

timeout=60
working_directory=$HOME/.local/opt/invidious
invidious_server_url="http://127.0.0.1:3300/feed/popular"
settings="?autoplay=1&continue=0&quality=medium&related_videos=false&comments=false&volume=2&dark_mode=true"
login_script='file:///mnt/8cba077b-050c-47b9-9e82-8c8b0730ca1e/Documents/local_script/invidious_autologin.html'

# initialize firefox so further calls don't fork processes
nohup firefox -private-window >/dev/null 2>/dev/null &

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
if !  curl -s $invidious_server_url --output /dev/null;
then
        docker compose up -d
fi

# wait for invidious server to start
invidious_container_loop_counter=0
while [[ $invidious_container_loop_counter -le $timeout ]]
do
        sleep 1
        if  curl -s $invidious_server_url --output /dev/null;
        then
                # open invidious server in firefox
                firefox -private-window $login_script >/dev/null 2>/dev/null
                
                break
        fi
        ((invidious_container_loop_counter++))
done

# -------
# -------
# -------
                break
        fi
        ((docker_loop_counter++))
done
