#!/bin/bash
# Remove all the configs
# Comannd example ./Remove-Fabric.sh
# Date written 2018 February 12

x=`sed -n '1p' ~/BuildSystem/PodInfo.txt`;
echo "$x";
PodNumber=$(echo $x | cut -d":" -f2);
echo $PodNumber

printf  "Removing configuration begins.\r"

ansible-playbook -i all.inv 01-Interfaces/remove-config.yml --extra-vars "pod=pod$PodNumber"
sleep 5 

printf "\n\nThe configurations were successfully removed.\n"
