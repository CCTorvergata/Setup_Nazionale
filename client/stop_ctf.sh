#!/bin/sh

systemctl stop get_traffic.service
ssh-keygen -R $GAMESERVER
docker stop $(docker ps -a -q)
rm -rf /srv/traffic
rm -rf /srv/services
