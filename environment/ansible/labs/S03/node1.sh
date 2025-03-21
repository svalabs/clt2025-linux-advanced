#!/bin/bash

# Lab S03: Installing MariaDB



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# install MariaDB
echo "Installing MariaDB"
dnf install -y mariadb-server
echo ""
echo "Waiting before starting and enabling service..."
echo ""
sleep 10

# start and enable service
echo "Starting and enabling service"
systemctl enable --now mariadb-server
echo ""
echo "Waiting before hardening database..."
echo ""
sleep 10

# harden database
echo "Hardening database"
mariadb-secure-installation
