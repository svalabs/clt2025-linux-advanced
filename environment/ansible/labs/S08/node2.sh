#!/bin/bash

# Lab S08: Configuring NFS client



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# install NFS client
echo "Installing NFS client"
apt-get install -y nfs-common
echo ""
echo "Waiting before mounting share..."
echo ""
sleep 10

# mount share
echo "Mounting share"
mkdir /import/labs
mount.nfs4 node1:/labs /import/labs
echo ""
echo "Waiting before checking mount..."
echo ""
sleep 10

# check mount
echo "Checking mount"
df -h /import/labs
echo ""
ls /import/labs
