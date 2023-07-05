# break reminder
start powershell 'C:\Users\user.DESKTOP-6UBKKRI\Documents\local_script\break_reminder.ps1'

# Element for matrix
& C:\Users\user.DESKTOP-6UBKKRI\AppData\Local\element-desktop\Element.exe

# Google Voice
Start-Sleep -Seconds 20
& 'C:\Program Files\Google\Chrome\Application\chrome.exe' -new-window "https://voice.google.com"

# Discord
Start-Sleep -Seconds 20
& 'C:\Program Files\Google\Chrome\Application\chrome.exe' -new-window "https://discord.com/channels/@me"

# Twitch Live Alert
start powershell 'node \"C:\Program Files (x86)\twitch_live_alert_win\twitch_live_alert\server\TwitchLiveAlert.js\"'


# move everything to a second desktop
New-Desktop

# Get the processes for Chrome and Element
$chrome_processes = Get-Process -Name chrome -ErrorAction SilentlyContinue
$element_processes = Get-Process -Name Element -ErrorAction SilentlyContinue

$chrome_processes | ForEach-Object { Move-Window $_.MainWindowHandle (Get-DesktopDesktopId -DesktopNumber 2) }
$element_processes | ForEach-Object { Move-Window $_.MainWindowHandle (Get-DesktopDesktopId -DesktopNumber 2) }