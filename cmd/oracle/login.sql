set linesize 1000
set pagesize 20
set timing on time on
set null <null>
set sqlprompt '&_user@&_connect_identifier> '
set serveroutput on

define _editor=vim

spool file
--去掉开头标题
SET HEADING OFF
--去掉结尾反馈
SET FEEDBACK OFF
--去掉开头空行
SET PAGESIZE 0
--缓冲输出，减少IO
SET FLUSH OFF
spool off
