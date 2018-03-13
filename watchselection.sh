#!/bin/bash
#check xsel output every second, and if changed, execute lookup-popup

sel=$(xsel)
selnew=""

while true; do
	selnew=$(xsel)
	if [ "$sel" != "$selnew" ]; then
		$HOME/projects/lookup-popup/lookup-popup.sh $selnew
	fi
	sel=$selnew
	sleep 1
done

