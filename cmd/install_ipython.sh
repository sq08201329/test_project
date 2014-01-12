#wget http://www.python.org/ftp/python/2.7.2/Python-2.7.2.tgz    
tar -zxvf Python-2.7.2.tgz
cd Python-2.7.2
./configure  --prefix=/usr/local/python && make && make install
cd
#wget http://archive.ipython.org/release/0.12/ipython-0.12.tar.gz
tar -zxvf ipython-0.12.tar.gz 
cd /root/ipython-0.12
/usr/local/python/bin/python2.7  setup.py  install
/usr/local/python/bin/ipython 

#default open
easy_install readline
import rlcompleter, readline
readline.parse_and_bind('tab:complete');

#editor
!
#Automagic is ON, % prefix NOT needed for magic functions
%cd
lsmagic
magic
alias alias_name system_cmd first:"|%s|",second:"|%s|"
store alias_name 
