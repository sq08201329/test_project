#!/bin/bash

#1.安装前准备
echo 'install prepare package'
yum -y install binutils compat-db control-center gcc gcc glibc libXp libstdc++ libstdc++-devel make openmotif 
rpm -ivh /root/rhel_disk/Server/libXp-*

#2.安装依赖包
yum -y install control-center
yum -y install sysstat

#3.修改语言
sed -i '1d' /etc/sysconfig/i18n 
echo '
LANG="en_US.UTF-8"
SYSFONT="latarcyrheb-sun16" ' >> /etc/sysconfig/i18n

#3.root用户设置核心参数
 echo '#(共享内存,单位是页面数 x86的32位为4k)
kernel.shmall = 2097152  
 #(单个共享内存段的最大尺寸)
kernel.shmmax = 2147483648 
# (信号量) 
kernel.sem = 250 32000 100 128 
# (文件句柄的最大数量)
fs.file-max = 65536 
net.ipv4.ip_local_port_range = 1024 65000
net.core.rmem_default = 262144
net.core.rmem_max = 262144
net.core.wmem_default = 262144
net.core.wmem_max = 262144' >> /etc/sysctl.conf

sed -i '1d' /etc/redhat-release
echo 'Red Hat Enterprise Linux Server release 3 (Tikanga)' >> /etc/redhat-release

#使内核生效
 /sbin/sysctl -p


#4.
echo ' #(文件实际是 Linux PAM,插入式认证模块)
oracle          soft    nproc           2047
oracle          hard    nproc           16384
oracle          soft    nofile          1024
oracle          hard    nofile          65536
#(   core - 限制内核文件的大小
#　　date - 最大数据大小
#　　fsize - 最大文件大小
#　　memlock - 最大锁定内存地址空间
#　　nofile - 打开文件的最大数目
#　　rss - 最大持久设置大小
#　　stack - 最大栈大小
#　　cpu - 以分钟为单位的最多 CPU 时间
#　　noproc - 进程的最大数目
#　　as - 地址空间限制
#　　maxlogins - 此用户允许登录的最大数目) ' >> /etc/security/limits.conf  

#5.
echo 'session    required     /lib/security/pam_limits.so' >> /etc/pam.d/login 


groupadd oinstall
groupadd dba
useradd -g oinstall -G dba oracle
echo 'The_sunqi' | passwd --stdin oracle

echo 'ORACLE_BASE=/oracle/app
ORACLE_HOME=$ORACLE_BASE/oracle/product/10.2.0/db_1
ORACLE_SID=TEST
PATH=$PATH:$HOME/bin:$ORACLE_HOME/bin
LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib
LANG=en_US.UTF-8
export ORACLE_BASE ORACLE_HOME ORACLE_SID PATH LD_LIBRARY_PATH LANG' >> /home/oracle/.bash_profile
chown oracle:oinstall /home/oracle/.bash_profile
# source .bash_profile 


#7.把oracle 安装程序 拷贝到linux
#用oracle用户 解压缩
unzip database_linux32.zip

mv database /home/oracle/
chown oracle:oinstall /home/oracle/database


#8.root用户创建安装目录 并修改/etc/hosts
#sed -i "s/64/$1" /etc/sysconfig/network-scripts/ifcfg-eth0

mkdir -p /oracle/app
chmod 777 /oracle
chown -R oracle.oinstall /oracle




#9.开始安装oracle(如果是su 切换的用户会报错Can't connect to x11 window server using  解决方式:以root用户执行：xhost +IP（本机ip）然后以oracle用户执行export DISPLAY=IP:0.0)
#以oracle 用户登陆 进入解压缩目录  ./runInstaller
#
#选择高级安装(advanced installation)
#注意此处为oinstall组点击下一步
#此处选择企业版下一步
#选择安装目录  下一步
#/oracle/app/oracle/product/10.2.0/db_1
#(注意安装目录要跟bash_profile中 ORACLE_HOME目录一样)
#
#检测是否缺乏软件包(警告为正常)下一步
#
#只安装数据库软件(install database software only)下一步
#
#选择安装
#
#安装最后提示需要root身份 执行两个脚本
#
#执行后退出即可
#
#
#--------------------------
#dbca 创建数据库
#
#数据库SID 参照 用户环境变量中的设置(TEST)
