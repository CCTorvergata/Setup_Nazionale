#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: ./$1 <vm_ip>"
    exit 1
fi

echo "$1\tgameserver" >> /etc/hosts

#Save SSH fingerprint
ssh -l root gameserver

#Run Ansible
ansible-playbook -i /srv/Setup_Nazionale/vm/inventory /srv/Setup_Nazionale/vm/setup_server.yml -k

#Tools Setup
docker network create --driver=bridge --subnet=172.18.0.0/24 tools_network
cd /srv/docker/flagWarehouse/client
docker compose up -d --build
cd /srv/docker/flagWarehouse/server
docker compose up -d --build
cd /srv/docker/tulip
docker compose up -d --build
cd /srv/docker/webserver
docker compose up -d

#Clone traffic locally
sudo systemctl start get_traffic
