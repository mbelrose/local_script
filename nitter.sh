#!
# systemctl start docker &
docker start nitter &
docker start nitter-redis &
firefox -private -new-window "http://127.0.0.1:8280/" &
