#!/bin/bash
#
# This script will reinit the Logitech USB Mouse to my preferred
# button layout.

xinput query-state "Logitech USB Laser Mouse" > /dev/null 2>&1
if [ "$?" == "0" ]
then
    notify-send -t 1 "Logitech Mouse Setup"
    xinput --set-button-map 'Logitech USB Laser Mouse' 1 2 3 4 5 6 2 8 9
else
    notify-send -t 1 "No Logitech Mouse Attached"
fi
