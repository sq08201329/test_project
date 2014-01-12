#!/bin/bash
GetKey() {
	aKey=(0 0 0)

	cEsc=`echo -ne "\033"`
	cSpace=`echo -ne "\040"`

	while :
	do
		read -s -n 1 key
		echo ${aKey[*]}
		#echo XXX
		
		aKey[0]=${aKey[1]}
		aKey[1]=${aKey[2]}
		aKey[2]=$key

		if [[ ${aKey[0]} == $cEsc && ${aKey[1]} == $cEsc ]]
		then
			MyExit
		elif [[ ${aKey[0]} == $cEsc && ${aKey[1]} == "[" ]]
		then
			if [[ $key == "A" ]] ; then echo KEYUP
			elif [[ $key == "B" ]] ; then echo KEYDOWN
			elif [[ $key == "D" ]] ; then echo KEYLEFT
			elif [[ $key == "C" ]] ; then echo KEYRIGHT
			fi
		fi

	done 
}
