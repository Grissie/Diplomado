alter session set container = cdb$root;
alter session set container = restaurante_s1;
alter session set container = restaurante_s2;
alter session set container = restaurante_s3;

show pdbs
show con_id;
show con_name;

--purge tablespace "nombre"; PARA LIBERAR SEGMENTOS
------------CONSULTA 1-------------
--			Muestra los DFs de cada PDB
col df_name format a85
col ts_name format a25
select t.name ts_name, d.bytes/1024/1024 mb, d.name df_name, d.con_id
from v$datafile d
join v$tablespace t
on d.ts# = t.ts#
where t.name != 'SYSTEM'
and t.name != 'SYSAUX'
and t.name != 'UNDOTBS1'
and t.name != 'USERS'
and t.con_id = d.con_id;



------------CONSULTA 2-------------
-- Comsulta para redo logs
col member format a80
select * from v$logfile;

col name format a70
SELECT name FROM v$controlfile;


------------CONSULTA 3-------------
-- Muestra modo archive
set linesize window
col name format a100
select name from v$archived_log;

show spparameter log_archive_dest_1
show spparameter log_archive_dest_2
archive log list

---INFO ULTIL
show spparameter log_archive_max_processes
show spparameter log_archive_format
show spparameter log_archive_min_succeed_dest

format name format a100
select * from v$archived_log;


------------CONSULTA 4------------
-- COnsulta para FRA
set linesize window
Prompt Verificando modo Flash
select flashback_on from v$database;

col name format a50
select * from V$RECOVERY_FILE_DEST;
select * from v$flash_recovery_area_usage;



------------CONSULTA 5-------------
-- CONSULTA PARA BACKUPS
col file_type format a15
col fname format 150
select pkey, file_type,fname from V$BACKUP_FILES;

list backup;
list backup summary;



------------CONSULTA 6-------------
--- CONSULTA PARA SEGMENTOS
set linesize window
col tablespace_name format a20
col segment_name format a30
select tablespace_name, segment_name, segment_type, bytes/1024/1024 mb
from user_segments
where tablespace_name != 'SYSTEM'
and tablespace_name != 'SYSAUX'
and tablespace_name != 'UNDOTBS1';