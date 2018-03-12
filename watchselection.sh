#!/bin/bash


sel=$(xsel)
selnew=""

while true; do
	selnew=$(xsel)
	if [ "$sel" != "$selnew" ]; then
		echo $selnew
		./lookup-popup.sh $selnew
	fi
	sel=$selnew
	sleep 1
done

