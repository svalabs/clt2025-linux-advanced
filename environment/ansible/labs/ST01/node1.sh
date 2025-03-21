#!/bin/bash

# Lab ST01: Configure LVM



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# create PV
echo "Creating PV"
pvcreate /dev/sdb || pvcreate /dev/vdb
pvs
pvdisplay /dev/sdb || pvcreate /dev/vdb
echo ""
echo "Waiting before creating VG..."
echo ""
sleep 10

# create VG
echo "Creating VG"
vgcreate vg_training /dev/sdb || vgcreate vg_training /dev/vdb
vgs
vgdisplay vg_display
echo ""
echo "Waiting before creating LVs..."
echo ""
sleep 10

# create LVs
lvcreate --name lv_data1 --size 2G vg_training
lvcreate --name lv_data2 --size 2G vg_training
lvs
echo ""
echo "Waiting before listing LV lv_data1..."
echo ""
sleep 10

# list LV #1
lvdisplay vg_training/lv_data1
