#!/bin/sh

#docker network create --driver=bridge --subnet=172.18.0.0/24 tools_network
mkdir -p /srv/services
docker start $(docker ps -a -q)
ssh -l root -i /root/private_key_ctf $GAMESERVER
sudo systemctl start get_traffic
