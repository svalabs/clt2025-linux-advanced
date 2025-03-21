#!/bin/bash

# Lab D03: Create units



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node
check_root

# copy units and script
echo "Copy units and script"
cp passwd-log.service /etc/systemd/system/passwd-log.service
cp passwd-alert.sh /usr/local/bin/passwd-alert.sh
chmod +x /usr/local/bin/passwd-alert.sh
cp passwd.path /etc/systemd/system/passwd.path
systemctl daemon-reload
systemctl enable --now passwd.path
echo ""
echo "Waiting before creating user and checking log..."
echo ""
sleep 10

# create user and check log
echo "Creating user and checking log"
useradd dummy
cat /var/log/passwd.alert
echo ""
echo "Waiting before creating ramdisk mount unit..."
echo ""
sleep 10

# create ramdisk mount unit
echo "Creating ramdisk mount unit"
cp ramdisk.mount /etc/systemd/system/ramdisk.mount
systemctl daemon-reload
systemctl start ramdisk.mount
df -h /ramdisk
