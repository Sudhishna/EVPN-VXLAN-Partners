#!/bin/bash
# Remove all the configs
# Comannd example ./Remove-Fabric.sh
# Date written 2018 February 12

printf  "Removing configuration begins.\r"

ansible-playbook -i all.inv 01-overlay/remove-config.yml
sleep 5 

printf "\n\nThe configurations were successfully removed.\n"
