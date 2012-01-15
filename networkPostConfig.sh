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
    $HOME/bin/kerberosKWallet.sh
fi
