#!/bin/bash

# Power on and off a usb device:
# http://stackoverflow.com/questions/4702216/controlling-a-usb-power-supply-on-off-with-linux
#
# to get the usb port do a lsusb -t
# example: 6-2.1

action="$1"
usbport="$2"

# Echo something as root
# Example:
#  $ sudo_echo "blah" /home/abdo/test

sudo_echo() {
    sudo sh -c "echo \"$1\" > \"$2\"" 
}


# Find bus device from a vendor string
# Example:
#  $ find_bus_device "Logitech"
#  $ 006:003

find_bus_device() {
    line=$(lsusb | grep "$1")
    if [ "$line" ]; then
        echo "$line" | sed 's/Bus \([0-9]\+\) Device \([0-9]\+\).*/\1:\2/'
    fi
}
    

# Find bus-port from a bus:device
# Example
#  $ find_bus_port 006:003
#  $ 6-2

find_bus_port() {
    busdev="$1"
    declare -i bus dev devnum
    bus=${busdev%:*}
    dev=${busdev#*:}

    find /sys/bus/usb/devices -regex "^.*/$bus-.$" | while read path; do
        devnum=$(cat $path/devnum)
        if [ "$dev" = "$devnum" ]; then
            echo "${path##*/}"
        fi
    done   
}
    

case $action in
    on)
        if [ ! -e "/sys/bus/usb/drivers/usb/$usbport" ] &&
           [   -e "/sys/bus/usb/drivers/usb/bind" ]; then
            sudo_echo "$usbport" /sys/bus/usb/drivers/usb/bind
        fi
        ;;
    
    off)
        if [ -e "/sys/bus/usb/drivers/usb/$usbport" ]; then       
            sudo_echo "0" /sys/bus/usb/devices/$usbport/power/autosuspend
            sudo_echo "auto" /sys/bus/usb/devices/$usbport/power/control
            sudo_echo "$usbport" /sys/bus/usb/drivers/usb/unbind
        fi
        ;;

    find)
        find_bus_device $2
        ;;

    port)
        find_bus_port $2
        ;;
esac
