#!/bin/bash

# might need pkg install jq
# put flickr api key in config/.flickr_api_key

# Set the directory name
HOME_DIR='/data/data/com.termux/files/home'
DIR_NAME="$HOME_DIR/storage/shared/Pictures/wallpapers"
OUTPUT_DIR="$DIR_NAME/indices"
SCRIPT_DIR="$( dirname -- $0)"
API_KEY=$(cat "${SCRIPT_DIR}/config/.flickr_api_key")

# Create the directories if they don't exist
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Get a random photo from a Flickr group
# if a command line parameter was provided
if [ $# -gt 0 ]; then
    group_id="$1"
    curl_output=$(curl -s "https://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&api_key=${API_KEY}&group_id=${group_id}&format=json&nojsoncallback=1")
    # Strip non-filename safe characters
    safe_group_id=$(echo "$group_id" | tr -c '[:alnum:]._-' '_')
    echo "$curl_output" > "$OUTPUT_DIR/flickr_group_$safe_group_id.txt"
fi


# Pick a random image from a random file in the directory
random_file=$(find "$OUTPUT_DIR" -type f | shuf -n 1)
random_line_count=$(jq ".photos.photo |length -1 " "$random_file")
# because jq is 0 indexed
random_line_index=$(shuf -i 0-"$random_line_count" -n 1)
random_line=$(jq ".photos.photo[$random_line_index]" "$random_file")
random_image=$(echo "$random_line" | jq -r '.id')
random_image_name=$(echo "$random_line" | jq -r '.title')
photo_url="https://live.staticflickr.com/$(echo "$random_line" | jq -r '.server')/$(echo "$random_line" | jq -r '.id')_$(echo "$random_line" | jq -r '.secret').jpg"

# Download the photo to the directory
# image url shou
safe_image_name=$(echo "$random_image_name" | tr -c '[:alnum:]._-' '_')
temp_file="$DIR_NAME/$safe_image_name.jpg"
curl -s "$photo_url" -o "$temp_file"

# Set the wallpaper in Android
termux-wallpaper -f "$temp_file"
