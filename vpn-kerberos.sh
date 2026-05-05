#!/bin/bash

IF=$1
STATUS=$2

LOG='/var/log/NetworkManager_dispatcher.d.log'

# DEBUG
echo "$(date +"%F %T") Called with ($*) and connection uuid is: ${CONNECTION_UUID}" > ${LOG}

# Needed only if you need to display notification popups
#export DISPLAY=:0.0
#export $(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep session)/environ)

if [ "$1" = "tun0" ] && [ "$2" = "up" ] ; then
    echo "VPN is up!" >> ${LOG}
    sudo --non-interactive --set-home -u rnc /home/rnc/bin/kerberosKWallet.sh >> ${LOG}
fi
