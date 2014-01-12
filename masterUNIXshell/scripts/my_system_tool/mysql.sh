if [ $1 -eq 1 ]
then
	yum -y install mysql-server
	service mysqld start
	mysqladmin -uroot password The_sunqi
	mysql -u root -p
elif [ $1 -eq 2 ]
	yum -y install gcc
	yum -y install ncurses-devel
	yum -y install gcc-c++
	make; make install

fi
