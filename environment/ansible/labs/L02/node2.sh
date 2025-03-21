#!/bin/bash

# Lab L02: Configure remote logging



# check permissions
source `dirname ${0}`/../functions.sh || exit
check_root
check_node2

# create remote logging configuration
echo "Creating remote logging configuration"
cp 99-receive-remote.conf /etc/rsyslog.d/99-receive-remote.conf
mkdir /var/log/servers
chown syslog:syslog /var/log/servers
rsyslogd -f /etc/rsyslog.conf -N1
echo ""
echo "Waiting before enabling configuration..."
echo ""
sleep 10

# enable configuration
echo "Enabling configuration"
systemctl restart rsyslog
ss -tulpn|grep 514
ufw allow 514/tcp
echo ""
echo "Waiting before waiting for remote logs..."
echo ""
sleep 10

# wait for remote logs
echo "Waiting for remote logs"
echo "NOTE: Run node1.sh on node1 - abort with CTRL+C"
watch -n1 "cat /var/log/servers/*/root.log"
