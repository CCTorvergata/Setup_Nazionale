#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m'

grep -q "#VULNBOX_IP" inventory && { \
	echo -e "${RED}ERROR:${NC} You forgot to set the vulnbox's IP in the file './inventory'"; \
	exit 1; \
}

ls ./roles/vulnbox/copy-ssh-public-keys/files/*.pub 2>&1 > /dev/null || { \
	echo -e "${RED}ERROR:${NC} you need to put your SSH public key in the directory './roles/vulnbox/copy-ssh-public-keys/files'"; \
	exit 1; \
}

echo
echo -e "${GREEN}- - - Installing ansible requirements - - -${NC}"
echo

ansible-galaxy install -r requirements.yml

echo
echo -e "${GREEN}- - - Running playbook - - -${NC}"
echo
echo -e "You need to enter the ${ORANGE}vulnbox's SSH password${NC},"
echo -e "and the ${ORANGE}local sudo password${NC}."
echo

ansible-playbook site.yml
