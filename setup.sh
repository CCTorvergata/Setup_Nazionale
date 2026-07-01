#!/bin/bash


grep -q "#VULNBOX_IP" inventory && { \
	echo "ERROR: You forgot to set the vulnbox's IP in the file './inventory'"; \
	exit 1; \
}

ls ./roles/vulnbox/copy-ssh-public-keys/files/*.pub 2>&1 > /dev/null || { \
	echo "ERROR: you need to put your SSH public key in the directory './roles/vulnbox/copy-ssh-public-keys/files'"; \
	exit 1; \
}

echo "Installing ansible requirements..."
echo

ansible-galaxy install -r requirements.yml

echo
echo "Running playbook..."
echo
echo "It will ask you vulnbox's SSH password"
echo "And the local sudo password"
echo

ansible-playbook site.yml
