#!/bin/bash
#Script : provion.sh
#Author : Aissi Ayoub
#Last edit : 28 janv 2020 || 02 : 16 

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
    sudo -u root adduser adminRundeck
    sudo -u root echo rundeck | sudo -u root passwd adminRundeck --stdin 
    sudo -u root gpasswd -a adminRundeck wheel
    sudo -u adminRundeck ssh-keygen -t rsa -N "" -f /home/adminRundeck/.ssh/id_rsa
    sudo yum -y install wget
    sudo wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    sudo rpm -ivh epel-release-6-8.noarch.rpm
    sudo yum --enablerepo=epel -y install sshpass
    sudo -u adminRundeck ssh -o "StrictHostKeyChecking no" rundeck@172.28.128.4
    sudo -u adminRundeck sshpass -p rundeck ssh-copy-id rundeck@172.28.128.4
    sudo -u adminRundeck ssh -o "StrictHostKeyChecking no" rundeck@172.28.128.3
    sudo -u adminRundeck sshpass -p rundeck ssh-copy-id rundeck@172.28.128.3
    sudo -u adminRundeck ssh -o "StrictHostKeyChecking no" rundeck@172.28.128.2
    sudo -u adminRundeck sshpass -p rundeck ssh-copy-id rundeck@172.28.128.2
fi
if [ "$VM" = "mail" ]
then
    sudo apt-get -y update
    sudo apt-get -y install vim
    sudo apt-get -y install nano
    sudo debconf-set-selections <<< "postfix postfix/mailname string localhost"
    sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
    sudo apt-get -y install postfix sasl2-bin
    sudo apt-get -y install nfs-common
    sudo -u root adduser --quiet --disabled-password --shell /bin/bash --home /home/rundeck --gecos "User" rundeck
    sudo -u root echo "rundeck:rundeck" | sudo -u root chpasswd
    sudo -u root usermod -aG sudo rundeck
    sudo -u rundeck ssh-keygen -t rsa -N "" -f /home/rundeck/.ssh/id_rsa
    sudo -u rundeck echo rundeck && sudo -S chmod 777 /etc/ssh/sshd_config
    sudo -u rundeck echo rundeck && sudo -S sed -i '$d' /etc/ssh/sshd_config 
    sudo -u rundeck echo rundeck && sudo -S echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
    sudo -u rundeck echo rundeck && sudo -S echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    sudo -u rundeck echo rundeck && sudo -S chmod 644 /etc/ssh/sshd_config 
    sudo -u rundeck echo rundeck && sudo -S systemctl restart sshd
fi

if [ "$VM" = "web" ];then
    sudo apt-get -y update
    sudo apt-get -y install vim
    sudo apt-get -y install apache2
    sudo apt-get -y install nfs-common
    sudo -u root adduser --quiet --disabled-password --shell /bin/bash --home /home/rundeck --gecos "User" rundeck
    sudo -u root echo "rundeck:rundeck" | sudo -u root chpasswd
    sudo -u root usermod -aG sudo rundeck
    sudo -u rundeck ssh-keygen -t rsa -N "" -f /home/rundeck/.ssh/id_rsa
    sudo -u rundeck echo rundeck && sudo -S chmod 777 /etc/ssh/sshd_config
    sudo -u rundeck echo rundeck && sudo -S sed -i '$d' /etc/ssh/sshd_config 
    sudo -u rundeck echo rundeck && sudo -S echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
    sudo -u rundeck echo rundeck && sudo -S echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    sudo -u rundeck echo rundeck && sudo -S chmod 644 /etc/ssh/sshd_config 
    sudo -u rundeck echo rundeck && sudo -S systemctl restart sshd
fi
if [ "$VM" = "nfs" ];then
    sudo apt-get -y update
    sudo apt-get -y install vim
    sudo apt-get -y install nfs-common
    sudo -u root adduser --quiet --disabled-password --shell /bin/bash --home /home/rundeck --gecos "User" rundeck
    sudo -u root echo "rundeck:rundeck" | sudo -u root chpasswd
    sudo -u root usermod -aG sudo rundeck
    sudo -u rundeck ssh-keygen -t rsa -N "" -f /home/rundeck/.ssh/id_rsa
    sudo -u rundeck echo rundeck && sudo -S chmod 777 /etc/ssh/sshd_config
    sudo -u rundeck echo rundeck && sudo -S sed -i '$d' /etc/ssh/sshd_config 
    sudo -u rundeck echo rundeck && sudo -S echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
    sudo -u rundeck echo rundeck && sudo -S echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    sudo -u rundeck echo rundeck && sudo -S chmod 644 /etc/ssh/sshd_config 
    sudo -u rundeck echo rundeck && sudo -S systemctl restart sshd
fi
