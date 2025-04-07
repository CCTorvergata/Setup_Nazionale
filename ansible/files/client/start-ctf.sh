#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: ./$1 <vm_ip>"
    exit 1
fi

echo "$1\tvulnbox" >> /etc/hosts

#Save SSH fingerprint
ssh -l root vulnbox

cd ansible

#Esecuzione del playbook Ansible per la vulnbox
ansible-playbook setup_vulnbox.yml

#Tools Setup
cd /srv/docker/flagwarehouse
docker compose up -d
cd /srv/docker/tulip
docker compose up -d