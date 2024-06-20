#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: ./$1 <vm_ip>"
    exit 1
fi

echo "$1\tgameserver" >> /etc/hosts

#Tools Setup
docker network create --driver=bridge --subnet=172.18.0.0/24 tools_network
docker start $(docker ps -a -q)

#Save SSH fingerprint
ssh -l root gameserver

#Clone traffic locally
sudo systemctl start get_traffic
