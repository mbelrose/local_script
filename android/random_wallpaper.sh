#!/bin/bash

# Set the directory name
DIR_NAME="my_wallpapers"
OUTPUT_DIR="$DIR_NAME/output"

# Create the directories if they don't exist
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Get a random photo from a Flickr group
group_id="$1"
curl_output=$(curl -s "https://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&api_key=<your_api_key>&group_id=$group_id&format=json&nojsoncallback=1")
echo "$curl_output" >> "$OUTPUT_DIR/flickr_output.txt"
photo_url=$(echo "$curl_output" | jq -r '.photos.photo[].url_o' | shuf -n 1)

# Download the photo to the directory
temp_file="$OUTPUT_DIR/$(date +%Y-%m-%d_%H-%M-%S).jpg"
curl -s "$photo_url" -o "$temp_file"

# List the downloaded files and images in the directory
echo "Downloaded files:"
ls "$OUTPUT_DIR"
echo "Images in directory:"
file "$OUTPUT_DIR"/*
echo

# Pick a random image from a random file in the directory
random_file=$(find "$OUTPUT_DIR" -type f | shuf -n 1)
random_line=$(shuf -n 1 "$random_file")
random_image=$(echo "$random_line" | cut -d ' ' -f 1)

# Set the wallpaper in Android
adb push "$random_image" /sdcard/wallpaper.jpg