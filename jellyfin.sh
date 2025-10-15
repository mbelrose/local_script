#!/usr/bin/zsh

#the script must run as a user with permission to run systemctl as root

timeout=60
working_directory=$HOME/.local/opt/jellyfin
jellyfin_server_url="http://127.0.0.1:8096/"
NO_EXTERNAL_COMPOSE=docker-compose.yml
EXTERNAL_COMPOSE=docker-compose-external.yml
EXTERNAL_PATH="/media/mint/Worn out disk1/Documents/minor/erase_redundant"
# login_script='file:///mnt/8cba077b-050c-47b9-9e82-8c8b0730ca1e/Documents/local_script/jellyfin_autologin.html'
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
if !  curl -s $jellyfin_server_url --output /dev/null;
then
        COMPOSE_FILE=$NO_EXTERNAL_COMPOSE
        if [ -d "$EXTERNAL_PATH" ];
        then
                COMPOSE_FILE=$EXTERNAL_COMPOSE
        fi
        docker compose -f $COMPOSE_FILE up -d
fi

# wait for invidious server to start
jellyfin_container_loop_counter=0
while [[ $jellyfin_container_loop_counter -le $timeout ]]
do
        sleep 1
        if  curl -s $jellyfin_server_url --output /dev/null;
        then
                # open invidious server in firefox
                firefox -private-window $jellyfin_server_url >/dev/null 2>/dev/null
                
                break
        fi
        ((jellyfin_container_loop_counter++))
done

# -------
# -------
# -------
                break
        fi
        ((docker_loop_counter++))
done
