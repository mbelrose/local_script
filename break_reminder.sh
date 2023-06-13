#!
break_interval=2700 # 45 minutes

echo "Break Reminder"
while true; do
  sleep $break_interval
  notify-send -t 3000 -u low "Rest Break"
done