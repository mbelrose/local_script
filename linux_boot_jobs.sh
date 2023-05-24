#!

# prompt the user to run discord
sleep 120
if zenity --question --text="Do you want to play music?"; then
    /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=discord com.discordapp.Discord
fi