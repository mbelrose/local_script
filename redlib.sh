#!/usr/bin/zsh

#the script must run as a user with permission to run systemctl as root

timeout=60
working_directory=$HOME/.local/opt/redlib
redlib_server_url="http://127.0.0.1:8160/"
settings="settings/restore/?theme=system&front_page=default&layout=compact&wide=off&post_sort=hot&comment_sort=confidence&show_nsfw=off&use_hls=off&hide_hls_notification=off&hide_awards=off&fixed_navbar=on&subscriptions=&filters="
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
                # open invidious server in firefox
                firefox -private-window -url $redlib_server_url$settings >/dev/null 2>/dev/null
                
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
