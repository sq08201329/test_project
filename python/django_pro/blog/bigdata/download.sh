>download.test
echo  "do you want clean data:[yY]"
read key 
echo $key | tr [a-z] [A-Z]
if [ $key = 'Y' ]; then
    rm -rf xmldata/*
else 
    exit 0
fi
path='/root/test_project/python/django_pro/blog/bigdata/xmldata/' 
#path='/root/test_project/python/django_pro/blog/bigdata/' 
citydata='meituan_divisisons'
if [ ! -f $path$citydata ]; then
    nohup wget http://www.meituan.com/api/v1/divisions -O $path$citydata
fi

host="127.0.0.1"
port="6379"
website='meituan'
redis-cli -h $host -p $port  hkeys $website | awk '{print $NF}' |  while read cityname;do 
#wget -c -b http://www.meituan.com/api/v2/$cityname/deals -O $path$website'_'$cityname'_deals';done
echo wget -c -b http://www.meituan.com/api/v2/$cityname/deals -O $path$website'_'$cityname'_deals';done>>download.test

totallines=`cat download.test | wc -l`
lines=5
startline=0
while [ $startline -lt $totallines ]; do
    processes=`ps -ef | grep wget | grep -v 'grep' | wc -l`
    if [ $processes -le $lines ]; then
	cat download.test | tail -n +$startline | head -n $lines | sh
	startline=$((startline+lines))
    fi
done

#cat wget_pid.log | grep pid | awk | while read line; do kill $line;done

