 $password = Get-Content 'C:\Users\user.DESKTOP-6UBKKRI\Documents\local_script\keys\feral_rutorrent_password.txt'
 & 'C:\Program Files\Mozilla Firefox\firefox.exe'  -private -URL ('https://mbelrose:' + $password[0] + '@phanes.feralhosting.com/mbelrose/rutorrent/')