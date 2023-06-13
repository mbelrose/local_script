Add-Type -AssemblyName System.Windows.Forms

$breakDuration = 45 * 60

while ($true) {
    [System.Windows.Forms.MessageBox]::Show("Break time", "Reminder", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    Start-Sleep -Seconds $breakDuration
}