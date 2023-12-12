#!/usr/bin/zsh
# take a list of parital urls as first parameter
# and transform into qr codes
# partial urls should be alphanumeric lowercase and dashes

while read partial_url; do
    url="$partial_url"
    qr_filename="${qr_filename}_qrcode.png"
#    echo $url | qrencode -o $qr_filename
    echo "encoding $url --> $qr_filename"
done < $1