
n=207
while [ $n -eq 0 ]; do
while :
do
num=`ps -ef | grep wget | nl | awk '{printf("%d", NR)}'`
if [ $num -eq 1 ];then
    echo `date` >> time
    break
else
    if [ ! -s ./time ] ; then
	echo `date` > time
    fi
fi
n=$((n-1))
done
done
