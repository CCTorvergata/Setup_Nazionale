#!/bin/bash

# Script per lo sniffing del traffico e creazione dei file pcap

ROTATE_SECONDS=15                         # Write a new pcap every tot seconds
PREFIX="TV_$(date +%Y-%m-%d_%H.%M.%S)"    # Static prefix added to name files (optional, tshark will still suffix "_fileindex_timestamp")
DIRECTORY=/srv/traffic                    # Directory where to save the pcap files
INTERFACE=game

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir -p $DIRECTORY               # Create target directory if it doesn't exists

tshark -F pcapng -b interval:"$ROTATE_SECONDS" \
-i "$INTERFACE" -f "not port 22" \
-i lo -f "not port 22" \
-w "$DIRECTORY/$PREFIX.pcap"
