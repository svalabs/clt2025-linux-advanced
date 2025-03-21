#!/bin/bash

# Lab S05: Configuring Samba server



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# install Samba
echo "Installing Samba"
dnf install -y samba
echo ""
echo "Waiting before starting and enabling service..."
echo ""
sleep 10

# start and enable service
echo "Starting and enabling service"
systemctl enable --now smbd.service
echo ""
echo "Waiting before checking configuation..."
echo ""
sleep 10

# check configuration
echo "Checking configuration"
testparm
echo ""
echo "Waiting before creating a Samba password for user..."
echo ""
sleep 10

# create Samba password for user
echo "Creating Samba password for user"
smbpasswd -a user
echo ""
echo "Waiting before adding share..."
echo ""
sleep 10

# add share
echo "Adding share"
if [[ -z "$(grep '^[labs]$' /etc/samba/smb.conf)" ]]; then
  echo "" >> /etc/samba/smb.conf
  cat snippet.conf >> /etc/samba/smb.conf
  testparm
  systemctl reload smbd.service
fi
