#!/bin/bash

# Lab S04: Managing MariaDB content



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node
check_root

# create user and database
echo "Creating user and database"
mysql -u root -p < create.sql
echo ""
echo "Waiting before creating and filling a table..."
echo ""
sleep 10

# create and fill a table
echo "Creating and filling a table"
mysql -u training -pgeffjeerling training < training.sql
echo ""
echo "Waiting before creating a backup..."
echo ""
sleep 10

# create a backup
echo "Creating a backup"
mariadb-dump training > training_backup.sql
echo ""
echo "Waiting before restoring the backup..."
echo ""
sleep 10

# restore the backup
echo "Restoring the backup"
mysql -u training -pgeffjeerling training < delete.sql
mariadb -u training -pgeffjeerling training < training_backup.sql
echo ""
echo "Waiting before checking data..."
echo ""
sleep 10

# check data
echo "Checking data"
mariadb -u training -pgeffjeerling training
