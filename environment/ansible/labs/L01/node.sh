#!/bin/bash

# Lab L01: Monitoring logs



# check permissions
source `dirname ${0}`/../functions.sh || exit
check_root

# discover log directory
ls -1 /var/log
echo ""
echo "Waiting before showing all journal entries..."
sleep 10
echo ""

# show all journal entries
journalctl
echo ""
echo "Waiting before showing journal entries of rsyslog.service..."
sleep 10
echo ""

# show rsyslog journal entries
journalctl -u rsyslog.service
echo ""
echo "Waiting before showing kernel output..."
sleep 10
echo ""

# show kernel output
dmesg
