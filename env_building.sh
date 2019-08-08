#!/bin/bash
#Env Setup


echo "Please enter the env value"
read env

echo "Checking user need to created or already created ..."

cat /etc/passwd | grep $env
	if [ $? = 0 ]; then
		echo "Creating user"
			useradd -m $env
			echo "$env:$env" | chpasswd
	else
		echo "users already created"
	fi

echo "checking for updating sshd_config file ..."

	cat /etc/ssh/sshd_config | grep "PasswordAuthentication yes"
	if [ $? = 0 ]; then
		sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g'  /etc/ssh/sshd_config
		sudo /etc/init.d/ssh restart
	else
        	echo "sshd files already updated"
	fi


echo "please enter the ip address"
read ip

	sudo ssh-copy-id -i /home/ubuntu/.ssh/id_rsa.pub $env@$ip

	if [ $? = 0 ]; then
        	echo "ssh access configured"
	fi
