#!/bin/bash

# Set the directory name
DIR_NAME="my_wallpapers"

# Create the directory if it doesn't exist
if [ ! -d "$DIR_NAME" ]; then
  mkdir "$DIR_NAME"
fi

# Get a random photo from a Flickr group
group_id="$1"
curl_output=$(curl -s "https://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&api_key=<your_api_key>&group_id=$group_id&format=json&nojsoncallback=1")
echo "$curl_output" > flickr_output.txt
photo_url=$(echo "$curl_output" | jq -r '.photos.photo[].url_o' | shuf -n 1)

# Download the photo to the directory
temp_file="$DIR_NAME/$(date +%Y-%m-%d_%H-%M-%S).jpg"
curl -s "$photo_url" -o "$temp_file"

# List the downloaded files and images in the directory
echo "Downloaded files:"
ls "$DIR_NAME"
echo "Images in directory:"
file "$DIR_NAME"/*
echo

# Set the wallpaper in Android
adb push "$temp_file" /sdcard/wallpaper.jpg
adb shell am start -a android.intent.action.ATTACH_DATA -c android.intent.category.DEFAULT -d file:///sdcard/wallpaper.jpg -t image/jpeg