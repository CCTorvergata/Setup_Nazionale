#!/bin/sh

DEST_FOLDER=/srv/traffic
SERVER=root@gameserver:/srv/traffic/

mkdir -p "$DEST_FOLDER"

while :; do
  rsync -avz "$SERVER" "$DEST_FOLDER"
  sleep 10
done
