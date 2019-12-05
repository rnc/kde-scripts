#!/bin/bash
#
# Used:
# https://support.zenoss.com/hc/en-us/articles/203582809-How-to-Change-the-Default-Docker-Subnet
# but
# https://developer.ibm.com/recipes/tutorials/networking-your-docker-containers-using-docker0-bridge/
# Possible alternative: just add --bip=CIDR to DOCKER_OPTIONS

U=$USER
if [ "$1" = "-u" ]
then
    shift
    local U="$1"
fi
if [ -z "$1" ]
then
    echo "Pass in IP e.g. 172.17.130.215"
    echo "To ignore mounting pass in '-'"
    exit
fi

if [ -n "`ifconfig docker0 | grep 172.17`" ]
then
    echo "Resetting docker routing..."
    systemctl stop docker

    ADDR=`ip -o -4 addr show docker0 | head -1 | awk '$3 == "inet" {  print $4 }'`
    #ip -family inet addr show docker0 | head -1 | cut -d ' ' -f 6`
    echo "Found IP $ADDR for Docker"

    ip link set dev docker0 down
    ip addr del $ADDR dev docker0

    ip addr add 192.168.5.1/24 dev docker0
    ip link set dev docker0 up

    echo "New docker routing:"
    ip addr show docker0

    systemctl start docker
fi

if [ "$1" != "-" ]
then
    sshfs $U@$1:$HOME /mnt/shared
fi
