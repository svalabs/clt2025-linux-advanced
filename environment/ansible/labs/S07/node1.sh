#!/bin/bash

# Lab S07: Configuring NFS server



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# install NFS
echo "Installing NFS"
dnf install -y nfs-utils
echo ""
echo "Waiting before starting and enabling service..."
echo ""
sleep 10

# start and enable service
echo "Starting and enabling service"
systemctl enable --now nfs-server.service
echo ""
echo "Waiting before creating share..."
echo ""
sleep 10

# create share
echo "Creating share"
if [[ -z "$(grep '^/labs$' /etc/exports)" ]]; then
  echo "/labs   node2(ro)testparm" >> /etc/exports
  exportfs -ra
fi
