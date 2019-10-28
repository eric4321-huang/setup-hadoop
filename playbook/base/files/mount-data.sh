#!/bin/sh

# Checking if user is root otherwise throw error
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 
    exit 0
fi

DATA_DEV=/dev/vdb

blkid |grep -q /dev/vdb
if ! (blkid |grep -q /dev/vdb); then
    echo "${DATA_DEV} does not exist, exit"
    exit 0
else
    echo "${DATA_DEV} exists"
fi

# Checking if data already exists in /etc/fstab
grep -q "${DATA_DEV}" /etc/fstab
if ! grep -q "${DATA_DEV}" /etc/fstab; then
    echo "start setup data partition"
    mkfs.ext4 ${DATA_DEV}
    mount ${DATA_DEV} /data
    echo "${DATA_DEV}   /data    ext4   errors=remount-ro  0   1" |  tee /etc/fstab -a
else
    echo 'data partintion found. No changes made.'
fi
