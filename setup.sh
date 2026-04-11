#!/bin/bash

grep -q "#VULNBOX_IP" inventory && { \
	echo "ERROR: You forgot to set the vulnbox's IP in the file './inventory'"; \
	exit 1; \
}

ls ./roles/vulnbox/files/public-keys/*.pub 2>&1 > /dev/null || { \
	echo "ERROR: you need to put your SSH public key in the directory './roles/vulnbox/files/public-keys/'"; \
	exit 1; \
}

ansible-playbook site.yml
