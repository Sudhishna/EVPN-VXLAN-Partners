#!/bin/bash
# Fabric deployment for OSPF Underlay and EVPN/VXLAN Overlay
# Comannd example ./Build-Fabric.sh
# Date written 2018 February 12

x=`sed -n '1p' ~/BuildSystem/PodInfo.txt`;
echo "$x";
PodNumber=$(echo $x | cut -d":" -f2);

printf  "Fabric initialization begins.\r"

ansible-playbook -i all.inv "01-overlay/config-overlay.yml"
printf  "Interfaces Configured.\r"
sleep 3

ansible-playbook -i all.inv "02-Inter-VNI-Type2/config-Inter-VNI.yml"
printf  "Scale Options Configured.\r"
sleep 3

ansible-playbook -i all.inv "03-Inter-VNI-Type5/config-Inter-VNI.yml"
printf  "Routing options set.\r"
sleep 3

ansible-playbook -i all.inv "04-Inter-VNI-Type5/config-Inter-VNI.yml"
printf  "OSPF Routing Protocol installed and iBGP configured.\r"
sleep 3

secs=$((1 * 60))
while [ $secs -gt 0 ]; do
   echo -ne "Countdown to Fabric Availability: "
   echo -ne "$secs\033[0K\r"
   sleep 1
   : $((secs--))
done
sleep 3

printf "\n\nThe Fabric is ready.\n"
