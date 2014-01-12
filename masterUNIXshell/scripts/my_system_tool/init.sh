#!/bin/bash
sh profile.sh
if [ $# -gt 0 ]
then
	sh config_eth0.sh $1 $2
fi

sh yum.sh
