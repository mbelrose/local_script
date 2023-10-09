#!/usr/bin/zsh
# print clipboard to a qr code
xclip -selection c -o | qrencode -t utf8
read