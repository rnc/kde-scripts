#!/bin/bash
#
# Short script to use ksshaskpass (http://kde-apps.org/content/show.php?content=50971)
# to add all default SSH identities
#

echo "Wallet is `qdbus-qt5 org.kde.kwalletd5 /modules/kwalletd5 org.kde.KWallet.isOpen kdewallet`" > /tmp/kdewalletstatus

export SSH_ASKPASS=/usr/bin/ksshaskpass
# Add default
ssh-add

# Add all others that I can find.
for i in `find $HOME/.ssh -name "id*" | grep -v "\.pub"`
do
    ssh-add $i < /dev/null
done
