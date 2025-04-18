#!/bin/sh

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <vm_ip>"
    exit 1
fi

echo "$1\tvulnbox" >> /etc/hosts

#Save SSH fingerprint
ssh -l root vulnbox

#Tools Setup
cd /srv/docker/flagwarehouse
docker compose up -d
cd /srv/docker/tulip
docker compose up -d