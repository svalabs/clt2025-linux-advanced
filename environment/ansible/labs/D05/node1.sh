#!/bin/bash

# Lab D05: Configure cronjobs



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# verify that crond is running
echo "Verifying that crond is running"
systemctl is-active crond.service
echo ""
systemctl is-enabled crond.service
echo ""
echo "Waiting before viewing cron logs..."
echo ""
sleep 10

# view cron logs
echo "Viewing cron logs"
journalctl -u crond.service
echo ""
echo "Waiting before viewing classic cron configuration files..."
echo ""
sleep 10

# view classic cron configuration files
echo "Viewing classic cron configuration files"
echo "/etc/crontab"
less /etc/crontab
echo ""
echo "/etc/cron.d"
ls /etc/cron.d
echo ""
echo "/etc/cron.d/0hourly"
cat /etc/cron.d/0hourly
echo ""
echo "Waiting before viewing anacron configuration files..."
echo ""
sleep 10

# view anacron configuration files
echo "Viewing anacron configuration files"
echo "/etc/anacrontab"
less /etc/anacrontab
echo ""
echo '/etc/cron.{daily,weekly,monthly}'
ls /etc/cron.{daily,weekly,monthly}
echo ""
echo "Waiting before creating a system-wide cronjob..."
echo ""
sleep 10

# create system-wide cronjob
echo "Creating system-wide cronjob"
cat >> /etc/cron.d/5min-load<< EOF
# Check load every 5 minutes
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
*/5 * * * * root uptime >> /var/log/5min-load
EOF
cat /etc/cron.d/5min-load
systemctl reload crond.service
echo ""
echo "Waiting before checking cron log..."
echo ""
sleep 10

# check cron log
echo "Checking cron log"
journalctl -fu crond.service
echo ""
tail -f /var/log/5min-load
echo ""
echo "Waiting before creating a user cronjob..."
echo ""
sleep 10

# create user cronjob
echo "Creating a user cronjob"
cat >> /var/spool/cron/user<< EOF
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
*/1 * * * * echo "Aktuelle /home-Auslastung: $(du -hsx ~)" > ~/disk_usage.log
EOF
chown user:user /var/spool/cron/user
chmod 0600 /var/spool/cron/user
restorecon /var/spool/cron/user
cat /var/spool/cron/user
systemctl reload crond.service
echo ""
echo "Waiting before printing disk_usage.log..."
echo ""
sleep 10

# print disk_usage.log
echo "Printing disk_usage.log"
tail -f ~user/disk_usage.log
