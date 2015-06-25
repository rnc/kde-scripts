Utility KDE Scripts
===================

This project contains various KDE scripts. They are for integrating KWallet with SSH and Kerberos automatically, to integrate Firefox downloads with Konsole and a configuration file for Yasp (http://kde-look.org/content/show.php?content=109367). They have been tested on KDE 5 on Fedora F22.

Installation
------------

* The _addSSHKeys.sh_ file should be placed (or a symbolic link made to it) within `$HOME/.kde4/Autostart` folder for KDE4. For KDE 5 the sample sshAdd.desktop should be appropriately editing and placed in `$HOME/.config/autostart`. It will automatically load all SSH keys on startup. Note that this has a dependency on ksshaskpass which may be installed using `dnf install ksshaskpass`.

* The _networkPostConfig.sh_ script is an example script that may be used to run events post network activation. By default it looks for a VPN tunnel connection and then runs `$HOME/bin/kerberosKWallet.sh`. To install this script
    * Left click on the Network icon on the panel and click on 'Manage Connections'.
    * Click on 'Other' and 'Configure Notifications'
    * Scroll down to 'Network Connection Succeeded' and place a tick in 'Run Command'
    * Fill in the full path to this script.

* The _kerberosKWallet.sh_ script provides integration between KWallet and Kerberos (specifically /usr/bin/kinit). It can be used to automatically 'obtain and cache Kerberos ticket-granting ticket' using passwords from KWallet. The path in KDE Wallet Manager is `Passwords/KerberosWallet`. (Note: You **may** have to create the KerberosWallet entry). Either place this inside `$HOME/.kde4/Autostart` (under KDE4) or utilise _networkPostConfig.sh_ script as described above. This script should automatically ask for the password and if it does not already exist it will write one to that entry. Finally, it will call kinit with the password.

* The _konsoleDownload.sh_ script provides integration between Firefox using the FlashGot downloader and axel/aria2c to open up a new tab in a konsole session. This allows axel/aria2c to perform the downloads (which are much quicker) rather than the Firefox internal mechanism.

* The _.yasp\_script_ is a configuration file for the Yasp plasma applet.

* The _logitech.sh_ is a configuration file to reset a Logitech mouse buttons.
