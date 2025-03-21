#!/bin/bash

# Lab ST02: Create filesystems



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# check VGs
if [ ! -f /dev/mapper/vg_training-lv_data1 ] || [ ! -f /dev/mapper/vg_training-lv_data2 ]; then
    echo "LVM VG doesn't exist, please run lab ST01."
    exit 1
fi

# create filesystems
echo "Creating filesystems"
mkfs.ext4 /dev/mapper/vg_training-lv_data1
mkfs.xfs /dev/mapper/vg_training-lv_data2
echo ""
echo "Waiting before mounting filesystems..."
echo ""
sleep 10

# mount filesystems
echo "Mounting filesystems"
mkdir /data1 /data2
mount /dev/mapper/vg_training-lv_data1 /data1
mount /dev/mapper/vg_training-lv_data2 /data2
echo ""
echo "Waiting before creating files..."
echo ""
sleep 10

# create files
echo "Creating filesystems"
dd if=/dev/random of=/data1/file.img bs=1024k count=512
dd if=/dev/random of=/data2/file.img bs=1024k count=512
