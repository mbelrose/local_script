#!/usr/bin/zsh

# print clipboard to a qr code
CLIPBOARD=$(xclip -selection c -o)
echo $CLIPBOARD | qrencode -t utf8
echo $CLIPBOARD
echo 'Press Enter to continue.'
read