#!/bin/bash

# Lab S02: Installing PHP application



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# install PHP
echo "Installing PHP"
dnf install -y php php-gd
echo ""
echo "Waiting before starting and enabling service..."
echo ""
sleep 10

TODO
