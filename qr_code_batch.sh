#!/usr/bin/zsh
# take a list of parital urls as first parameter
# and transform into qr codes, including a highres version for finicky systems
# partial urls should be alphanumeric lowercase and dashes
base_url="https://www.xenofera.com/xenopedia/"
lowres_dir="low_resolution"
highres_dir="high_resolution"

if [ ! -d "$lowres_dir" ]; then
    mkdir -p "$lowres_dir"
fi
if [ ! -d "$highres_dir" ]; then
    mkdir -p "$highres_dir"
fi

while read partial_url; do
    url="$base_url$partial_url"
    qr_filename_lowres="${lowres_dir}/${partial_url}_qrcode.png"
    qr_filename_highres="${highres_dir}/${partial_url}_qrcode_highres.png"
    echo $url | qrencode -o $qr_filename_lowres
    echo $url | qrencode -s 48 -o $qr_filename_highres

done < $1