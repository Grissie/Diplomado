--@Autor: Eduardo y Griselda
--@Fecha creacion: 18/05/2023
--@Descripcion: Multoplexacion de redo logs y control files

define syslogon='sys/system1 as sysdba'

Prompt Conectando como sysdba
conn &syslogon

--alter session set nls_date_format='yyyy/mm/dd hh24:mi:ss';

Prompt Consulta de los datos de los redo logs
set linesize window
col status format a10
select group#, sequence#, bytes, blocksize, members, status, 
  first_change#, first_time, con_id
from v$log;

Prompt Creando grupo 4
alter database add logfile group 4
(
  '/unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/redo04a.log',
  '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/redo04b.log'
) size 60m blocksize 512;

Prompt Creando grupo 5
alter database add logfile group 5
(
  '/unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/redo05a.log',
  '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/redo05b.log'
) size 60m blocksize 512;

Prompt Creando grupo 6
alter database add logfile group 6
(
  '/unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/redo06a.log',
  '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/redo06b.log'
) size 60m blocksize 512;


Prompt Forzar log switch para liberar los grupos 1, 2 y 3
set serveroutput on
declare 
  v_group number;
begin
  loop
    select group# into v_group from v$log where status = 'CURRENT';
    dbms_output.put_line('Grupo en uso: ' ||v_group);
    if v_group in (1,2,3) then
      execute immediate 'alter system switch logfile';
    else
      exit;
    end if;
  end loop;
end;
/


Pause Analizar,[enter] para continuar

Prompt Validando que los grupos 1,2,3 no tengan status ACTIVE
declare
  v_count number;
begin
  select count(*) into v_count
  from v$log
  where status = 'ACTIVE';
  if v_count  > 0 then
    dbms_output.put_line('Forzando checkpoint para sincronizar datafiles con db_buffer');
    execute immediate 'alter system checkpoint';
  end if; 
end;
/

Prompt Eliminar grupos 1,2,3
alter database drop logfile group 1;
alter database drop logfile group 2;
alter database drop logfile group 3;

set linesize window
select * from v$log;

--Verificar las rutas que que se tienen los mismos redo logs
Prompt Eliminando archivos via S.O. 
!rm /u01/app/oracle/oradata/JGMDIP01/redo03.log
!rm /u01/app/oracle/oradata/JGMDIP01/redo02.log
!rm /u01/app/oracle/oradata/JGMDIP01/redo01.log

--Multiplexado de controlfiles
conn

ALTER SYSTEM SET CONTROL_FILES='/unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/control01.ctl', 
  '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/control02.ctl',
  '/unam-diplomado-bd/disk-03/app/oracle/oradata/JGMDIP01/control03.ctl' scope=spfile;

shutdown immediate 

--Copiamos manualmente los control files en S.O

/* Desde SO
chown -R oracle:oinstall /unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/control01.ctl
chown -R oracle:oinstall /unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/control02.ctl
chown -R oracle:oinstall /unam-diplomado-bd/disk-03/app/oracle/oradata/JGMDIP01/control03.ctl
chmod -R 755 /unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/control01.ctl
chmod -R 755 /unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/control02.ctl
chmod -R 755 /unam-diplomado-bd/disk-03/app/oracle/oradata/JGMDIP01/control03.ctl
*/ 

exit