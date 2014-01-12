#!/bin/bash

sed -i "/IPADDR/d"  /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i "$ a\IPADDR=$1"  /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i "/GATEWAY/d" /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i "$ a\GATEWAY=$2" /etc/sysconfig/network-scripts/ifcfg-eth0
