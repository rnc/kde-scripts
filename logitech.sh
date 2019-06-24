#!/bin/bash
#
# This script will reinit the Logitech USB Mouse to my preferred
# button layout.
#
#
# Note: this is broken in KDE Plasma/QT by
# https://bugreports.qt.io/browse/QTBUG-49345
# WONTFIX:
# https://bugs.freedesktop.org/show_bug.cgi?id=96759
#
xinput query-state "Logitech USB Laser Mouse" > /dev/null 2>&1
if [ "$?" == "0" ]
then
    notify-send -u normal -t 2000 -i 'preferences-desktop-mouse' 'Mouse' "Logitech Mouse Setup"
    xinput --set-button-map 'Logitech USB Laser Mouse' 1 2 3 4 5 6 2 8 9
else
    notify-send -u normal -t 2000 -i 'preferences-desktop-mouse' 'Mouse' "No Logitech Mouse Attached"
fi
