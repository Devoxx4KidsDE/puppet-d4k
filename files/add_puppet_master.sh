#!/bin/bash
#Author: Tobias Schneider
#Date: 08-10-2015

clear

DEFAULT_HOSTNAME=puppet-master-d4k
read -p ">> Please Enter the puppet master hostname [$DEFAULT_HOSTNAME]: " HOSTNAME
HOSTNAME=${HOSTNAME:-$DEFAULT_HOSTNAME}

DEFAULT_IP=192.168.1.100
read -p ">> Please Enter the puppet master ip [$DEFAULT_IP]: " IP
IP=${IP:-$DEFAULT_IP}

echo "$IP   $HOSTNAME" | /usr/bin/sudo tee -a /etc/hosts
/usr/bin/sudo sed -i "/\[main\]/a server=$HOSTNAME" /etc/puppet/puppet.conf

#END