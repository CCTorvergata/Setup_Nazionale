#!/bin/bash

# Script per lo sniffing del traffico e creazione dei file pcap

ROTATE_SECONDS=15                 # Write a new pcap every tot seconds
PREFIX=TV-                        # Prefix to add to name files (optional)
DIRECTORY=/srv/traffic            # Directory where to save the pcap files
INTERFACE=game

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir -p $DIRECTORY               # Create target directory if it doesn't exists
chown tcpdump:tcpdump $DIRECTORY

tcpdump -G $ROTATE_SECONDS -w "$DIRECTORY/$PREFIX%Y-%m-%d_%H.%M.%S.pcap" -i "$INTERFACE" -s 1500 port not 22
