#!/bin/sh
#
# Trivial script to patch openvpn config files to add a username. This is typically useful if
# ovpn config files are sourced from a yum repository, but your default username is different to
# corporate username.
#
#

if [ -z "$1" ]
then
    echo "Pass in username"
    exit 1
fi

UUIDS=`nmcli -t -f uuid,type con show | grep vpn | cut -d ":" -f1`

echo -e "Parsing\n`nmcli con show`"
echo -e "\nFound connection information of\n$UUIDS"

for i in `echo $UUIDS`
do
    if [ -n "`nmcli con show $i | grep vpn.data | grep redhat.com`" ]
    then
        nmcli con modify $i +vpn.data username=$1
        echo -e "Modifying for $i vpn.data \n`nmcli con show $i | grep vpn.data | sed 's/vpn.data:                               / /g' | tr ',' '\n'`"
    else
        echo "Ignoring connection $i"
    fi
done

echo "Reloading connection information..."
sudo nmcli c r
