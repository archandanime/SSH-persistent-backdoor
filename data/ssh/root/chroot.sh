#!/system/bin/sh

##
## SCRIPTS TO ENTER CHROOTDIR VIA COMMANDLINE
##


export chroot_path=/data/ssh/root/chrootdir

## Export environmental variables for our chroot
export PATH=/sbin:/bin:/usr/bin:/usr/sbin:/usr/local/bin:$PATH
export HOME=/root
export USER=root


## Chroot into our arch linux distro
chroot $chroot_path /bin/bash
