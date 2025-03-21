#!/bin/bash

# Lab S01: Installing Apache



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# install httpd
echo "Installing httpd"
dnf install -y httpd
echo ""
echo "Waiting before starting and enabling service..."
echo ""
sleep 10

# start and enable service
echo "Starting and enabling service"
systemctl enable --now httpd
echo ""
echo "Waiting before creating startpage..."
echo ""
sleep 10

# create startpage
echo "Creating startpage"
echo "Apache2-Testseite" > /var/www/html/index.html
echo "Lorem ipsum doloret." >> /var/www/html/index.html
echo ""
echo "Waiting before verifying functionality..."
echo ""
sleep 10

# Verify functionality
echo "Verifying functionality"
curl http://localhost
