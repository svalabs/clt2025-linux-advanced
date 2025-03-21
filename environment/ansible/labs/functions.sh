#!/bin/bash
# Lab solution shared functions

function check_node1 {
    if [[ "$(hostname)" != *"node1"* ]]; then
        echo "ERROR: You're running the script on the wrong node."
        echo "Please run this script on node1."
        echo ""
        exit 1
    fi
}

function check_node2 {
    if [[ "$(hostname)" != *"node2"* ]]; then
        echo "ERROR: You're running the script on the wrong node."
        echo "Please run this script on node2."
        echo ""
        exit 1
    fi
}

function check_node {
    if [[ "$(hostname)" != *"node"* ]]; then
        echo "ERROR: You're running the script on the wrong node."
        echo "Please run this script on node1 or node2."
        echo ""
        exit 1
    fi
}

function check_user {
    if [[ "${USER}" != 'vagrant' ]] && [[ "${USER}" != 'user' ]]; then
        echo "ERROR: You're running the script with on the wrong user."
        echo "Please run this script as 'vagrant' or 'user' user."
        echo ""
        exit 1
    fi
}

function check_root {
    if [[ "${EUID}" != 0 ]]; then
        echo "ERROR: You're running the script without root permissions."
        echo "Please run this script as root user."
        echo ""
        exit 1
    fi
}
