#!/usr/bin/zsh

# take a filename from command line and convert it to a qr code

qr_filename=$(uuidgen)
qr_filename="/tmp/qr_code_${qr_filename}.png"

qrencode -r $1 -o $qr_filename
xviewer $qr_filename
echo 'Press enter key to continue.'
read
rm $qr_filename
