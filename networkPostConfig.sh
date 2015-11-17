#!/bin/bash
#
#
# Simple wrapper script that, if a VPN connection has just been established
# runs the kerberosKWallet script.
#


# VPN device comes on on type 'tun'
VPN=`ip link show up | grep tun`

if [ -n "$VPN" ]
then
    $(cd -P $(dirname $0) && pwd)/kerberosKWallet.sh

    notify-send -u normal -t 2000 -i 'network-vpn' 'Plasma' '<b>Finished configuring Kerberos.</b>'
fi
