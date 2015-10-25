#!/bin/bash
#Author: Tobias Schneider
#Date: 08-10-2015
#Description: This script does add the correct puppet master hostname and set the hostname of the raspberry

clear

# Add Puppet Master
DEFAULT_HOSTNAME=puppet-master-d4k
read -p ">> Please enter the puppet master hostname [$DEFAULT_HOSTNAME]: " HOSTNAME
HOSTNAME=${HOSTNAME:-$DEFAULT_HOSTNAME}

DEFAULT_IP=192.168.1.100
read -p ">> Please enter the puppet master ip [$DEFAULT_IP]: " IP
IP=${IP:-$DEFAULT_IP}

echo "$IP   $HOSTNAME" | /usr/bin/sudo tee -a /etc/hosts
/usr/bin/sudo sed -i "/\[main\]/a server=$HOSTNAME" /etc/puppet/puppet.conf

EXISTING_HOSTNAME=$(cat /etc/hostname)
echo ">> Existing hostname is: $EXISTING_HOSTNAME"
echo


# Change Hostname
echo ">> Please enter your desired [d4k-$number] hostname postfix number: "
  read hostname_postfix_number
    HOSTNAME="d4k-"$hostname_postfix_number
    /usr/bin/sudo sed -i "s/$EXISTING_HOSTNAME/$HOSTNAME/g" /etc/hosts
    /usr/bin/sudo sed -i "s/$EXISTING_HOSTNAME/$HOSTNAME/g" /etc/hostname

echo
echo ">> New hostname is: $HOSTNAME"
echo

read -s -n 1 -p ">> Press any key to reboot"
/usr/bin/sudo reboot

#END