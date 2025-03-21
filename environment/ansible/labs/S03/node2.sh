#!/bin/bash

# Lab S03: Installing MariaDB



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# install MariaDB
echo "Installing MariaDB"
apt-get install -y mariadb-server
echo ""
echo "Waiting before hardening database..."
echo ""
sleep 10

# harden database
echo "Hardening database"
mariadb-secure-installation
