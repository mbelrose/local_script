#!
break_interval=2700 # 45 minutes

while true; do
  sleep $break_interval
  zenity --info --title="Break Reminder" --timeout=3 --text="Rest Break"
done