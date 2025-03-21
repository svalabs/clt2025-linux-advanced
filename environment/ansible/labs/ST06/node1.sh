#!/bin/bash

# Lab ST06: Configuring LUKS



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# check VGs
if [ ! -f /dev/mapper/vg_training ]; then
    echo "LVM VG doesn't exist, please run lab ST01."
    exit 1
fi

# add another LV
echo "Adding a LV"
lvcreate --name lv_luks --size 1G vg_training
echo ""
echo "Waiting before encrypting LV..."
echo ""
sleep 10

# encrypt LV
echo "Encrypting LV"
cryptsetup luksFormat -y /dev/mapper/vg_training-lv_luks
echo ""
echo "Waiting before opening LUKS volume..."
echo ""
sleep 10

# open LUKS volume
echo "Opening LUKS volume"
cryptsetup open /dev/mapper/vg_training-lv_luks secret_data
echo ""
echo "Waiting before listing LUKS volume details..."
echo ""
sleep 10

# list LUKS volume details
echo "Listing LUKS volume details"
cryptsetup status /dev/mapper/secret_data
echo ""
echo "Waiting before creating and mounting an ext4 filesystem..."
echo ""
sleep 10

# create and mount an ext4 filesystem
echo "Creating and mounting an ext4 filesystem"
mkfs.ext4 /dev/mapper/secret_data
mkdir /secret_data
mount /dev/mapper/secret_data /secret_data
echo ""
echo "Waiting before creating a file and unmount the filesystem..."
echo ""
sleep 10

# create a file and umount the filesystem
echo "Creating a file and unmounting the filesystem"
echo "DM ist teurer als Rossmann" > /secret_data/secret.txt
umount /secret_data
echo ""
echo "Waiting before adding another passphrase..."
echo ""
sleep 10

# add another passphrase
cryptsetup luksAddKey /dev/mapper/vg_training-lv_luks
echo ""
echo "Waiting before dumping the LUKS header..."
echo ""
sleep 10

# dump LUKS heading
echo "Dumping the LUKS header"
cryptsetup luksDump /dev/mapper/vg_training-lv_luks
