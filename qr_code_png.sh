#!/usr/bin/zsh

# take a filename from command line and convert it to a qr code
qrencode -r qr_filename -o /tmp/qr_code.png 
xviewer /tmp/qr_code.png 
