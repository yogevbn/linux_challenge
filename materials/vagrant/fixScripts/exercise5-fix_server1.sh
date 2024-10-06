#!/bin/bash
#add fix to exercise5-server1 here
SERVER2_IP="192.168.60.11"
SERVER_USER="vagrant"
PASSWORD="vagrant"
SSH_CONFIG_FILE="/home/vagrant/.ssh/config"

sudo apt-get update && sudo apt-get install -y sshpass

ssh-keygen -t rsa -b 2048 -N '' -f ~/.ssh/id_rsa
chown vagrant:vagrant ~/.ssh/id_rsa
chmod 777 ~/.ssh/id_rsa.pub
touch $SSH_CONFIG_FILE
echo "Host $SERVER1_IP" >> $SSH_CONFIG_FILE
echo "    StrictHostKeyChecking no" >> $SSH_CONFIG_FILE
echo "    UserKnownHostsFile=/dev/null" >> $SSH_CONFIG_FILE
echo "sshpass -p '$PASSWORD' ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no '$SERVER_USER@$SERVER2_IP'" > ~/sshfix.sh
chmod +x ./sshfix.sh

