#!/bin/bash

ROTATE_SECONDS=15               #Write a new pcap on tot seconds
PREFIX=TV-                       #Prefix to add to name files (optional)
DIRECTORY=/srv/traffic           #Directory where to save ot files
INTERFACE=game

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir -p $DIRECTORY             #Create the directory target if not exists
chown tcpdump:tcpdump $DIRECTORY

tcpdump -G $ROTATE_SECONDS -w "$DIRECTORY/$PREFIX%Y-%m-%d_%H.%M.%S.pcap" -i "$INTERFACE" -s 1500 port not 22
