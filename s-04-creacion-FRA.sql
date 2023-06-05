--@Autor: Eduardo y Griselda
--@Fecha creacion: 18/05/2023
--@Descripcion: Habilitacion de la FRA

define syslog='sys/system1 as sysdba'

set linesize window
set verify off

Prompt Conectando como sys
conn &syslog

Prompt Configurando FRA
alter system set db_recovery_file_dest_size = 8G scope=both;
alter system set db_recovery_file_dest = '/unam-diplomado-bd/fast-recovery-area' scope=both;
alter system set db_flashback_retention_target = 4320 scope=both;
alter system set log_archive_dest_2='LOCATION=use_db_recovery_file_dest MANDATORY' scope=spfile;

shutdown immediate;
startup mount;

Prompt Habilitando modo flashback
alter database flashback on;
alter database open;

alter database add logfile group 1 size 60m blocksize 512;
alter database add logfile group 2 size 60m blocksize 512;
alter database add logfile group 3 size 60m blocksize 512;


alter database add logfile member
  '/unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/redo01b.log',
  '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/redo01c.log' to group 1;
alter database add logfile member
  '/unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/redo02b.log',
  '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/redo02c.log' to group 2;
alter database add logfile member
  '/unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/redo03b.log',
  '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/redo03c.log' to group 3;

set serveroutput on
declare 
  v_group number;
begin
  loop
    select group# into v_group from v$log where status = 'CURRENT';
    dbms_output.put_line('Grupo en uso: ' ||v_group);
    if v_group in (4,5,6) then
      execute immediate 'alter system switch logfile';
    else
      exit;
    end if;
  end loop;
end;
/

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

alter database drop logfile group 4;
alter database drop logfile group 5;
alter database drop logfile group 6;

--Verificar que si crearon estas en el script de redos
Prompt Eliminando archivos via S.O. 
!rm /unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/redo04a.log
!rm /unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/redo04b.log
!rm /unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/redo05a.log
!rm /unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/redo05b.log
!rm /unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/redo06a.log
!rm /unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/redo06b.log
