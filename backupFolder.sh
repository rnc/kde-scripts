#
# Will backup a specified folder removing backups older than 1 week.
# Ideally run in conjunction with daily or weekly crontab.

BASEDIR="$1"
DESTDIR="$2"
BASENAME=`basename "$BASEDIR"`
TGZFILE="$BASENAME-`date +"%d-%m-%Y"`.tgz"
ROTATE=7

if [ ! -d "$BASEDIR" ] || [ ! -d "$DESTDIR" ] ; then
    echo "source or destination folder doesn't exist"
    exit 0;
fi

echo "Source Folder : $BASEDIR"
echo "Target Folder : $DESTDIR"
echo "Backup file : $TGZFILE "

cd "$BASEDIR"
tar czf "$DESTDIR"/"$TGZFILE" *

OUTPUT=$(find "$DESTDIR" -mtime +$ROTATE -type f | sed 's/^/\t/')
if [ -n "$OUTPUT" ]
then
    echo -e "Will delete:\n$OUTPUT"
    find "$DESTDIR" -mtime +$ROTATE -exec rm {} \;
fi
