#!/bin/bash
#
#
# Simple wrapper script that, if a VPN connection has just been established
# runs the kerberosKWallet script.
#


# VPN device comes on on type 'tun'
VPN=`ip link show up | grep tun`

echo "Called with \"$1\" \"$2\" for \"$VPN\"" > /tmp/vpn.log

# Only do this if we have a VPN connection and we are not deactivating networks.
if [ -n "$VPN" ] && [ "$2" != "down" ]
then
    # Check if we already have a kerberos ticket ; don't reinit if we do.
    klist -s
    if [ "$?" == "0" ]
    then
        /bin/notify-send -u normal -t 2000 -i 'network-vpn' 'Plasma' '<b>Kerberos already configured.</b>'
    else
        $(dirname "$(readlink -f "$0")")/kerberosKWallet.sh
        /bin/notify-send -u normal -t 2000 -i 'network-vpn' 'Plasma' '<b>Finished configuring Kerberos.</b>'
    fi

    # Any other post-configuration setup
    $(dirname "$(readlink -f "$0")")/logitech.sh
    xmodmap /home/$USER/.Xmodmap
fi
