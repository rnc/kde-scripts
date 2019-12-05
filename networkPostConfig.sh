#!/bin/bash
#
#
# Simple wrapper script that, if a VPN connection has just been established
# runs the kerberosKWallet script.
#


# VPN device comes on on type 'tun'
VPN=`ip link show up | grep tun`

echo "On `date` called as user $USER with display $DISPLAY with parameters \"$1\" \"$2\" for \"$VPN\"" > /tmp/vpn.log

if [ -z "$VPN" ]
then
    sleep 5
    VPN=`ip link show up | grep tun`
    echo "Calling again with \"$1\" \"$2\" for \"$VPN\"" >> /tmp/vpn.log
fi

xmodmap /home/$USER/.Xmodmap

# Only do this if we have a VPN connection and we are not deactivating networks.
if [ -n "$VPN" ] && [ "$2" != "down" ]
then
    # Check if we already have a kerberos ticket ; don't reinit if we do.
    echo "Performing kerberos setup..." >> /tmp/vpn.log
    if klist -s
    then
        /bin/notify-send -u normal -t 2000 -i 'network-vpn' 'Plasma' '<b>Kerberos already configured.</b>'
    else
        echo "Configuring kerberos..." >> /tmp/vpn.log
        $(dirname "$(readlink -f "$0")")/kerberosKWallet.sh
        /bin/notify-send -u normal -t 2000 -i 'network-vpn' 'Plasma' '<b>Finished configuring Kerberos.</b>'
    fi
fi
