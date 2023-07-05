# need to run:
# Install-Module -Name VirtualDesktop

# create a new desktop
$targetDesktop = New-Desktop -PassThru

# $desktopId = $desktop.DesktopId
# $targetDesktop = Get-DesktopDesktopId -DesktopNumber 2
# New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops" -Name "Desktop 2" -ItemType "Directory"

# break reminder
$breakObj = Start-Process powershell 'C:\Users\user.DESKTOP-6UBKKRI\Documents\local_script\break_reminder.ps1' -PassThru
Move-Window $breakObj.MainWindowHandle $targetDesktop

# Element for matrix
$elementObj = Start-Process -FilePath "C:\Users\user.DESKTOP-6UBKKRI\AppData\Local\element-desktop\Element.exe" -PassThru
Move-Window $elementObj.MainWindowHandle $targetDesktop

# Google Voice
$voiceObj = Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "-new-window", "https://voice.google.com" -PassThru
Move-Window $voiceObj.MainWindowHandle $targetDesktop

# Discord
$discordObj = Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "-new-window", "https://discord.com/channels/@me" -PassThru
Move-Window $discordObj.MainWindowHandle $targetDesktop

# Twitch Live Alert
$alertObj = Start-Process powershell 'node \"C:\Program Files (x86)\twitch_live_alert_win\twitch_live_alert\server\TwitchLiveAlert.js\"' -PassThru
Move-Window $alertObj.MainWindowHandle $targetDesktop
