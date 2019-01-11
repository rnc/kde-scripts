#!/bin/bash
#
# This script is for KDE with Firefox and FlashGot. It requires the following FlashGot
# settings:
#
# Custom download manager pointing to this script with the following command line arguments:
#   Type [FOLDER] [REFERER] [CFILE] [URL]
#
# where type is either axel or aria2c
#
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

[[ "$1" = "axel" ]] && downloader=axel
shift

konsole=$(qdbus-qt5 | grep konsole | sed 's/[^0-9]//g' | tail -1)
if [ -z "$konsole" ]
then
    konsole=org.kde.konsole
else
    konsole=org.kde.konsole-$konsole
fi
window=`qdbus-qt5 org.kde.konsole-1910 | grep "Windows/" | sed -E 's/.*([0-9])/\1/g'`


session=$(qdbus-qt5 ${konsole} /Windows/$window newSession)
qdbus-qt5 ${konsole} /Sessions/${session} setTitle 1 Download
qdbus-qt5 ${konsole} /Sessions/${session} sendText "echo Attempting to download $4"
qdbus-qt5 ${konsole} /Sessions/${session} sendText "
"

if [ "$downloader" = "axel" ]
then
    qdbus-qt5 ${konsole} /Sessions/${session} sendText "echo Downloading using axel"
    qdbus-qt5 ${konsole} /Sessions/${session} sendText "
"
    qdbus-qt5 ${konsole} /Sessions/${session} sendText "axel --num-connections=25 --alternate --output=\"$1\"/`basename \"$4\"` \"$4\"
"
else
    qdbus-qt5 ${konsole} /Sessions/${session} sendText "echo Downloading using aria2c"
    qdbus-qt5 ${konsole} /Sessions/${session} sendText "
"
    qdbus-qt5 ${konsole} /Sessions/${session} sendText "aria2c --min-split-size=1M --max-connection-per-server=16 --split=25 --max-concurrent-downloads=25 --summary-interval=0 --truncate-console-readout=false --check-certificate=false --continue -d $1 --referer=\"$2\" --load-cookies=\"$3\" \"$4\"
"
fi

qdbus-qt5 ${konsole} /Sessions/${session} sendText "echo \"Press [Enter] key to exit...\" && read && exit
"
