cd 'C:\Program Files (x86)\rclone\'
$password = Get-Content 'C:\Users\user.DESKTOP-6UBKKRI\Documents\local_script\keys\feral_rclone_password'
.\rclone.exe rcd --rc-user mbelrose --rc-pass $password[0] --rc-web-gui