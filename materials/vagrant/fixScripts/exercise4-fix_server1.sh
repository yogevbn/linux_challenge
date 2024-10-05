#!/bin/bash
#add fix to exercise4-server1 here

sudo rm /etc/ssh/sshd_config.d/*
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh

echo "192.168.60.11 server2" | sudo tee -a /etc/hosts
