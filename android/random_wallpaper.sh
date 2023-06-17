#!/bin/bash

# Set the directory name
HOME_DIR='/data/data/com.termux/files/home'
DIR_NAME="$HOME_DIR/storage/shared/Pictures/wallpapers"
OUTPUT_DIR="$DIR_NAME/indices"

# Create the directories if they don't exist
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Get a random photo from a Flickr group
# if a command line parameter was provided
if [ $# -gt 0 ]; then
    group_id="$1"
    curl_output=$(curl -s /
        "https://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&api_key=<your_api_key>&group_id=$group_id&format=json&nojsoncallback=1" /
        )
    # Strip non-filename safe characters
    safe_group_id=$(echo "$group_id" | tr -c '[:alnum:]._-' '_')
    echo "$curl_output" >> "$OUTPUT_DIR/$safe_group_id.txt"
fi

# Pick a random image from a random file in the directory
random_file=$(find "$OUTPUT_DIR" -type f | shuf -n 1)
random_line=$(shuf -n 1 "$random_file")
random_image=$(echo "$random_line" | cut -d ' ' -f 1)

photo_url=$(echo "$curl_output" / 
    | jq -r '.photos.photo[].url_o' | shuf -n 1)

# Download the photo to the directory
temp_file="$OUTPUT_DIR/$(date +%Y-%m-%d_%H-%M-%S).jpg"
curl -s "$photo_url" -o "$temp_file"


# Set the wallpaper in Android
adb push "$random_image" /sdcard/wallpaper.jpg