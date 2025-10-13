#!/usr/bin/zsh

#the script must run as a user with permission to run systemctl as root

timeout=60
working_directory=$HOME/.local/opt/voyager_lemmy
voyager_server_url="http://127.0.0.1:5314/"

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

# start voyager server
if !  curl -s $voyager_server_url --output /dev/null;
then
        docker compose up -d
fi

# wait for voyager server to start
voyager_container_loop_counter=0
while [[ $voyager_container_loop_counter -le $timeout ]]
do
        sleep 1
        if  curl -s $voyager_server_url --output /dev/null;
        then
                # open glance server in firefox
                firefox -private-window $voyager_server_url >/dev/null 2>/dev/null
                
                break
        fi
        ((voyager_container_loop_counter++))
done

# -------
# -------
# -------
                break
        fi
        ((docker_loop_counter++))
done
