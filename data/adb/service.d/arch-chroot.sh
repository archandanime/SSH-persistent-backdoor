#!/bin/bash

##
## SCRIPT TO MOUNT CHROOT CONTAINER AND START APACHE DAEMON
##

mount_container=NO

chroot_apache () {
#echo ...
## mount sdcard at /data/ssh/root/SDCARD before the system does
#echo ...mounting block device /dev/block/mmcblk1p1 to /data/ssh/root/SDCARD
/system/bin/busybox mount /dev/block/mmcblk1p1 /data/ssh/root/SDCARD

## to mount the chroot container
#echo ...mounting chroot container /data/ssh/root/SDCARD/global/arch.img to /data/ssh/root/chrootdir
/system/bin/busybox mount /data/ssh/root/SDCARD/global/arch.img /data/ssh/root/chrootdir

## start apache daemon
#echo ...starting apache daemond inside the container
/system/bin/sh /data/ssh/root/start_httpd.sh
}

[[ "$mount_container" == "YES" ]] && chroot_apache
