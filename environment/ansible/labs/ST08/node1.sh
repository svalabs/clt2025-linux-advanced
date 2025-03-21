#!/bin/bash

# Lab ST08: Auto-mounting filesystems



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

# read filesystem UUIDs
echo "Reading filesystem UUIDs"
blkid /dev/mapper/vg_training-lv_data1
blkid /dev/mapper/vg_training-lv_data2
echo ""
echo "Waiting before adding lv_data1 to /etc/fstab..."
echo ""
sleep 10

# add lv_data1 to /etc/fstab
echo "Adding lv_data1 to /etc/fstab"
UUID_DATA1="$(blkid -o value /dev/mapper/vg_training-lv_data1 | grep -v ext4)"
echo "UUID=${UUID_DATA1} /data1  ext4  defaults  0 0"
echo "UUID=${UUID_DATA1} /data1  ext4  defaults  0 0" >> /etc/fstab
echo ""
mount -a
echo ""
echo "Waiting before reloading systemd and showing data1.mount unit..."
echo ""
sleep 10

# Reload systemd and show data1.mount
echo "Reload systemd and show data1.mount"
systemctl daemon-reload
echo ""
systemctl status data1.mount
echo ""
ls -1 /run/systemd/generator/*.mount
echo ""
echo "Waiting before creating a .mount unit..."
echo ""
sleep 10

# Create .mount unit
echo "Creating .mount unit"
UUID_DATA2="$(blkid -o value /dev/mapper/vg_training-lv_data2 | grep -v xfs)"
cat >> /etc/systemd/system/data2.mount<< EOF
[Unit]
Before=local-fs.target

[Mount]
What=/dev/disk/by-uuid/${UUID_DATA2}
Where=/data2
Type=xfs
EOF
cat /etc/systemd/system/data2.mount
echo ""
echo "Waiting before reloading systemd and mounting filesystem..."
echo ""
sleep 10

# Reload systemd and mount filesystem
echo "Reloading systemd and mounting filesystem"
systemctl daemon-reload
echo ""
systemctl start data2.mount
echo ""
df -h | grep data2
