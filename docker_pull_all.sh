#!/usr/bin/zsh
for i in $(docker image ls -a | awk 'NR>1{print $1}'); 
do
    docker image pull $i
done
docker image prune
