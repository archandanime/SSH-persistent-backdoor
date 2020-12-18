#!/system/bin/sh

logfile=/data/ssh/root/log.d/wifi-state.log
function get_time ()                                                                                                                                                                                  
{                                                                                                                                                                                                     
#Usage: echo $(get_time) $command >> $logfile

        echo -n -e " $(date +%b\ %d\ %H:%M:%S )        ";                                                                                                                                                
}

while true
do
	wifi_state=`dumpsys wifi | grep "mNetworkInfo"| tr  ',' '\n'| grep -e state -e extra| tr -d '\n'`
	echo $(get_time) $wifi_state >> $logfile
	sleep 600
done
