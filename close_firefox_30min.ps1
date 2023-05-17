Write-Host "Put tv on sleep."
start-sleep  -s 1800
Get-Process firefox | % { $_.CloseMainWindow() }