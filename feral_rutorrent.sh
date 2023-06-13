#!/usr/bin/zsh

password=$(cat '/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI/Documents/local_script/keys/feral_rutorrent_password.txt')
rutorrent_url="https://mbelrose:${password}@phanes.feralhosting.com/mbelrose/rutorrent/"

nohup firefox -private $rutorrent_url >/dev/null 2>/dev/null &
 