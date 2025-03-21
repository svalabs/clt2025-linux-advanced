#!/bin/bash

# Lab ST03: Resizing LVs



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

# grow filesystem /data2
echo "Growing filesystem /data2"
lvresize --size +1G vg_training/lv_data2
xfs_growfs /dev/mapper/vg_training-lv_data2
echo ""
echo "Waiting before shrinking filesystem /data1..."
echo ""
sleep 10

# shrink filesystem /data1
echo "Shrinking filesystem /data1"
umount /data1
fsck.ext4 -f /dev/mapper/vg_training-lv_data1
echo ""
resize2fs /dev/mapper/vg_training-lv_data1 1G
echo ""
lvresize --size -1G vg_training/lv_data1
echo ""
echo "Waiting before listing filesystem sizes..."
echo ""
sleep 10

# List filesystem sizes
mount /dev/mapper/vg_training-lv_data1 /data1
echo ""
lvs
echo ""
df -h|grep /data
