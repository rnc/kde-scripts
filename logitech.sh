#!/bin/bash
#
# This script will reinit the Logitech USB Mouse to my preferred
# button layout on resume from sleep. It should be named 00-logitech.sh
# and placed or symbolic linked in /etc/pm/sleep.d/
#
# Running it without arguments will also reinit the mouse.
#


# if [ -d /usr/lib64 ]
# then
#    . /usr/lib64/pm-utils/functions
# else
#    . /usr/lib/pm-utils/functions
# fi

# case "$1" in
#     thaw|resume|post)
#         export DISPLAY=:0
# 	export WAKINGUSER=`who | sed 's/\([a-z]*\).*/\1/g;q'`
#         echo "--> woke up `date` for $WAKINGUSER " > /var/log/wakeuplogitech.log
# 	echo "xinput: `su $WAKINGUSER -c 'export DISPLAY=:0 ; xinput'`" >> /var/log/wakeuplogitech.log 2>&1
# 	su $WAKINGUSER -c 'export DISPLAY=:0 ; xinput query-state "Logitech USB Laser Mouse"' 2> /dev/null
# 	if [ "$?" == "0" ]
# 	then
# 	    echo "--> resetting mouse state..." >> /var/log/wakeuplogitech.log 2>&1
# 	    su $WAKINGUSER -c "export DISPLAY=:0 ; xinput --set-button-map 'Logitech USB Laser Mouse' 1 2 3 4 5 6 2 8 9" >> /var/log/wakeuplogitech.log 2>&1
# 	fi
#         ;;
#     *)

#         ;;
# esac

xinput query-state "Logitech USB Laser Mouse" > /dev/null 2>&1
if [ "$?" == "0" ]
then
    notify-send -t 1 "Logitech Mouse Setup"
    xinput --set-button-map 'Logitech USB Laser Mouse' 1 2 3 4 5 6 2 8 9
else
    notify-send -t 1 "No Logitech Mouse Attached"
fi
