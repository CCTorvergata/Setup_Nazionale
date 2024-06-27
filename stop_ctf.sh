#!/bin/sh

systemctl stop get_traffic.service
ssh-keygen -R gameserver

docker stop $(docker ps -a -q)
docker system prune -a

#rm -rf /srv/traffic
sed -i '$d' /etc/hosts
