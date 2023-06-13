#!
password=$(cat '/media/mint/Local Disk/Users/user.DESKTOP-6UBKKRI/Documents/local_script/keys/feral_rclone_password.txt')
rclone rcd --rc-web-gui --rc-user mbelrose --rc-pass $password