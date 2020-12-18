#!/system/bin/sh

export mnt=/data/ssh/root/chroot-mountpoint

# export environmental variables for our chroot
export PATH=/sbin:/bin:/usr/bin:/usr/sbin:/usr/local/bin:$PATH
export HOME=/root
export USER=root

#chroot into our arch linux distro

mnt=/data/ssh/root/chroot-mountpoint
logfile=/data/ssh/root/log/tmate.log
function get_time ()                                                           
{
#Usage: echo $(get_time) $command >> $logfile

        echo -n -e " $(date +%b\ %d\ %H:%M:%S )        ";
}



if [[ -f $mnt/tmp/tmate.sock ]]; then
        rm $mnt/tmp/tmate.sock
fi
while true
do
	if [[ ! -f $mnt/tmp/tmate.sock ]]; then
		echo $(get_time) Spawning new session...  >> $logfile
		chroot $mnt /bin/bash -c "/usr/bin/tmate -S /tmp/tmate.sock new-session -d"
		sleep 10
	fi
done
