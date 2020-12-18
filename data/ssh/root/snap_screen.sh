#!/system/bin/sh

##
## Script to take a screenshot and save to /data/ssh/root/screenshots/
##


screencap -p /data/ssh/root/screenshots/$(date +%b%d-%H.%M.%S).png
