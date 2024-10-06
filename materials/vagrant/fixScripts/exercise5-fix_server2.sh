#!/bin/bash
#add fix to exercise5-server2 here

SERVER1_IP="192.168.60.10"
SERVER2_IP="192.168.60.11"
SERVER_USER="vagrant"
PASSWORD="vagrant"
SSH_CONFIG_FILE="/home/vagrant/.ssh/config"

sudo apt-get update && sudo apt-get install -y sshpass

ssh-keygen -t rsa -b 2048 -N "" -f ~/.ssh/id_rsa

sshpass -p "$PASSWORD" ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER1_IP"

sshpass -p "$PASSWORD" ssh "$SERVER_USER@$SERVER1_IP" \ "/bin/bash ~/sshfix.sh"

sudo -u vagrant touch $SSH_CONFIG_FILE
echo "Host $SERVER1_IP" >> $SSH_CONFIG_FILE
echo "    StrictHostKeyChecking no" >> $SSH_CONFIG_FILE
echo "    UserKnownHostsFile=/dev/null" >> $SSH_CONFIG_FILE

