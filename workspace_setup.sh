#!/usr/bin/zsh

# setup parameters
windows_home='/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI'
working_directory=$HOME/webdev_repositories_personal/firstreact_ts/
mongo_dev_compose=$HOME/webdev_repositories_personal/mongo_dev/mongo_dev_compose.yml
mongo_container_name=mongo_dev
timeout=60
dev_server_url="http://localhost:5173/"
stage_server_url="http://localhost:3000/"

# initialize firefox so further calls don't fork processes
nohup firefox -private -start-debugger-server >/dev/null 2>/dev/null &


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

# -------
# ------- reindent
# -------

# start stage server
if !  curl -s $stage_server_url --output /dev/null;
then
        docker compose up -d
fi

# wait for stage server to start
stage_container_loop_counter=0
while [[ $stage_container_loop_counter -le $timeout ]]
do
        sleep 1
        if  curl -s $stage_server_url --output /dev/null;
        then
                # open stage server in firefox
                firefox -private -url $stage_server_url >/dev/null 2>/dev/null
                break
        fi
        ((stage_container_loop_counter++))
done

# start mongo server
if ! docker ps | grep $mongo_container_name;
then
        docker compose -f $mongo_dev_compose up -d
fi

# wait for mongo server to start
mongo_loop_counter=0
while [[ $mongo_loop_counter -le $timeout ]]
do
        sleep 1
        if docker ps | grep $mongo_container_name;
        then


                #start dev environment
                if ! curl -s $dev_server_url --output /dev/null;
                then
                        nohup gnome-terminal --working-directory $working_directory -- npm run dev  >/dev/null 2>/dev/null &
                fi

                # wait for dev environment to start
                dev_loop_counter=0
                while [[ $dev_loop_counter -le $timeout ]]
                do
                        sleep 1
                        if curl -s $dev_server_url --output /dev/null; 
                        then
                                # open dev server in firefox
                                firefox -private -url "$dev_server_url" >/dev/null 2>/dev/null
                                break
                        fi
                        ((dev_loop_counter++))
                done


                break
        fi
        ((mongo_loop_counter++))
done

# -------
# -------
# -------

                break
        fi
        ((docker_loop_counter++))
done


# miscellaneous: open notes and a command prompt
nohup gnome-terminal --working-directory $working_directory >/dev/null 2>/dev/null &
nohup xed $windows_home/Downloads/webdev_symfony_notes20180924a.txt >/dev/null 2>/dev/null &
nohup code-insiders --unity-launch $working_directory >/dev/null 2>/dev/null &

# Prompt user to play music
if zenity --question --text="Do you want to play music?"; then
  nohup vlc `yt-dlp -f "best[height<=480]"  --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36' --referer 'https://www.youtube.com/' -g 'https://www.youtube.com/watch?v=MVPTGNGiI-4'` >/dev/null 2>/dev/null &
fi

