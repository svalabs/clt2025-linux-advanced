#!/bin/bash

# Lab L02: Configure remote logging



# check permissions
source `dirname ${0}`/../functions.sh || exit
check_root
check_node1

# create remote logging configuration
echo "Creating remote logging configuration"
cp 99-send-remote.conf /etc/rsyslog.d/99-send-remote.conf
restorecon -v /etc/rsyslog.d/99-send-remote.conf
rsyslogd -f /etc/rsyslog.conf -N1
echo ""
echo "Waiting before enabling configuration..."
echo ""
sleep 10

# enable configuration
echo "Enabling configuration"
systemctl restart rsyslog
sleep 5
echo "Sending test message"
logger -p user.info "Test message"
