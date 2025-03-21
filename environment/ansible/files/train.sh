#!/bin/bash
# cowsaying random words every 10 seconds
# lulz :)

# ensure that SIGINT and SIGTERM won't stop us
trap "echo You cannot stop me" SIGINT
trap "echo You cannot stop me" SIGTERM

while :
do
  sl
done
