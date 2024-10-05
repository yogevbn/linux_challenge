#!/bin/bash
#add fix to exercise5-server2 here

SERVER1_IP="192.168.60.10"
SERVER2_IP="192.168.60.11"
SERVER_USER="vagrant"
PASSWORD="vagrant"
SSH_CONFIG_FILE="/home/vagrant/.ssh/config"

sudo apt-get update && sudo apt-get install -y sshpass

sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER1_IP" \
"ssh-keygen -t rsa -b 2048 -N '' -f ~/.ssh/id_rsa"

sshpass -p "$PASSWORD" scp -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER1_IP:/home/$SERVER_USER/.ssh/id_rsa.pub" /tmp/server1_id_rsa.pub
cat /tmp/server1_id_rsa.pub >> /home/$SERVER_USER/.ssh/authorized_keys
chmod 600 /home/$SERVER_USER/.ssh/authorized_keys
rm /tmp/server1_id_rsa.pub

sshpass -p "$PASSWORD" ssh "$SERVER_USER@$SERVER1_IP" \
"echo -e 'Host $SERVER2_IP\n    StrictHostKeyChecking no\n    UserKnownHostsFile=/dev/null' >> /home/$SERVER_USER/.ssh/config && chmod 600 /home/$SERVER_USER/.ssh/config"

ssh-keygen -t rsa -b 2048 -N "" -f ~/.ssh/id_rsa

sshpass -p "$PASSWORD" ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER1_IP"


sudo -u vagrant touch $SSH_CONFIG_FILE
echo "Host $SERVER1_IP" >> $SSH_CONFIG_FILE
echo "    StrictHostKeyChecking no" >> $SSH_CONFIG_FILE
echo "    UserKnownHostsFile=/dev/null" >> $SSH_CONFIG_FILE

