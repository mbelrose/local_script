#!/usr/bin/zsh

cd ~/.local/opt/invidious
docker compose down
git pull
docker pull quay.io/invidious/invidious
docker pull quay.io/invidious/inv-sig-helper
# docker pull quay.io/invidious/youtube-trusted-session-generator
# probably don't need to update this regularly
docker pull postgres
docker compose up -d

# cd ~/.local/opt/cobalt
# docker compose down
# git pull
# docker pull ghcr.io/imputnet/cobalt
# docker pull ghcr.io/containrrr/watchtower
# docker compose up -d
# 
# cd ~/.local/opt/cobalt_web
# docker compose down
# #no git repo to pull here
# docker pull lipanski/docker-static-website
# docker compose up -d

cd ~/.local/opt/glance
docker compose down
git pull
docker pull glanceapp/glance
docker compose up -d

docker image prune