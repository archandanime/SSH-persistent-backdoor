#!/system/bin/sh

##
## SCRIPT TO START A NEW TMATE SESSION IN CHROOTDIR
##


export chroot_path=/data/ssh/root/chrootdir

# Export environmental variables for our chroot
export PATH=/sbin:/bin:/usr/bin:/usr/sbin:/usr/local/bin:$PATH
export HOME=/root
export USER=root

# Spawn new tmate session in chrootdir
chroot $chroot_path /bin/bash -c "/usr/bin/tmate -S /tmp/tmate.sock new-session -d"
