#!
echo converting and trashing $1
convert -resize 921600\@ $1 "${1%.*}_sm.${1##*.}"
trash-put $1
