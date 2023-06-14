#!/bin/bash

device_mac="14:43:19:E5:B5:9F"
device_name="ET1"

# Create a popup with buttons for "on", "off", and "connect"
$(zenity --question --title="Bluetooth" --text="Turn Bluetooth on or off?" --ok-label="Connect ${device_name}" --cancel-label="Off")

# Launch bluetoothctl with the selected argument
if [ $? -eq 0 ]; then
    bluetoothctl power on
    bluetoothctl connect $device_mac
else
    bluetoothctl power off
fi