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

UUIDS=`nmcli con show | grep OpenVPN | tr -s ' ' | cut -d' ' -f 4`

echo "Parsing `nmcli con show`"
echo -e "\nFound connection information of\n$UUIDS"

for i in `echo $UUIDS`
do
    nmcli con modify $i +vpn.data username=$1
    echo -e "Modifying for $i vpn.data \n`nmcli con show $i | grep vpn.data | sed 's/vpn.data:                               / /g' | tr ',' '\n'`"
done

echo "Reloading connection information..."
sudo nmcli c r
