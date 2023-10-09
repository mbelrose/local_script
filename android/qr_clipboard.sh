#!/usr/bin/zsh
xclip -selection c -o | qrencode -t utf8
read