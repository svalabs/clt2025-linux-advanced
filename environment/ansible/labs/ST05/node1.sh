#!/bin/bash

# Lab ST05: Extending VG



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# check VGs
if [ ! -f /dev/mapper/vg_training-lv_data1 ] || [ ! -f /dev/mapper/vg_training-lv_data2 ]; then
    echo "LVM VG doesn't exist, please run lab ST01."
    exit 1
fi

# list VG
echo "Listing VG"
vgs
echo ""
echo "Waiting before creating a new PV..."
echo ""
sleep 10

# create PV
echo "Creating PV"
pvcreate /dev/sdc || pvcreate /dev/vdc
pvs
pvdisplay /dev/sdc || pvcreate /dev/vdc
echo ""
echo "Waiting before extending VG..."
echo ""
sleep 10

# extend VG
echo "Extending VG"
vgextend vg_training /dev/vdc
echo ""
vgs
pvdisplay /dev/sdc
