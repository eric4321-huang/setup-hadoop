#!/bin/sh

# Checking if user is root otherwise throw error
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 
    exit 0
fi

#Get memory size in Megabytes
memsize=`free -m | grep Mem | awk '{print $2}'`
SWAP_SIZE=${memsize}M
echo "swap size="${SWAP_SIZE}
SWAP_FILE=/swapfile1

# Checking if swap already exists in /etc/fstab
grep -q "swapfile1" /etc/fstab
if ! grep -q "swapfile1" /etc/fstab; then
    #dd if=/dev/zero of=/swapfile1 bs=1M count=$memsize
    fallocate -l "$SWAP_SIZE" "$SWAP_FILE"
    chmod 644 "$SWAP_FILE"
    mkswap "$SWAP_FILE"
    swapon "$SWAP_FILE"	
    echo "$SWAP_FILE   none    swap    sw    0   0" |  tee /etc/fstab -a
else
    echo 'swapfile found. No changes made.'
fi

echo '----------------------'
echo 'Checking list of swap'
echo '----------------------'
swapon -s
