# ask user which programs to run
$wshell = New-Object -ComObject Wscript.Shell
$google_voice = $wshell.Popup("Do you want to run Google Voice?",0,"Start Program",36)
$twitch_alerts = $wshell.Popup("Do you want to run Twitch Alerts?",0,"Start Program",36)

# break reminder
start powershell 'C:\Users\user.DESKTOP-6UBKKRI\Documents\local_script\break_reminder.ps1'

# Element for matrix
& C:\Users\user.DESKTOP-6UBKKRI\AppData\Local\element-desktop\Element.exe

# initialize firefox
& 'C:\Program Files\Mozilla Firefox\firefox.exe' -private-window

# Discord
& 'C:\Users\user.DESKTOP-6UBKKRI\AppData\Local\Discord\Update.exe' --processStart Discord.exe

# Twitch Live Alert
if ($twitch_alerts -eq 6) {
    start powershell 'node \"C:\Program Files (x86)\twitch_live_alert_win\twitch_live_alert\server\TwitchLiveAlert.js\"'
}

# Freetube Youtube
& 'C:\Program Files\FreeTube\FreeTube.exe'

# background wallpaper switcher
& "C:\Program Files (x86)\johnsadventures.com\John's Background Switcher\BackgroundSwitcher.exe"

# Google Voice
if ($google_voice -eq 6) {
    Start-Sleep -Seconds 120
    & 'C:\Program Files\Mozilla Firefox\firefox.exe' -private-window -new-window "https://voice.google.com/u/0/messages"
}
