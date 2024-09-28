#!/bin/bash
dnf install ansible -y
cd /tmp
git clone https://github.com/sprojexdevops/3tier-ansible.git
cd 3tier-ansible
ansible-playbook -i inventory.ini mysql.yaml
ansible-playbook -i inventory.ini backend.yaml
ansible-playbook -i inventory.ini frontend.yaml