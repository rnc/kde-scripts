#!/bin/bash


notify-send -u critical -t 5000 -i 'security-low' 'KRunner' '<b>Restarting KRunner...</b>'

kquitapp krunner && kstart krunner
while [ -z "$(pidof krunner)" ]
do
    sleep 1
done

sleep 2
notify-send -u critical -t 2000 -i 'security-low' 'KRunner' '<b>Finishing restarting KRunner.</b>'
sleep 2
notify-send -u critical -t 5000 -i 'security-low' 'Plasma' '<b>Restarting Plasma...</b>'
sleep 2

kbuildsycoca5 && kquitapp plasmashell && kstart plasmashell
while [ -z "$(pidof plasmashell)" ]
do
    sleep 1
done
sleep 5

notify-send -u critical -t 2000 -i 'security-low' 'Plasma' '<b>Finishing restarting Plasma.</b>'
