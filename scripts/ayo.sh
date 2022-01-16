#!/bin/sh -e

# This is very much a work in progress

echo "Ayo, I'm at your service"

RAMMOUNT='/run/media/jlxip/ram'

case "$1" in
	poweroff)
		poweroff
	;;
	ram)
		mkdir -p $RAMMOUNT
		mount -t ramfs -o size=1G ramfs $RAMMOUNT
		chown -R jlxip:jlxip $RAMMOUNT
		chmod -R 0700 $RAMMOUNT
		sudo -u jlxip nautilus $RAMMOUNT
	;;
	unram)
		sudo umount $RAMMOUNT
	;;
esac
