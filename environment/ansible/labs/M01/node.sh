#!/bin/bash

# Lab M01: Controlling processes



# check permissions
source `dirname ${0}`/../functions.sh || exit
check_user

# start train or check processes
TRAIN="$(ps --no-headers -C train.sh)"
if [ -z "${TRAIN}" ]
then
    # no train running, start it
    /opt/train.sh
else
    # train already running, show user processes
    ps -U user
    echo ""
    echo "Waiting before showing all the proccesses..."
    sleep 10
    echo ""

    # show all processes
    ps -ef
    echo ""
    echo "Waiting before showing the train.sh proccess..."
    sleep 10
    echo ""

    # show train process
    ps -fC train.sh
    echo ""
    echo "Waiting before trying to kill the train.sh proccess..."
    sleep 10
    echo ""

    # try to kill the process
    TRAIN_PID="$(pgrep train.sh)"
    kill "${TRAIN_PID}"
    kill -2 "${TRAIN_PID}"
    echo ""
    echo "Waiting before FORCEFULLY killing the train.sh proccess..."
    sleep 10
    echo ""

    # kill'em wit fire
    kill -9 "${TRAIN_PID}"
    echo "Waiting before running top..."
    sleep 10

    # start top
    top
    echo "Waiting before running htop..."
    sleep 10

    # start htop
    htop

fi
