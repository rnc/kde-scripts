#!/bin/bash
#
# Short script to use ksshaskpass (http://kde-apps.org/content/show.php?content=50971)
# to add all default SSH identities
#
echo "addSSHKeys: wallet is `qdbus-qt6 org.kde.kwalletd6 /modules/kwalletd6 org.kde.KWallet.isOpen kdewallet`" > /tmp/addsshkeys
sleep 10s
if [ ! -d $HOME/.ssh ]; then
    echo "SSH directory not mounted" >> /tmp/addsshkeys
    while [ ! -d $HOME/.ssh ]; do
        echo "Sleeping till ssh mounted..."  >> /tmp/addsshkeys
        sleep 30s
    done
fi

export SSH_ASKPASS=/usr/bin/ksshaskpass
# Add default
ssh-add >> /tmp/addsshkeys

# Add all others that I can find.
for i in `find -L $HOME/.ssh -name "id*" | grep -v "\.pub"`
do
    ssh-add $i < /dev/null >> /tmp/addsshkeys
done
ssh-add -l  >> /tmp/addsshkeys
