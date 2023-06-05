--@Autor: Eduardo y Griselda
--@Fecha creacion: 18/05/2023
--@Descripcion: Habilitacion de modo Archive

Prompt Habilitando el modo archive
Prompt Conectando como sysdba
conn sys/system1 as sysdba

Prompt 1. Creando pfile a partir de spfile
create pfile from spfile;

Prompt 2. Configurando parametros
--procesos ARCn
alter system set log_archive_max_processes=5 scope=spfile;

--formato del archivo
alter system set log_archive_format='arch_jgmdip01_%t_%s_%r.arc' scope=spfile;

--configuracion de 2 copias
alter system set
  log_archive_dest_1='LOCATION=/unam-diplomado-bd/disk-04/JGMDIP01/arclogs MANDATORY' scope=spfile;

alter system set
  log_archive_dest_2='LOCATION=/unam-diplomado-bd/disk-05/JGMDIP01/arclogs' scope=spfile;

--copias obligatorias
alter system set log_archive_min_succeed_dest=1 scope=spfile;

shutdown immediate
startup mount

alter database archivelog;
alter database open;

Prompt Comprobando modo archive 
archive log list

Prompt Respaldar al spfile
create pfile from spfile;

