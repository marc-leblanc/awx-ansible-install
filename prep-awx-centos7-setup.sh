#! /bin/bash
yum -y install git ansible
mkdir /root/prep-awx
cd /root/prep-awx
git init
git pull https://github.com/marc-leblanc/awx-ansible-install/
