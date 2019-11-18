#!/bin/bash
############################################################################################################
#
# Author: Danilo Sbordone
# Data: 18/11/2019
# Script bash per l'installazione di apache in ambienti diversi, anche se in questi casi è preferibile Ansible
#
#############################################################################################################

WORKDIR="WORKDIR=/home/myprogram/"
echo $WORKDIR > /etc/myprogram.conf

for servername in vm-{01..50}.fbk.com
do
    test=`ssh user@$servername "uname -a | grep ubuntu| wc -l" `
    if [ "$test" -gt "0" ]; then
       app=`ssh user@$servername "sudo apt-get -y install apache2" `
    else
       app=`ssh user@$servername "sudo yum -y install httpd" `
    fi
done 
