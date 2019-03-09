#! /bin/bash
yum -y install git ansible
mkdir /root/prep-awx
cd /root/prep-awx
git init
git remote add origin https://github.com/marc-leblanc/awx-ansible-install.git
git pull https://github.com/marc-leblanc/awx-ansible-install/
cd prep-awx
ansible-playbook prep-awx.yml
