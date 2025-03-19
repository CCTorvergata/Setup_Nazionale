#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: ./$1 <vm_ip>"
    exit 1
fi

echo "$1\tvulnbox" >> /etc/hosts

#Save SSH fingerprint
ssh -l root vulnbox

cd /srv/Setup_Nazionale

#Esecuzione del playbook Ansible per la vulnbox
ansible-playbook setup_server.yml

#Esecuzione del playbook Ansible per il "client"
ansible-playbook setup_client.yml

#Tools Setup
docker network create --driver=bridge --subnet=172.18.0.0/24 tools_network
cd /srv/docker/webserver
docker compose up -d