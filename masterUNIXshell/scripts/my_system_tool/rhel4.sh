#!/bin/bash

if [ $# -lt 1 ]
then
	echo "USAGE: `basename $0` host-no"
	exit 1
fi
sed -i "/10/{s/10/$1/g}" /etc/hosts
sed -i "/10/{s/10/$1/g}" /etc/sysconfig/network
sed -i "$ a\set -o vi" /etc/bashrc
sed -i "$ a\stty erase ^H" /etc/bashrc

echo "
DEVICE=eth0
BOOTPROTO=static
ONBOOT=yes
IPADDR=192.168.1.$1
NETMASK=255.255.255.0
GATEWAY=192.168.1.1" > /etc/sysconfig/network-scripts/ifcfg-eth0

service network restart

sed -i.bak "/id/{s/5/3/}" /etc/inittab

mkdir /root/rhel_disk
echo '/dev/hdc          /root/rhel_disk         iso9660 defaults        0 0' >> /etc/fstab
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

yum -y install vsftpd
echo 'anon_upload_enable=YES
anon_world_readable_only=YES
anon_mkdir_write_enable=YES
anon_other_write_enable=YES' >> /etc/vsftpd/vsftpd.conf
chmod o+w /var/ftp/pub/

sed -i.bak '/root/d' /etc/vsftpd/user_list /etc/vsftpd/ftpusers

service vsftpd restart


