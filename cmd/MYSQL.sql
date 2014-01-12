show create database sunqi;  
show create table sunqi;  
create database db default character set utf8
create table sunqi(...) engin=innodb|MyISAM (ingore case)
./configure --help | grep charset

desc

select a.a b.b from a (inner join | left outer join | right outer join) b on a.c=b.c;

-- full join
left join
union
rigth join

seq 1 100
load data infile "path.sql" into table t;
--export
select * from t3 into outfile "/var/lib/mysql/sunqi/back_t3.sql" [fileds terminated by ","]
select * from t3 into outfile "/var/lib/mysql/sunqi/back_t3.sql" fileds terminated by ","
load data infile "path.sql" into table t fileds terminated by ",";

alter table tb_name add column col_name int;
alter table tb_name drop column col_name int;

# FOREIGN KEY | UNIQUE | primary key
alter table tb_name add constraint pk_name primary key(id,...);
alter table tb_name add constraint fk_name foreign key(col_name) references other_tb_name(pk_col_name);
alter table tb_name drop primary key;
alter table tb_name add constraint check(id)<100;

alter table tb_name add index idx_name(column);
alter table tb_name add key(column);

alter tabel tb_name modify col_name int not null;

alter table tb_name alter column col_name set default "man"

create table t(id int auto_increment,...);

--auto commit 
set autocommit=1
set autocommit=0	--close

--grant
grant all on *.* to scott@ip identfied by "paswd";
select * from mysql.user where user="root" \G;

--backup
mysqldump -uroot -p123 dbname > /var/lib/mysql/dbname/backup.sql
--truncate logbinfile
mysqldump -uroot -p123 -F dbname > /var/lib/mysql/dbname/backup.sql
--recouver
mysql -uroot -p123 dbname < /var/lib/mysql/dbname/backup.sql
source /var/lib/mysql/dbname/backup.sql

--log
show variables like "%log%";
-- /etc/my.cnf
log-bin=/var/lib/mysql/mysql-bin.log
show master status;
reset master
flush logs;
-- scan binlog
mysqlbinlog .log
mysqlbinlog .log --stop-position=296 | mysql -u -p dnamee;
mysqlbinlog .log --start-date=296 --stop-date=296 | mysql -u -p dnamee;

--clone 
1. host1 mysqldump >
2. host2 mysql <
3. copy log file
