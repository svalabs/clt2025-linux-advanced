#!/bin/bash

# Lab D01: Managing services



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# list started services
echo "Listing VG"
systemctl --type=service
echo ""
echo "Waiting before checking crond service"
echo ""
sleep 10

# check crond service
echo "Checking crond service"
systemctl status crond.service
echo "Waiting before stopping crond service..."
echo ""
sleep 10

# stop crond service
systemctl stop crond.service
systemctl status crond.service
echo "Waiting before starting crond service..."
echo ""
sleep 10

# start crond service
systemctl start crond.service
systemctl status crond.service
echo "Waiting before listing stopped services..."
echo ""
sleep 10

# list stopped services
systemctl --type=service --state=inactive
