#!/bin/bash
############### Pi-Hole Install ###############
#Installs Pi-Hole
echo "Select wg0 for Interface and $(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}') for the IP address"
sleep 20
curl -sSL https://install.pi-hole.net | bash

#Sets Management Interface Password
echo "Please Enter a New Password for the Management Interface?"
read PiholePassword
pihole -a -p $PiholePassword
