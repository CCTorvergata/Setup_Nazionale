#!/bin/sh

systemctl disable --now get-traffic.service
ssh-keygen -R vulnbox

docker stop $(docker ps -a -q)                 #Questo comando stoppa tutti i container
docker system prune -a

#rm -rf /srv/traffic
#sed -i '$d' /etc/hosts