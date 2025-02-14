#!/bin/sh
#
# Place this script in your KDE Autostart folder and it will automatically run
# /usr/bin/kinit using passwords from kwallet. Alternatively for Plasms 5, use
# KDE event notifications to run this (or a wrapper) as a script. For Plasma 6
# use a script within /etc/NetworkManager/dispatcher.d e.g.
#
# #!/bin/bash
# IF=$1
# STATUS=$2
# LOG='/var/log/NetworkManager_dispatcher.d.log'
# echo "$(date +"%F %T") Called with ($*) and connection uuid is: ${CONNECTION_UUID}" > ${LOG}
# if [ "$1" = "tun0" ] && [ "$2" = "up" ] ; then
#     echo "VPN is up!" >> ${LOG}
#     sudo --non-interactive --set-home -u rnc /home/rnc/bin/kerberosKWallet.sh >> ${LOG}
# fi
#
#
# By default this will use $USER as the id for kinit. To use an alternative ID
# create a $HOME/.kerberoskwallet containing
# USER=<id>
#
#
# Nick Cross
#
# Credits : found a lot here
# http://learnonthejob.blogspot.com/2009/11/accessing-kde-wallet-from-cmdline.html
#
echo "Running kerberosKWallet" > /tmp/vpn.log
echo "Using user $(id) with ID $(id -u)" >> /tmp/vpn.log

export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus

KEY=KerberosWallet
WALLETID=$(qdbus-qt5 org.kde.kwalletd5 /modules/kwalletd5 org.kde.KWallet.open kdewallet 0 $KEY)
if [ "$?" != 0 ]
then
    kdialog --error "Timed out retrieving password ; rerun $0"
    exit 1
fi
echo "Attempting to read wallet password with \"qdbus-qt5 org.kde.kwalletd5 /modules/kwalletd5 readPassword $WALLETID Passwords $KEY $KEY\"" >> /tmp/vpn.log
PASSWORD=$(qdbus-qt5 org.kde.kwalletd5 /modules/kwalletd5 readPassword $WALLETID Passwords $KEY $KEY)
#By default assume that the password was fetched from KDE Wallet
PASSWORD_FETCHED=-1

if [ -f $HOME/.kerberoskwallet ]
then
    KUSER=$(grep USER $HOME/.kerberoskwallet | sed 's/.*=//' | tr -d '[:blank:]')
fi

if [ -z "$PASSWORD" ]; then
    PASSWORD=$(kdialog --title "Kerberos Password" --password "Please enter passphrase for kinit")
    PASSWORD_FETCHED=$?
fi
if ! grep -q "default_ccache_name" /etc/krb5.conf
then
    # Force location on machines without persistent cache for Kerberos cache. Useful to workaround problems with puddle generation.
    KRB5CCNAME=/tmp/"$USER"_ccache
fi

checkKinit()
{
    while read data
    do
        if [ -n "$data" ]
        then
            kdialog --title "Kerberos Credentials Error" --error "$data"
            exit 1
        fi
    done
}

if [ $? != "1" ]
then
    if [ -z "$PASSWORD" ]
    then
        kdialog --error "Blank password; unable to run kinit"
        exit 1
    elif [ "$PASSWORD_FETCHED" != "-1" ]; then
        qdbus-qt5 org.kde.kwalletd5 /modules/kwalletd5 writePassword $WALLETID Passwords $KEY $PASSWORD $KEY
        if [ $? = 1 ]
        then
            kdialog --error "Failed to write password"
        fi
    fi
    kinit -A "$KUSER" &> /dev/null <<EOF 3>&1 1>&2 2>&3 | checkKinit
$PASSWORD
EOF
    notify-send "Kerberos configured till $(klist | grep krbtgt | awk '{print $3 " " $4}')"
fi
