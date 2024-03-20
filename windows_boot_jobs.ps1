# ask user which programs to run
$wshell = New-Object -ComObject Wscript.Shell
$twitch_alerts = $wshell.Popup("Do you want to run Twitch Alerts?",0,"Start Program",36)

# break reminder
start powershell 'C:\Users\user.DESKTOP-6UBKKRI\Documents\local_script\break_reminder.ps1'

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

