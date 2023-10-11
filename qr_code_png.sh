#!/usr/bin/zsh

# take a filename from command line and convert it to a qr code
qrencode -r $1 -o /tmp/qr_code.png 
xviewer /tmp/qr_code.png 
echo 'Press enter key to continue.'
read
rm /tmp/qr_code.png 
