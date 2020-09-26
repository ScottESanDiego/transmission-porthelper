#!/bin/bash

trap 'exit 0' SIGTERM

OLDPORT=0
PORT=0

while true
do
	[ -r "/pia-shared/port.dat" ] && PORT=$(cat /pia-shared/port.dat)

	if [ $OLDPORT -ne $PORT ]; then
		echo "Setting Transmission port to ($PORT)."
		transmission-remote -n $USER:$PASS -p $PORT
		OLDPORT=$PORT
	fi

	inotifywait --event modify --event create /pia-shared
done
