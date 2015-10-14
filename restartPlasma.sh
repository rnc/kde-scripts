#!/bin/bash


notify-send -u critical -t 5000 -i 'security-low' 'KRunner' '<b>Restarting KRunner...</b>'
kquitapp krunner && kstart krunner
while [ -z $(pidof krunner) ]
do
    sleep 1
done
sleep 2
notify-send -u critical -t 2000 -i 'security-low' 'KRunning' '<b>Finishing restarting KRunner.</b>'

sleep 3
notify-send -u critical -t 5000 -i 'security-low' 'Plasma' '<b>Restarting Plasma...</b>'
kbuildsycoca5 && kquitapp plasmashell && kstart plasmashell

while [ -z $(pidof plasmashell) ]
do
    sleep 2
done
sleep 5
notify-send -u critical -t 2000 -i 'security-low' 'Plasma' '<b>Finishing restarting Plasma.</b>'
