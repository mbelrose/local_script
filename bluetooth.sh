#!/usr/bin/zsh

device_macs=("14:43:19:E5:B5:9F" "1C:96:5A:C5:5C:2C")
# device names must be in the same order as the mac addresses
# should be alphanumeric
device_names=("ET1" "Controller")

# Create a list of buttons for each device after the first
button_list=""
for (( i=1; i<${#device_macs[@]}; i++ )); do
    button_list+=" --extra-button=${device_names[$i]}"
done

# Create a popup with 3 buttons
chosen=$( \
    zenity --question \
    --title='Bluetooth' \
    --text='Select a device to connect to:' \
    --ok-label='Disconnect' \
    --cancel-label=${device_names[0]} \
    ${button_list} \
)
zen_return=$?

# Launch bluetoothctl with the selected device
if [ $zen_return -eq 0 ]; then
    bluetoothctl power off
elif [[ $zen_return -eq 1 && -z $chosen ]]; then
    bluetoothctl power on
    bluetoothctl connect "${device_macs[0]}"
else
    # search all but first item to find index
    for (( i=1; i<${#device_names[@]}; i++ )); do
        if [[ "${device_names[$i]}" = "$chosen" ]]; then
            chosen_index=$i
            break
        fi
    done
    bluetoothctl power on
    bluetoothctl connect "${device_macs[$i]}"
fi