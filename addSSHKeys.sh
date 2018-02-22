#!/bin/bash
#
# Short script to use ksshaskpass (http://kde-apps.org/content/show.php?content=50971)
# to add all default SSH identities
#

export SSH_ASKPASS=/usr/bin/ksshaskpass
# Add default
ssh-add

# Add all others that I can find.
for i in `find $HOME/.ssh -name "id*" | grep -v "\.pub"`
do
    ssh-add $i < /dev/null
done
