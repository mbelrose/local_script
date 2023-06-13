
#might need to Install-Module -Name BurntToast

$breakDuration = 2700
# 45 minutes

echo "Break Reminder"
while ($true) {
    Start-Sleep -Seconds $breakDuration
    New-BurntToastNotification -Text 'Break Reminder'  -SnoozeAndDismiss 
}

