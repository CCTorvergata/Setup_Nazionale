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

tshark -F pcapng -b interval:15 -w "$DIRECTORY/$PREFIX%Y-%m-%d_%H.%M.%S.pcap" -i "$INTERFACE" -i lo -f "port not 22"
