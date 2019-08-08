#!/bin/bash
#Env Setup


echo "Please enter the env value"
read env

echo "Creating user"
        useradd -m $env
        echo "$env:$env" | chpasswd

if [ $? = 0 ]; then
        echo "users created"
fi


echo "updating sshd_config file"

        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g'  /etc/ssh/sshd_config
        sudo /etc/init.d/ssh restart

if [ $? = 0 ]; then
        echo "sshd files updated"
fi
