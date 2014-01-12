--/etc/fstab
tmpfs                   /dev/shm                tmpfs   defaults,size=10240M        0 0

begin
  drop table t;
  create table t as select * from all_objects;
  create index idx_object_id on t(object_id);
  set autotrace on;
  set linesize 1000;
  set timing on;
--index
  select object_name from t where object_id=29;
end;
--full table
select /*+full(t)*/ object_name from t where object_id=29;

alter system set events 'immediate trace name flush_cache'
set autotrace traceonly statistics
set autotrace off
set autotrace on
/

show parameter undo
show parameter sga
show parameter pga
show parameter shared_pool_size
show parameter db_cache_size
show parameter log_buffer
show parameter memory_target
ipcs -m

--scope default value is both
alter system set parameter_name=val [scope=memory|spfile|both [sid=SUNQI]
alter system set sga_target=100M scope=both

show parameter instance_name

--conn / as sysdba
archive log list

 --open archive log
shutdown immediate
startup mount
alter database archivelog
alter database open

--starup database
1. startup nomount --success condition -->read pfile|spfile --> malloc memory --> start relation process background <==> create instance
	show parameter spfile --paarmeter file position
	ps -ef | grep instance_name
	ipc -m
2. startup mount   -- control file can be normal read
	show parameter control --control file position
3. alter database open -- sure  file and record same
	select file_name from dba_data_files --data file position
--archice log postion
show parameter recovery
--log file position
select group#, member from v$logfile;
--warning log file  ^alert
show parameter dump

--listen 
--$ORACLE_HOME/network/admin/tnsnames.ora
lsnrctl status
lsnrctl start
lsnrctl stop

--env created
drop table t purge;
create table t(x int);
	--flush share pool
alter system flush shared_pool;
	--proc
create or replace procedure proc1
as
begin
	for i in 1..100000
	loop
		execute immediate
		'insert into t values('||i||')';
	commit;
	end loop;
end;
/
-- scan shared info
select t.sql_text, t.sql_id, t.PARSE_CALLS, t.EXECUTIONS from v$sql t where sql_text like '%insert into t values%';
--bike speed --bing var
create or replace procedure proc2
as
begin
        for i in 1..100000
        loop
                execute immediate
                'insert into t values(:x)' using i;
        commit;
        end loop;
end;
/
--car speed --static writing
create or replace procedure proc3
as
begin
        for i in 1..100000
        loop
                insert into t values(i);
        commit;
        end loop;
end;
/
--train --bat commit
create or replace procedure proc4
as
begin
        for i in 1..100000
        loop
                insert into t values(i);
        end loop;
        commit;
end;
/
--plane
insert into t select rownum from dual connect by level<=100000;
insert into t select rownum from dual connect by level<=1000000;
/
-- rocket
create table t as select rownum from dual connect by level<=1000000;
--spaceship
create table t nologging parallel 4 as select rownum as x from dual connect by level<=1000000;

--chapter 3 : logic 
-- block size
show paramter db_block_size
select block_size from dba_tablespaces where tablespace_name='SYSTEM';
--normal data tablespace
create tablespace tbs_a datafile '/ora/app/oracle/oradata/sunqi/tbs_a.dbf' size 50M extent management local segment space management auto
select file_name, tablespace_name, AUTOEXTENSIBLE, BYTES from dba_data_files where tablespace_name='TBS_A' order by substr(file_name, -12);
--tmp tablespace
create temporary tablespace tmp_tbs_a tempfile '/ora/app/oracle/oradata/sunqi/tmp_tbs_a.dbf' size 50M;
select file_name, tablespace_name, AUTOEXTENSIBLE, BYTES from dba_temp_files where tablespace_name='TMP_TBS_A' order by substr(file_name, -12);
--undo tablespace
create undo tablespace undo_tbs_a datafile '/ora/app/oracle/oradata/sunqi/undo_tbs_a.dbf' size 50M;
select file_name, tablespace_name, AUTOEXTENSIBLE, BYTES/1024/1024 as bytes_M from dba_data_files where tablespace_name='UNDO_TBS_A' order by substr(file_name, -12);
--system tablespace
select file_name, tablespace_name, AUTOEXTENSIBLE, BYTES/1024/1024 as bytes_M from dba_data_files where tablespace_name like 'SYS%' order by substr(file_name, -12);
-- system and user tablespace is permanent
select tablespace_name, contents from dba_tablespaces where tablespace_name in ('TBS_A', 'TMP_TBS_A', 'UNDO_TBS_A', 'SYSTEM', 'SYSAUX');

--specified user tablespace
sqlplus / as sysdba
drop user sunqi cascade;
create user sunqi identified by The_sunqi default tablespace TBS_A temporary tablespace TMP_TBS_A ;
grant dba to sunqi;
grant CREATE SESSION to sunqi;

--extent logic
drop table t purge;
create table t(id int) tablespace tbs_a;
select segment_name, extent_id, tablespace_name, bytes/1024/1024 as bytes_M, blocks from user_extents where segment_name='T';
--segment
drop table t purge;
create table t(id int) tablespace tbs_a;
select segment_name, tablespace_name, bytes/1024/1024 as bytes_M, blocks, extents from user_segments where segment_name='T'
insert into t select rownum  from dual connect by level<=1000000;
create index idx_id on t(id);
select segment_name, tablespace_name, bytes/1024/1024 as bytes_M, blocks, extents from user_segments where segment_name='IDX_ID';
select segment_name, extent_id, tablespace_name, bytes/1024/1024 as bytes_M, blocks from user_extents where segment_name='IDX_ID';

--avalible block size
show parameter cache_size
--modify block size
alter system set db_16k_cache_size=50M;
create tablespace tbs_block_16k  blocksize 16k datafile '/ora/app/oracle/oradata/sunqi/tbs_block_16K.dbf' size 50M autoextent on  extent management local segment space management auto;
select tablespace_name, block_size from dba_tablespaces where tablespace_name in ('TBS_A', 'TBS_BLOCK_16K');
--modify extent size
create tablespace tbs_uniform_block  datafile '/ora/app/oracle/oradata/sunqi/tbs_uniform_block.dbf' size 50M extent management local uniform size 10M  segment space management auto;
select tablespace_name, block_size from dba_tablespaces where tablespace_name in ('TBS_A', 'TBS_BLOCK_16K', 'TBS_UNIFORM_BLOCK');
create table t2(id int)  tablespace TBS_UNIFORM_BLOCK;
insert into t2 select rownum  from dual connect by level<=1000000;
select segment_name, extent_id, tablespace_name, bytes/1024/1024 as bytes_M, blocks from user_extents where segment_name='T2';

-- free tablespace size
select sum(bytes)/1024/1024 as free_bytes from dba_free_space where tablespace_name in ('TBS_A', 'TBS_BLOCK_16K', 'TBS_UNIFORM_BLOCK');

-- alter tablespace size
1. alter tablespace TBS_A add datafile '/ora/app/oracle/oradata/sunqi/tbs_a02.dbf' size 50M;
2. alter database datafile '/ora/app/oracle/oradata/sunqi/tbs_a02.dbf' autoextend on
select sum(bytes)/1024/1024 as free_bytes from dba_free_space where tablespace_name='TBS_A';
col file_name format a50;
select file_name, tablespace_name, AUTOEXTENSIBLE, BYTES/1024/1024 from dba_data_files where tablespace_name='TBS_A' ;
insert into t select rownum  from dual connect by level<=1000000;

--drop tablespace
drop tablespace TBS_A including contents and datafiles;
create tablespace tbs_name  datafile '/ora/app/oracle/oradata/sunqi/tbs_name.dbf' size 50M autoextend on extrnt  management local uniform size 10M /*next 64k*/  maxsize 5G segment space management auto;


--undo tablespace
show parameter undo
select tablespace_name, status from dba_tablespaces where contents='UNDO';
select tablespace_name, sum(bytes)/1024/1024 from dba_data_files where tablespace_name in ('UNDOTBS1', 'UNDO_TBS_A') group by tablespace_name
--change undo tbs
alter system set undo_tablespace=UNDO_TBS_A scope=both;
--drop
drop tablespace UNDOTBS1 including contents and datafiles;

--temp tablespace
select tablespace_name , bytes from dba_temp_files ;
select USERNAME,DEFAULT_TABLESPACE,TEMPORARY_TABLESPACE from dba_users where username='SCOTT'
--change tmp tbs
alter user scott temporary tablespace TMP_TBS_A
alter user scott default tablespace TBS_A;
select TEMPORARY_TABLESPACE, count(*) from dba_users group by TEMPORARY_TABLESPACE;
--change all dba_user
alter database temporary tablespace TMP_TBS_A

--tmp tbs group
create temporary tablespace tmp_tbs1_1 tempfile '/ora/app/oracle/oradata/sunqi/tmp_tbs1_1.dbf' size 50M tablespace group tmp_tbs_grp1;
create temporary tablespace tmp_tbs1_2 tempfile '/ora/app/oracle/oradata/sunqi/tmp_tbs1_2.dbf' size 50M tablespace group tmp_tbs_grp1;
select * from dba_tablespace_groups;

alter tablespace tmp_tbs_a tablespace group tmp_tbs_grp1;
alter user scott temporary tablespace tmp_tbs_grp1;
select USERNAME,DEFAULT_TABLESPACE,TEMPORARY_TABLESPACE from dba_users where username='SCOTT'
--more session
select a.table_name , b.table_name from all_tables a, all_tables b order by a.table_name;
select username,session_num, tablespace from v$sort_usage;

select tablespace_name,file_name,bytes/1024/1024 file_size,autoextensible from dba_temp_files;
alter database tempfile '/ora/app/oracle/oradata/sunqi/tmp_tbs1_1.dbf' autoextend on /*next 5M maxsize ulimited*/
 -- pct_dree
select pct_free from user_tables where table_name ='EMP';
update employees set first_name=LPAD('1', 2000, '*')...
alter table emp pctfree 20

-- shift optimize
sqlplus / as sysdba
--create chained_rows table
@?/ora/app/oracle/product/11.2.0/dbhome_1/rdbms/admin/utlchain.sql
 analyze table scott.emp list chained rows into chained_rows
select count(*) from chaind_rows where table_name='';


--chapt 4
--update table cost
select a.name, b.value from v$statname a, v$mystat b where a.statistic#=b.statistic# and a.name='redo size';
drop table t purge;
create table t as select * from dba_objects;
grant all on v_$mystat to scott;
grant all on v_$statname to scott;
create or replace view v_redo_size as select a.name, b.value from v$statname a, v$mystat b where a.statistic#=b.statistic# and a.name='redo size';
select * from v_redo_size;
delete from t;
select * from v_redo_size;
insert into t select * from dba_objects;
select * from v_redo_size;
update t set object_id=rownum;
select * from v_redo_size;
--delete will not free room
drop table t purge;
create table t as select * from dba_objects;
set autotrace on
select count(*) from t;
set autotrace off
delete from t;
set autotrace on
select count(*) from t;

truncate table t;
select count(*) from t;
--index table assess by index rowid
drop table t purge;
create table t as select * from dba_objects;
create index idx_object_id on t(object_id);
set autotrace on
select * from t where object_id<=10;
select object_id from t where object_id<=10;

--globl temp table
drop table t_tmp_session purge;
drop table t_tmp_transaction purge;
create global temporary table t_tmp_session on commit preserve rows as select * from dba_objects where 1=2;
select table_name, temporary,duration from user_tables where table_name='T_TMP_SESSION';
create global temporary table t_tmp_transactionon on commit delete rows as select * from dba_objects where 1=2;
select table_name, temporary,duration from user_tables where table_name='T_TMP_TRANSACTION';

select * from v_redo_size;
insert into t_tmp_transaction select * from dba_objects;
select * from v_redo_size;
insert into t_tmp_session select * from dba_objects;
select * from v_redo_size;
update t_tmp_session set object_id=rownum;
select * from v_redo_size;
update t_tmp_transaction set object_id=rownum;
select * from v_redo_size;
delete from t_tmp_session
select * from v_redo_size;
delete from t_tmp_transaction
select * from v_redo_size;

--index
drop table t1 purge;
drop table t2 purge;
drop table t3 purge;
drop table t4 purge;
drop table t5 purge;
drop table t6 purge;
drop table t7 purge;
create table t1 as select rownum as id, rownum+1 as id2 from dual connect by level<=5;
create table t2 as select rownum as id, rownum+1 as id2 from dual connect by level<=50;
create table t3 as select rownum as id, rownum+1 as id2 from dual connect by level<=500;
create table t4 as select rownum as id, rownum+1 as id2 from dual connect by level<=5000;
create table t5 as select rownum as id, rownum+1 as id2 from dual connect by level<=50000;
create table t6 as select rownum as id, rownum+1 as id2 from dual connect by level<=500000;
create table t7 as select rownum as id, rownum+1 as id2 from dual connect by level<=5000000;
create index idx_id_t1 on t1(id);
create index idx_id_t2 on t2(id);
create index idx_id_t3 on t3(id);
create index idx_id_t4 on t4(id);
create index idx_id_t5 on t5(id);
create index idx_id_t6 on t6(id);
create index idx_id_t7 on t7(id);
select segment_name, bytes/1024 from user_segments where segment_name in ('IDX_ID_T1', 'IDX_ID_T2', 'IDX_ID_T3', 'IDX_ID_T4', 'IDX_ID_T5', 'IDX_ID_T6', 'IDX_ID_T7');
select index_name, blevel, leaf_blocks, num_rows, distinct_keys, clustering_factor from user_ind_statisitcs;

--OEM
emctl stop dbconsole
emca -repos recreate
alter user DBSNMP identified by abc;
emca -config dbcontrol db
emctl status dbconsole
emctl start dbconsole


