#!/usr/bin/zsh

timeout=60
working_directory=$HOME/.local/bin/invidious/
invidious_server_url="http://127.0.0.1:3300/feed/popular"
settings="?autoplay=1&continue=0&quality=medium&related_videos=false&comments=false&volume=2&dark_mode=true"

# initialize firefox so further calls don't fork processes
nohup firefox -private >/dev/null 2>/dev/null &

cd $working_directory

# start docker
if ! systemctl is-active --quiet docker;
then 
        sudo systemctl start docker
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
        docker compose -f docker-compose-local.yml up -d
fi

# wait for invidious server to start
invidious_container_loop_counter=0
while [[ $invidious_container_loop_counter -le $timeout ]]
do
        sleep 1
        if  curl -s $invidious_server_url --output /dev/null;
        then
                # open invidious server in firefox
                firefox -private -url $invidious_server_url${settings} >/dev/null 2>/dev/null
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
