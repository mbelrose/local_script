#!/usr/bin/zsh

# prompt the user to run discord
if zenity --question --text="Do you want to run Discord?"; then
    nohup /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=discord com.discordapp.Discord >/dev/null 2>/dev/null &
fi

# prompt the user to run google voice
if zenity --question --text="Do you want to run Google Voice?"; then
    nohup chromium https://voice.google.com/ >/dev/null 2>/dev/null &
fi

# clear thumbnails
trash-put /home/mint/.cache/thumbnails/
