#!/usr/bin/zsh

# print input to a qr code
echo 'Enter text to make a qr code png.'
read qr_text
echo $qr_text | qrencode -t utf8
qrencode -o /tmp/qr_code.png 
xviewer /tmp/qr_code.png 
