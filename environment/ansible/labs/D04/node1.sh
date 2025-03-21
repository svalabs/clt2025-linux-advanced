#!/bin/bash

# Lab D04: Manage timers



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# list current timers
echo "Listing current timers"
systemctl list-units --type timer
echo ""
journalctl -u logrotate.timer
echo ""
echo "Waiting before creating a timer..."
echo ""
sleep 10

# create a timer
echo "Creating a timer"
cp ping.service /etc/systemd/system/ping.service
cp ping.sh /usr/local/bin/ping.sh
chmod +x /usr/local/bin/ping.sh
cp ping.timer /etc/systemd/system/ping.timer
systemctl daemon-reload
systemctl enable --now ping.timer
echo ""
echo "Waiting before checking the timer..."
echo ""
sleep 90

# check timer
echo "Checking timer"
systemctl list-timers ping.timer
cat /var/log/ping
