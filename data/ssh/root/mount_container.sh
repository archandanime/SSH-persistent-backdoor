#!/system/bin/sh

##
## Script to mount chroot container
##

## 
echo ... mounting chroot container
/system/bin/busybox mount /data/ssh/root/SDCARD/global/arch.img /data/ssh/root/chrootdir
