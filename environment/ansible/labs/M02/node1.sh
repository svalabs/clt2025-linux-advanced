#!/bin/bash

# Lab M02: Troubleshooting an application



# check permissions
source `dirname ${0}`/../functions.sh || exit
check_root
check_node1

# start crapp.service
echo "Starting crapp.service"
systemctl start crapp.service
sleep 5
htop
echo ""
echo "Waiting before checking detailed CPU usage..."
echo ""
sleep 10

# check detailed CPU usage
echo "Checking detailed CPU usage"
mpstat -P ALL 1 30
echo ""
echo "Waiting before checking what started this process..."
echo ""
sleep 10

# check what stared this process
echo "Checking what started this process"
ps -fC stress-ng
echo ""
# TODO: how to check for PPID?
systemctl cat crapp.service
echo ""
echo "Waiting before stopping the service..."
echo ""
sleep 10

# stop the service
echo "Stopping the service"
systemctl stop crapp.service
