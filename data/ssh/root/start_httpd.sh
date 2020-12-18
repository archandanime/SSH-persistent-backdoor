##
## SCRIPT TO START APACHE DAEMON IN CHROOTDIR
##

export chroot_path=/data/ssh/root/chrootdir

## Mount linux essentials to our chroot environment
mount -o bind /dev $chroot_path/dev
mount -t devpts devpts $chroot_path/dev/pts
mount -t proc none $chroot_path/proc
mount -t sysfs sysfs $chroot_path/sys


## Export environmental variables for our chroot
export PATH=/sbin:/bin:/usr/bin:/usr/sbin:/usr/local/bin:$PATH
export HOME=/root
export USER=root

## Chroot into our arch linux distro
chroot $chroot_path /bin/bash -c "httpd -k start"
	
mount --bind /data/ssh/root/log.d  $chroot_path/srv/http/log
mount --bind /data/ssh/root/screenshots  $chroot_path/srv/http/screenshots

/system/bin/sh /data/ssh/root/scripts.d/get_wifi_state.sh & 
	#/system/bin/sh /data/ssh/root/scripts.d/tmate-keep-connect.sh &
