#!/bin/bash

# Lab M03: Monitoring network traffic



# check permissions
source `dirname ${0}`/../functions.sh || exit
check_root
check_node1

# start web server
echo "Starting web server"
systemctl start httpd.service
sleep 5
curl http://localhost
echo ""
echo "Waiting before checking sockets..."
echo ""
sleep 10

# check sockets
echo "Checking sockets"
ss -tulpen
echo ""
echo "Waiting before starting iptraf-ng..."
echo ""
sleep 10

# start iptraf-ng
echo "Starting iptraf-ng"
echo "NOTE: You will need to start observation on your own!"
sleep 10
iptraf-ng
