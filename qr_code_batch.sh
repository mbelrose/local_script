#!/usr/bin/zsh
# take a list of parital urls as first parameter
# and transform into qr codes
# partial urls should be alphanumeric lowercase and dashes
base_url="https://www.xenofera.com/xenopedia/"

while read partial_url; do
    url="$base_url$partial_url"
    qr_filename="${partial_url}_qrcode.png"
    echo $url | qrencode -o $qr_filename
done < $1