--@Autor: Eduardo y Griselda
--@Fecha creacion: 18/05/2023
--@Descripcion: Creacion de usuario comun y Tablespaces

define syslogon='sys/system1 as sysdba'

Prompt Conectando como sys
conn &syslogon


--Creacion del usuario comun

create user c##manager identified by manager container=ALL;
grant create session, create table, dba to c##manager container=ALL;

conn c##manager/manager


Prompt TS para PDB 1 
alter session set container = restaurante_s1;
---------------------------------------------------------------------------------
create tablespace suc_emp_tbs
datafile '/unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/suc_emp_tbs01.dbf' size 30M
autoextend on next 5M maxsize 100M
extent management local autoallocate
segment space management auto
online;

create tablespace tipos_empleado_tbs
datafile '/unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/empleados_tbs01.dbf' size 100M
autoextend on next 25M maxsize 1G
extent management local autoallocate
segment space management auto
online;

create tablespace ix_interno_tbs
datafile '/unam-diplomado-bd/disk-01/app/oracle/oradata/JGMDIP01/ix_interno_tbs01.dbf' size 30M
autoextend on next 5M maxsize 100M
extent management local autoallocate
segment space management auto
online;



Prompt TS para PDB 2
alter session set container = restaurante_s2;
---------------------------------------------------------------------------------
create tablespace platillos_tbs
datafile '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/platillos_tbs01.dbf' size 100M
autoextend on next 25M maxsize 3G
extent management local autoallocate
segment space management auto
online;


create tablespace bebidas_tbs
datafile '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/bebidas_tbs01.dbf' size 100M
autoextend on next 25M maxsize 3G
extent management local autoallocate
segment space management auto
online;


create tablespace recetas_tbs
datafile '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/recetas_tbs01.dbf' size 50M
autoextend on next 10M maxsize 1G
extent management local autoallocate
segment space management auto
online;

create tablespace BLOB_consumibles_tbs
datafile '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/BLOB_consumibles_tbs01.dbf' size 300M
autoextend on next 50M maxsize 1G
extent management local autoallocate
segment space management auto
online;

create tablespace ix_consumibles_tbs
datafile '/unam-diplomado-bd/disk-02/app/oracle/oradata/JGMDIP01/ix_consumibles_tbs01.dbf' size 30M
autoextend on next 5M maxsize 100M
extent management local autoallocate
segment space management auto
online;



Prompt TS para PDB 3
alter session set container = restaurante_s3;
---------------------------------------------------------------------------------
create tablespace mesa_cuenta_tbs
datafile '/unam-diplomado-bd/disk-03/app/oracle/oradata/JGMDIP01/mesa_cuenta_tbs01.dbf' size 200M
autoextend on next 25M maxsize 3G
extent management local autoallocate
segment space management auto
online;


create tablespace cliente_tbs
datafile '/unam-diplomado-bd/disk-03/app/oracle/oradata/JGMDIP01/cliente_tbs01.dbf' size 50M
autoextend on next 5M maxsize 500M
extent management local autoallocate
segment space management auto
online;


create tablespace ix_clie_cuenta_tbs
datafile '/unam-diplomado-bd/disk-03/app/oracle/oradata/JGMDIP01/ix_clie_cuenta_tbs01.dbf' size 30M
autoextend on next 5M maxsize 100M
extent management local autoallocate
segment space management auto
online;