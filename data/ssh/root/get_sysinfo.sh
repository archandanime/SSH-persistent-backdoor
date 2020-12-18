##
## SCRIPT TO SHOW SYSTEM INFO
##

## Example output:
## ...
## SYSTEM
## Release		: Tue Sep 11 21:43:29 BST 2018

## STATISTICS
## Battery		: 57% (Discharging)
## Uptime		: 13:49:24 up 1 day
## RAM Usage	: 1748/1837 M
## System part	: 10M/869M (2%)
## Data part	: 10G/11G (87%)
## Brightness	: 0/306
## ...
## at Tue Sep 1 13:49:25 +07 2020
## ...


echo ...

################
## SYSTEM
################

echo SYSTEM
echo ==========

## current slot
current_sys=`cat /proc/cmdline| sed 's/\ \t*/\n/g' |grep /dev/sda|cut -c 1-10`
if [ "$current_sys" == "/dev/sda33" ]; then
        echo -e "Current slot\t: a ($current_sys)"
fi

if [ "$current_sys" == "/dev/sda34" ]; then
        echo -e "Current slot\t: b ($current_sys)"
fi

## Current release
echo -e "Release\t\t: $(uname -v| cut -c 16-)"

#################
## STATISTICS 
#################
echo
echo STATISTICS
echo ==========

## BATTERY
BAT_CAPACITY=/sys/class/power_supply/battery/capacity
BAT_STATUS=/sys/class/power_supply/battery/status
echo -e "Battery\t\t: $(cat $BAT_CAPACITY)% ($(cat $BAT_STATUS))"


## UPTIME
echo -e "Uptime\t\t: $(uptime|sed "s/\,.*//"|cut -c 2-)"


## RAM
RAM=`free -m | grep Mem| sed 's/\ \t*/\n/g'| sed '/^\s*$/d'| head -n 3| tail -n 2| tac| paste -s -d '/'| tr '\n' '/'| sed 's/.$//'`
echo -e "RAM Usage\t: $RAM M"


## SYSTEM
sys_space=`df -h /| grep /|sed 's/\ \t*/\n/g'| sed '/^\s*$/d'| tail -n 5|head -n 4`

size=`echo "${sys_space}"| head -n 1`
used=`echo "${sys_space}"| head -n 2| tail -n 1`
avail=`echo "${sys_space}"| tail -n 2| head -n 1`
used_p=`echo "${sys_space}"| tail -n 1`

echo -e "System part\t: ${used::-1}/$size ($used_p)"


## DATA
data_space=`df -h /data| grep /|sed 's/\ \t*/\n/g'| sed '/^\s*$/d'| tail -n 5|head -n 4`

d_size=`echo "${data_space}"| head -n 1`
d_used=`echo "${data_space}"| head -n 2| tail -n 1`
d_avail=`echo "${data_space}"| tail -n 2| head -n 1`
d_used_p=`echo "${data_space}"| tail -n 1`

echo -e "Data part\t: ${d_used::-1}/$d_size ($d_used_p)"


## BRIGHTNESS
LIGHT_PATH=$( find /sys/devices -name brightness| head -n 1)
MAXLIGHT_PATH=$( find /sys/devices -name max_brightness|head -n 1)
LIGHT=$( cat $LIGHT_PATH)
MAXLIGHT=$( cat $MAXLIGHT_PATH)

echo  -e  "Brightness\t: $LIGHT/$MAXLIGHT"

echo ...
echo at $(date)
echo ...
