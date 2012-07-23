#!/bin/bash
#
# This script is for KDE with Firefox and FlashGot. It requires the following FlashGot
# settings:
#
# Custom download manager pointing to this script with the following command line arguments:
#   [FOLDER] [REFERER] [CFILE] [URL]
# FlashGot recommended settings:
#   Enable the above download manager to be shown in the context menu.
#   Menu:
#      Enable FlashGot, FlashGot Options, Hide Disabled Commands and Compact context menu.
#      Disable everything else.
#   Downloads
#      Enable intercept all downloads.
#   Privacy
#      Enable send autodetected referrer URL and cookies.
#

echo "$@"

session=$(qdbus org.kde.konsole /Konsole newSession)
qdbus org.kde.konsole /Sessions/${session} setTitle 1 Download
qdbus org.kde.konsole /Sessions/${session} sendText "echo Attempting to download $4"
qdbus org.kde.konsole /Sessions/${session} sendText "
"
qdbus org.kde.konsole /Sessions/${session} sendText "aria2c --min-split-size=1M --max-connection-per-server=16 --split=25 --max-concurrent-downloads=25 --summary-interval=0 --truncate-console-readout=false --check-certificate=false --continue -d $1 --referer=\"$2\" --load-cookies=\"$3\" \"$4\"
"
qdbus org.kde.konsole /Sessions/${session} sendText "echo \"Press [Enter] key to exit...\" && read && exit
"
