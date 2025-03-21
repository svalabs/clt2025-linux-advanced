#!/bin/bash

# Lab S02: Installing Apache



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# install httpd
echo "Installing apache2"
apt-get install -y apache2
echo ""
echo "Waiting before creating startpage..."
echo ""
sleep 10

# create startpage
echo "Creating startpage"
mv /var/www/html/index.html /var/www/html/index.html.orig
echo "Apache2-Testseite" > /var/www/html/index.html
echo "Lorem ipsum doloret." >> /var/www/html/index.html
echo ""
echo "Waiting before verifying functionality..."
echo ""
sleep 10

# Verify functionality
echo "Verifying functionality"
curl http://localhost
