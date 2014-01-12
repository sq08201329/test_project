#!/bin/bash
if [ $# -ne 2 ]
then
	echo -n "USAGE: `basename $0` net host\n"
	exit 1
fi
if [ $1 -eq 0 ]
then 
	net=8
	host='\2'
fi

sed -ir "/IP/{s/192\.169\.(.*)\.(.*)/192\.168\.$net\.$host/}" /etc/sysconfig/network-scripts/ifcfg-eth0
sed -ir "/GATEWAY/{s/192\.169\.(.*)\.1/192\.168\.$net\.1/}" /etc/sysconfig/network-scripts/ifcfg-eth0


