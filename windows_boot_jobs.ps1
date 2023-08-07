# ask user which programs to run
$wshell = New-Object -ComObject Wscript.Shell
$google_voice = $wshell.Popup("Do you want to run Google Voice?",0,"Start Program",36)
$twitch_alerts = $wshell.Popup("Do you want to run Twitch Alerts?",0,"Start Program",36)

# break reminder
start powershell 'C:\Users\user.DESKTOP-6UBKKRI\Documents\local_script\break_reminder.ps1'

# Element for matrix
& C:\Users\user.DESKTOP-6UBKKRI\AppData\Local\element-desktop\Element.exe


# Google Voice
if ($google_voice -eq 6) {
    Start-Sleep -Seconds 20
    & 'C:\Program Files\Google\Chrome\Application\chrome.exe' -new-window "https://voice.google.com"
}

# Discord
Start-Sleep -Seconds 20
& 'C:\Program Files\Google\Chrome\Application\chrome.exe' -new-window "https://discord.com/channels/@me"

# Twitch Live Alert
if ($twitch_alerts -eq 6) {
    start powershell 'node \"C:\Program Files (x86)\twitch_live_alert_win\twitch_live_alert\server\TwitchLiveAlert.js\"'
}
