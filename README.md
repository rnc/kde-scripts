Utility KDE Scripts
===================

This project contains various KDE scripts for integrating KWallet with SSH and Kerberos automatically. They have been tested on KDE 5 on Fedora F22.

Installation
------------

* The _addSSHKeys.sh_ file should be placed (or a symbolic link made to it) within `$HOME/.config/autostart` for KDE5. It will automatically load all SSH keys on startup. Note that this has a dependency on ksshaskpass which may be installed using `dnf install ksshaskpass`.

* The _networkPostConfig.sh_ script is an example script that may be used to run events post network activation. By default it looks for a VPN tunnel connection and then runs _kerberosKWallet.sh)_, _logitech.sh_ and _Xmodmap_. To install this script either
   * Use KDE Notifications
      * Left click on the Network icon on the panel and click on 'Manage Connections'.
      * Click on 'Other' and 'Configure Notifications'
      * Scroll down to 'Network Connection Succeeded' and place a tick in 'Run Command'
      * Fill in the full path to this script.

Previously this could have also been setup from using `NetworkManager/dispatcher.d` but using the notification system is simpler and more maintainable.
* The _kerberosKWallet.sh_ script provides integration between KWallet and Kerberos (specifically /usr/bin/kinit). It can be used to automatically 'obtain and cache Kerberos ticket-granting ticket' using passwords from KWallet. The path in KDE Wallet Manager is `Passwords/KerberosWallet`. (Note: You **may** have to create the KerberosWallet entry). Utilise _networkPostConfig.sh_ script to run this as described above. This script should automatically ask for the password and if it does not already exist it will write one to that entry. Finally, it will call kinit with the password.

* The _logitech.sh_ is a configuration file to reset a Logitech mouse buttons. **NOT USED/WORKING**

* The _.Xmodmap_ is a configuration file for keybindings to reset the Caps Lock key so it behaves as follows:
    * Functions as Control key normally.
    * With Shift functions as Caps Lock.

* The _konsole.css_ is a CSS file for Konsole terminal emulator to improve the tab display.
