#!

# prompt the user to run discord
sleep 120
if zenity --question --text="Do you want to run Discord?"; then
    nohup /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=discord com.discordapp.Discord >/dev/null 2>/dev/null &
fi

if zenity --question --text="Do you want to run Google Voice?"; then
    nohup chromium https://voice.google.com/ >/dev/null 2>/dev/null &
fi