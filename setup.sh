#!/bin/bash

#Esecuzione del playbook Ansible per il "client"
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
ansible-playbook -i inventory site.yml -K -k
