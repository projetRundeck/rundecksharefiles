#!/bin/bash

VM=$1
if [ "$VM" = "rundeck" ];then
    sudo yum -y update
    sudo yum -y install vim
    sudo yum -y install nfs-utils 
    sudo yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel -y
    sudo rpm -Uvh http://repo.rundeck.org/latest.rpm
    sudo yum -y install rundeck
    sudo service rundeckd start
    sudo firewall-cmd --zone=public --add-port=4440/tcp --permanent
    sudo firewall-cmd --reload
    sudo systemctl restart rundeckd
fi

if [ "$VM" = "mail" ];then
    sudo apt-get -y update
    sudo apt-get -y install vim
    sudo apt-get -y install nano
    sudo debconf-set-selections <<< "postfix postfix/mailname string localhost"
    sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
    sudo apt-get -y install postfix sasl2-bin
    sudo apt-get -y install nfs-common

fi

if [ "$VM" = "web" ];then
    sudo apt-get -y update
    sudo apt-get -y install vim
    sudo apt-get -y install apache2
    sudo apt-get -y install nfs-common
fi
if [ "$VM" = "nfs" ];then
    sudo apt-get -y update
    sudo apt-get -y install vim
    sudo apt-get -y install nfs-common
fi

# vim: et sw=4
