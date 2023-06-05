rman target /

--Creacion de BAckup Incremental
backup incremental level 0 database tag bkI_0;

--Full BAckup
backup database plus archivelog tag Inicial_full_bk1;

--Backup set en FRA y un directorio especifico
backup format as backupset database;
backup format '/unam-diplomado-bd/disk-04/JGMDIP01/backups/backup_U%' as backupset database;

--Backp as copy en FRA y un directorio especifico
BACKUP AS COPY DATABASE;
BACKUP AS COPY DATABASE FORMAT '/unam-diplomado-bd/disk-04/JGMDIP01/backups/backupCopy_U%';