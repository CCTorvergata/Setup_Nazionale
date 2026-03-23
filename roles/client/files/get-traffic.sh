#!/bin/sh

#Script per il download dei file pcap tramite rsync

DEST_FOLDER=/srv/traffic
SERVER=root@vulnbox:/srv/traffic/

mkdir -p "$DEST_FOLDER"

while :; do
  rsync -avz "$SERVER" "$DEST_FOLDER"
  sleep 10
done
