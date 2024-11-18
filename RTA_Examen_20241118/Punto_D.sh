#!/bin/bash
ssh-keygen -t ed25519
cat $HOME/.ssh/id_ed25519.pub >> $HOME/.ssh/authorized_keys

#Navegar hasta donde este el playbook.yml para ejecutarlo
cd 202406/
cd ansible/
# buscar las tareas en docs.ansible.com
# agregar en tasks
# agregar el rol al playbook 

# Ejecutar el playbook
ansible-playbook -i inventory/hosts playbook.yml

