#!/bin/bash

# Lab ST04: Use LVM snapshots



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# check VGs
if [ ! -f /dev/mapper/vg_training-lv_data1 ] || [ ! -f /dev/mapper/vg_training-lv_data2 ]; then
    echo "LVM VG doesn't exist, please run lab ST01."
    exit 1
fi

# check filesystems
if [ ! -f /data1 ] || [ ! -f /data2 ]; then
    echo "Filesystems don't exist, please run lab ST02."
    exit 1
fi

# create a LVM snapshot
echo "Creating a LVM snapshot"
lvcreate --size 1G --snapshot --name lv_data2_snap vg_training/lv_data2
lvs
echo ""
echo "Waiting before removing a file..."
echo ""
sleep 10

# remove a file
echo "Removing a file"
rm /data2/file.img
echo ""
echo "Waiting before checking that the file still exists in the snapshot..."
echo ""
sleep 10

# check that the file still exists in the snapshot
echo "Checking that the file still exists in the snapshot"
mkdir /data2_snapshot
mount /dev/mapper/vg_training-lv_data2_snap /data2_snapshot
ls /data2_snapshot
echo ""
echo "Waiting before restoring the snapshot..."
echo ""
sleep 10

# restore the snapshot
echo "Restoring the snapshot"
umount /data2_snapshot /data2
lvconvert --merge /dev/mapper/vg_training-lv_data2_snap 
if [ "${?}" -eq 1 ]; then
    echo "Refreshing VG and retrying"
    lvchange --refresh vg_data
    lvconvert --merge /dev/mapper/vg_training-lv_data2_snap 
fi
echo ""
echo "Waiting before mounting the filesystem again..."
echo ""
sleep 10

# mount the filesystem again
echo "Mounting the filesystem again..."
mount dev/mapper/vg_training-lv_data2 /data2
ls /data2
