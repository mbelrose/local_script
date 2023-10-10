#!/usr/bin/zsh

# print input to a qr code
echo 'Enter text to make a qr code.'
read qr_clip
echo $qr_clip | qrencode -t utf8
echo
echo $qr_clip
echo
echo 'Press Enter to continue.'
read
