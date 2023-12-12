#!/usr/bin/zsh
# take a list of parital urls as first parameter
# and transform into qr codes
# partial urls should be alphanumeric lowercase and dashes

while read partial_url; do
    url="$partial_url"
    qr_filename="${partial_url}_qrcode.png"
    $url | qrencode -o $qr_filename

done < $1