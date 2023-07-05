$password = Get-Content 'C:\Users\user.DESKTOP-6UBKKRI\Documents\local_script\keys\feral_rclone_password.txt'
& rclone.exe rcd --rc-user mbelrose --rc-pass $password[0] --rc-web-gui