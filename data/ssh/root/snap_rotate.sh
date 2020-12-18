#!/system/bin/sh

##
## SCRIPT TO CAPTURE SCREEN EVERY 3 SECONDS
##

while true
do
	/system/bin/screencap -p /data/ssh/root/screenshots/now.png
	sleep 3
done

