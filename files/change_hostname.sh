#!/bin/bash
#Author: Tobias Schneider
#Date: 08-10-2015

clear

EXISTING_HOSTNAME=$(cat /etc/hostname)
echo ">> Existing hostname is: $EXISTING_HOSTNAME"
echo

echo ">> Please Enter your desired hostname: "
  read HOSTNAME
    /usr/bin/sudo sed -i "s/$EXISTING_HOSTNAME/$HOSTNAME/g" /etc/hosts
    /usr/bin/sudo sed -i "s/$EXISTING_HOSTNAME/$HOSTNAME/g" /etc/hostname

echo
echo ">> New hostname is: $HOSTNAME"
echo

read -s -n 1 -p ">> Press any key to reboot"
/usr/bin/sudo reboot

#END