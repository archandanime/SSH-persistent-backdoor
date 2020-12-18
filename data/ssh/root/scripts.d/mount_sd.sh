#!/system/bin/sh

##
## SCRIPT TO ALLOW SDCARD TO BE USED MORMALLY
##

##
mkdir /mnt/media_rw/9016-4EF8
chmod 770 /mnt/media_rw/9016-4EF8
chown media_rw:media_rw /mnt/media_rw/9016-4EF8

##
mkdir /storage/9016-4EF8
chmod 771 /storage/9016-4EF8
chown root:sdcard_rw /storage/9016-4EF8

##
mkdir /mnt/runtime/default/9016-4EF8
chmod 771 /mnt/runtime/default/9016-4EF8
chown root:sdcard_rw /mnt/runtime/default/9016-4EF8

## Mount with read permission
mkdir /mnt/runtime/read/9016-4EF8
chmod 755 /mnt/runtime/read/9016-4EF8
chown root:everybody /mnt/runtime/read/9016-4EF8

## Mount with write permission
mkdir /mnt/runtime/write/9016-4EF8
chmod 755 /mnt/runtime/write/9016-4EF8
chown root:everybody /mnt/runtime/write/9016-4EF8

##
mount -t sdfat /dev/block/vold/public:179,33  /mnt/media_rw/9016-4EF8
mount -t sdfat /dev/block/vold/public:179,33 /mnt/secure/asec
mount -t sdcardfs /mnt/media_rw/9016-4EF8 /mnt/runtime/default/9016-4EF8
mount -t sdcardfs /mnt/media_rw/9016-4EF8 /storage/9016-4EF8
mount -t sdcardfs /mnt/media_rw/9016-4EF8 /mnt/runtime/read/9016-4EF8
mount -t sdcardfs /mnt/media_rw/9016-4EF8 /mnt/runtime/write/9016-4EF8




