#! /bin/sh

[ $# -eq 1 ] || { echo "usage: $(basename $0) hostname"; exit 1; }

MR=`cd $(dirname $0);pwd`

export HOSTNN=$1
echo $HOSTNN > /etc/hostname

echo "setup hostname to '$1'. System will be rebooted in 3 seconds! .."
sleep 3

reboot
