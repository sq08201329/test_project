#!/bin/bash
mkdir /root/rhel_disk
echo '/dev/hdc 		/root/rhel_disk 	iso9660 defaults	0 0' >> /etc/fstab
mount -a
cd /root/rhel_disk/Server
rpm -ivh yum-3.2.22-33.el5.noarch.rpm 
cd
touch /etc/yum.repos.d/rhel-disk.repo
echo '[rhel-disk-source]
name=rhel_disk
baseurl=file:///root/rhel_disk/Server
enabled=1
gpgcheck=0' >> /etc/yum.repos.d/rhel-disk.repo

yum update

yum -y  install vim-enhanced

sh vsftpd.sh
