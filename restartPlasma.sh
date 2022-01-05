#!/bin/bash


notify-send -u critical -t 5000 -i 'security-low' 'KScreen' '<b>Notifying kscreen...</b>'
kscreen-console bug &> /tmp/kscreen-console-`date "+%Y-%m-%d_%H:%M:%S"`.log
sleep 3
notify-send -u critical -t 2000 -i 'security-low' 'KScreen' '<b>Finishing notifying kscreen.</b>'

notify-send -u critical -t 5000 -i 'security-low' 'KRunner' '<b>Restarting KRunner...</b>'

kquitapp5 krunner
kstart5 krunner
while [ -z "$(pidof krunner)" ]
do
    sleep 1
done

sleep 2
notify-send -u critical -t 2000 -i 'security-low' 'KRunner' '<b>Finishing restarting KRunner.</b>'
sleep 2
notify-send -u critical -t 5000 -i 'security-low' 'Plasma' '<b>Restarting Plasma...</b>'
sleep 2

kbuildsycoca5
kquitapp5 plasmashell
kstart5 plasmashell
while [ -z "$(pidof plasmashell)" ]
do
    sleep 1
done
sleep 5

notify-send -u critical -t 2000 -i 'security-low' 'Plasma' '<b>Finishing restarting Plasma.</b>'
