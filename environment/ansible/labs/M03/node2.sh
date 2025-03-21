#!/bin/bash

# Lab M03: Monitoring network traffic



# check permissions
source `dirname ${0}`/../functions.sh || exit
check_root
check_node2

# check webserver
echo "Checking webserver"
curl http://localhost
echo ""
echo "Waiting before pinging webserver..."
echo ""
sleep 10

# ping webserver
echo "pinging webserver"
ping http://node1
