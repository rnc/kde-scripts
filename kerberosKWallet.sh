#!/bin/sh
#
# Place this script in your KDE Autostart folder and it will automatically run
# /usr/bin/kinit using passwords from kwallet.  Alternatively use KDE event
# notifications to run this (or a wrapper) as a script.
# By default this will use $USER as the id for kinit. To use an alternative ID
# create a $HOME/.kerberoskwallet containing
# USER=<id>
#
#
#
# Nick Cross
#
# Credits : found a lot here
# http://learnonthejob.blogspot.com/2009/11/accessing-kde-wallet-from-cmdline.html
#

KEY=KerberosWallet
WALLETID=$(qdbus org.kde.kwalletd /modules/kwalletd org.kde.KWallet.open kdewallet 0 $KEY)
PASSWORD=$(qdbus org.kde.kwalletd /modules/kwalletd readPassword $WALLETID Passwords $KEY $KEY)
#By default assume that the password was fetched from KDE Wallet
PASSWORD_FETCHED=-1

if [ -f $HOME/.kerberoskwallet ]
then
    USER=`cat $HOME/.kerberoskwallet | grep USER | sed 's/.*=//' | tr -d '[:blank:]'`
fi

if [ -z "$PASSWORD" ]; then
    PASSWORD=$(kdialog --title "Kerberos Password" --password "Please enter passphrase for kinit")
    PASSWORD_FETCHED=$?
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
        qdbus org.kde.kwalletd /modules/kwalletd writePassword $WALLETID Passwords $KEY $PASSWORD $KEY
        if [ $? = 1 ]
        then
            kdialog --error "Failed to write password"
        fi
    fi
    kinit -A $USER <<EOF 3>&1 1>&2 2>&3 | checkKinit
$PASSWORD
EOF
fi
