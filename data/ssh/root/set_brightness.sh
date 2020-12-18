#!/system/bin/sh

##
## SCRIPT TO SET SCREEN BRIGHTNESS
##


## Read desired brightness
bright_level=$1

## Find (max) brightness path and values
LIGHT_PATH=$( find /sys/devices -name brightness| head -n 1)
MAXLIGHT_PATH=$( find /sys/devices -name max_brightness|head -n 1)
LIGHT=$( cat $LIGHT_PATH)
MAXLIGHT=$( cat $MAXLIGHT_PATH)


## Set brightness
echo Current brightness: $LIGHT
if [ "$bright_level" -le "$MAXLIGHT" ] && [ "$bright_level" -gt "0" ]; then
	echo $bright_level  > $LIGHT_PATH
	echo Set brightness: $bright_level
else
	echo Invalid brightness value
fi
