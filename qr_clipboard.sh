#!/usr/bin/zsh

#convert clipboard to a qr code
xclip -selection c -o | qrencode -t utf8 | xclip -selection c
