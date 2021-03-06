#!/bin/bash
############### Dependancies Install ###############
sudo add-apt-repository ppa:wireguard/wireguard
sudo apt-get update
sudo apt-get install -y wireguard-dkms wireguard-tools linux-headers-$(uname -r)

############### Generate Certificates ###############
 sudo su -c "wg genkey | tee /etc/wireguard/client_private_key | wg pubkey > /etc/wireguard/client_public_key"

############### Create Configuration File ###############
#Creates the File
sudo su -c "touch /etc/wireguard/wg0-client.conf"

#Variables for next step
PrivateKey=$(sudo cat /etc/wireguard/client_private_key)

echo "What is the Server Public Key?"
read ServerKey

echo "what is the Server IP address"
read ServerIP

echo "what would you like the Client IP to be (10.100.100.?/32)?"
read ClientIP

#Configure File
sudo su -c "echo \"[Interface]\" >> /etc/wireguard/wg0-client.conf"
sudo su -c "echo \"Address = 10.100.100.$ClientIP/32 \" >> /etc/wireguard/wg0-client.conf"
sudo su -c "echo \"DNS = 10.100.100.1/24 \" >> /etc/wireguard/wg0-client.conf"
sudo su -c "echo \"PrivateKey = $PrivateKey\" >> /etc/wireguard/wg0-client.conf"
sudo su -c "echo \" \" >>/etc/wireguard/wg0-client.conf"
sudo su -c "echo \"[Peer]\" >> /etc/wireguard/wg0-client.conf"
sudo su -c "echo \"PublicKey = $ServerKey\" >> /etc/wireguard/wg0-client.conf"
sudo su -c "echo \"Endpoint = $ServerIP:51820\" >> /etc/wireguard/wg0-client.conf"
sudo su -c "echo \"AllowedIPs = 0.0.0.0/0\" >> /etc/wireguard/wg0-client.conf"
sudo su -c "echo \"PersistentKeepalive = 21\" >> /etc/wireguard/wg0-client.conf"

############### Start WireGuard ###############
sudo wg-quick up wg0-client
sudo systemctl enable wg-quick@wg0-client

############### Provide Necessary Information for Connecting to Server ###############
#Variables for Printing the required Information
PublicKey=$(sudo cat /etc/wireguard/client_public_key)

#Creates File
echo "INFORMATION FOR CONNECTING TO SERVER" >> ClientInformation.txt
echo "----------------------------------" >> ClientInformation.txt
echo " "  >> ClientInformation.txt
echo "Client IP:  10.100.100.$ClientIP/32" >> ClientInformation.txt
echo "Client Public Key: $PublicKey" >> ClientInformation.txt

#Prints File to Termianl
clear
cat ClientInformation.txt