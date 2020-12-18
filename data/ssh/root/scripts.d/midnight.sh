#!/bin/bash
# script to turn on wifi at midnight

keep_on=0
function get_time ()
{
	echo -n -e " $(date +%b\ %d\ %H:%M:%S )\t\t ";
}

function wake_up ()
{
echo $(get_time) "function midnight started" >> /data/ssh/root/log/midnight.log
echo $(get_time) waiting >> /data/ssh/root/log/midnight.log
echo $(get_time) >> /data/ssh/root/log/midnight.log
 
today=$(date +%d)
next_day=$(date +%d)
	while [ "$today" = "$next_day" ]	#if day is NOT changed
	do
		sleep 60	#keep waiting until day is changed
		next_day=$(date +%d)
		sed -i '$ d' /data/ssh/root/log/midnight.log
		echo $(get_time) still waiting... >> /data/ssh/root/log/midnight.log
	done
svc wifi enable
echo $(get_time) Toggling wifi ON >> /data/ssh/root/log/midnight.log
sleep 10
echo $(get_time) $(dumpsys wifi|grep mNetworkInfo) >> /data/ssh/root/log/midnight.log
}

function to_sleep ()
{
echo $(get_time) "function wake_up started" >> /data/ssh/root/log/midnight.log
echo $(get_time) waiting >> /data/ssh/root/log/midnight.log
echo $(get_time) >> /data/ssh/root/log/midnight.log
	while [ ! "$(date +%H)" = "04" ]	#keep waiting ulti it reaches 4am
	do
		sleep 60
                sed -i '$ d' /data/ssh/root/log/midnight.log                       
                echo $(get_time) still waiting... >> /data/ssh/root/log/midnight.log
	done

if [ "$keep_on" = "0" ]; then
echo $(get_time) Toggling wifi OFF >> /data/ssh/root/log/midnight.log
	svc wifi disable
	sleep 5
else
	echo "$(get_time) Previous wifi state is ON, no need to turn off" >> /data/ssh/root/log/midnight.log
fi

echo $(get_time) $(dumpsys wifi|grep mNetworkInfo) >> /data/ssh/root/log/midnight.log
}


#=== BEGIN ===
echo Started logging at $(date)  >> /data/ssh/root/log/midnight.log
while true
do
	wake_up
	to_sleep
	echo $(get_time) --- >> /data/ssh/root/log/midnight.log
	sleep 68400	# = 19x3600 wait 19 hour to 23:00
	if  $(curl -Is --output /dev/null http://example.com ); then
		keep_on=1
	else
		keep_on=0
	fi
done
