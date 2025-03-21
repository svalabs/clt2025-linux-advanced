#!/bin/bash

# Lab D02: Managing system scope



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# list current target
echo "Listing current target"
systemctl get-default
echo ""
echo "Waiting before listing all targets"
echo ""
sleep 10

# list all targets
echo "List all targets"
systemctl list-units --type target
echo "Waiting before showing current target dependencies..."
echo ""
sleep 10

# list current target dependencies
systemctl list-dependencies multi-user.target
echo "Waiting before listing unit start times..."
echo ""
sleep 10

# list unit start times
systemd-analyze blame
echo "Waiting before disabling slow-app service..."
echo ""
sleep 10

# disable slow-app service
systemctl disable --now slow-app.service
systemctl status slow-app.service
