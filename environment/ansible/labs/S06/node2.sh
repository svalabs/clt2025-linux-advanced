#!/bin/bash

# Lab S06: Configuring Samba client



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# install Samba client
echo "Installing Samba client"
apt-get install -y smbclient cifsutils
echo ""
echo "Waiting before listing shares..."
echo ""
sleep 10

# list shares
echo "Listing shares"
smbclient -U user -L //node1
echo ""
echo "Waiting before mounting share..."
echo ""
sleep 10

# mount share
echo "Mounting share"
mkdir /var/labs
mount.cifs //node1/labs -o user=user /var/labs
echo ""
echo "Waiting before checking mount..."
echo ""
sleep 10

# check mount
echo "Checking mount"
df -h /var/labs
echo ""
ls /var/labs
