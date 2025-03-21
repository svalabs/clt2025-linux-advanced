#!/bin/bash

# Lab ST07: Configuring Software RAID



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# find disks
if [ -f /dev/vdb ]; then
    DISK_ONE="/dev/vdb"
    DISK_TWO="/dev/vdc"
else
    DISK_ONE="/dev/sdb"
    DISK_TWO="/dev/sdc"
fi

# partition first disk
echo "Partitioning first disk"
parted "${DISK_ONE}" mklabel gpt
parted -a optimal -- "${DISK_ONE}" mkpart primary 0% 100%
parted "${DISK_ONE}" set 1 raid on
echo ""
echo "Waiting before partitioning second disk..."
echo ""
sleep 10

# partition second disk
echo "Partitioning second disk"
parted "${DISK_TWO}" mklabel gpt
parted -a optimal -- "${DISK_TWO}" mkpart primary 0% 100%
parted "${DISK_TWO}" set 1 raid on
echo ""
echo "Waiting before creating RAID 0 volume..."
echo ""
sleep 10

# create RAID 0 volume
echo "Creating RAID 0 volume"
mdadm --create /dev/md0 --auto md --level=0 --raid-devices=2 "${DISK_ONE}1" "${DISK_TWO}1"
echo
cat /proc/mdstat
echo ""
echo "Waiting before creating a filesystem..."
echo ""
sleep 10

echo "Creating filesystem"
mkfs.ext4 /dev/md0
echo ""
mkdir /raidvol
mount /dev/md0 /raidvol
echo ""
df -h | grep raidvol
