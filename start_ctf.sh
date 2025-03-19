#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: ./$1 <vm_ip>"
    exit 1
fi

echo "$1\tvulnbox" >> /etc/hosts

#Save SSH fingerprint
ssh -l root vulnbox

#Esecuzione delp playbook Ansible
cd /srv/Setup_Nazionale/vm
ansible-playbook setup_server.yml

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

#Avvia e abilita il servizio get_traffic
sudo systemctl enable --now get_traffic.service
