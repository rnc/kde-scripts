Utility KDE Scripts
===================

This project contains my KDE scripts that I use to integrate KWallet with SSH and Kerberos automatically. They have been tested on KDE 4.7.4 on Fedora F16.

Installation
------------

* The `addSSHKeys.sh` file should be placed (or a symbolic link made to it) within `$HOME/.kde4/Autostart` folder. It will automatically load all SSH keys on startup. Note that this has a dependency on ksshaskpass which may be installed using `yum install ksshaskpass`.

* The networkPostConfig.sh script is an example script that may be used to run events post network activation. By default it looks for a VPN tunnel connection and then runs `$HOME/bin/kerberosKWallet.sh`. To install this script
    * Left click on the Network icon on the panel and click on 'Manage Connections'.
    * Click on 'Other' and 'Configure Notifications'
    * Scroll down to 'Network Connection Succeeded' and place a tick in 'Run Command'
    * Fill in the full path to this script.
