--@AUTOR: GUTIERREZ SILVESTRE, MARCELINO CISNEROS
--@FECHA CREACION: 10/04/23
--@DESCRIPCION: CREACION DE TABLAS DE LA PDB RESTAURANTE_S1: EMPLEADOS Y SUCURSALES

PROMPT CREANDO TABLA SUCURSAL
CREATE TABLE SUCURSAL
(
  SUCURSAL_ID   NUMBER(10,0),
  SUCURSAL      VARCHAR2(200)   NOT NULL,
  UBICACION     VARCHAR2(200)   NOT NULL,
  constraint sucursal_pk primary key(SUCURSAL_ID)
  using index
  (
    create unique index sucursal_pk on SUCURSAL(SUCURSAL_ID)
    tablespace ix_interno_tbs
  )
)tablespace suc_emp_tbs;

PROMPT CREANDO TABLA ESPECIALIDAD
CREATE TABLE ESPECIALIDAD
(
  ESPECIALIDAD_ID   NUMBER(10,0),
  ESPECIALIDAD      VARCHAR2(200)  NOT NULL,
  constraint ESPECIALIDAD_PK primary key(ESPECIALIDAD_ID)
  using index
  (
    create unique index ESPECIALIDAD_PK on ESPECIALIDAD(ESPECIALIDAD_ID)
    tablespace ix_interno_tbs
  )
)tablespace suc_emp_tbs;

PROMPT CREANDO TABLA EMPLEADO
CREATE TABLE EMPLEADO
(
  EMPLEADO_ID           NUMBER(10,0),
  TURNO                 VARCHAR2(40)     NOT NULL,
  FECHA_CONTRATACION    DATE             NOT NULL,
  TIPO_POSICION         CHAR(1)          NOT NULL,
  SUELDO                NUMBER(10,0)     NOT NULL,
  NOMBRE                VARCHAR2(40)     NOT NULL,
  APE_PATERNO           VARCHAR2(40)     NOT NULL,
  APE_MATERNO           VARCHAR2(40)     NOT NULL,
  RFC                   VARCHAR2(40)     NOT NULL,
  FECHA_NACIMIENTO      DATE             NOT NULL,
  SUCURSAL_ID           NUMBER(10,0)     NOT NULL,
  constraint empleado_pk primary key(EMPLEADO_ID)
  using index
  (
    create unique index empleado_pk on EMPLEADO(EMPLEADO_ID)
    tablespace ix_interno_tbs
  ),
  CONSTRAINT EMPLEADO_SUCURSAL_ID_FK FOREIGN KEY (SUCURSAL_ID)
  REFERENCES SUCURSAL(SUCURSAL_ID)
)tablespace suc_emp_tbs;

PROMPT CREANDO TABLA COCINERO
CREATE TABLE COCINERO
(
  EMPLEADO_ID       NUMBER(10,0),
  LIMPIEZA          CHAR(1)           NOT NULL,
  LIDERA            CHAR(1)           NOT NULL,
  INNOVA            CHAR(1)           NOT NULL,
  ESCUELA           VARCHAR2(200)     NOT NULL,
  ESPECIALIDAD_ID   NUMBER(10,0)      NOT NULL,
  constraint cocinero_pk primary key(EMPLEADO_ID)
  using index
  (
    create unique index cocinero_pk on COCINERO(EMPLEADO_ID)
    tablespace ix_interno_tbs
  ),
  CONSTRAINT COCINERO_EMPLEADO_ID_FK FOREIGN KEY (EMPLEADO_ID)
  REFERENCES EMPLEADO(EMPLEADO_ID),
  CONSTRAINT COCINERO_ESPECIALIDAD_ID_FK FOREIGN KEY(ESPECIALIDAD_ID)
  REFERENCES ESPECIALIDAD(ESPECIALIDAD_ID)
)tablespace tipos_empleado_tbs;

PROMPT CREANDO TABLA BARTENDER
CREATE TABLE BARTENDER
(
  EMPLEADO_ID       NUMBER(10,0),
  REGISTRO_IBA      VARCHAR2(40)     NOT NULL,
  NIVEL			        VARCHAR2(40)     NOT NULL,
  MIXOLOGIA         CHAR(1)          NOT NULL,
  CERTIFICACION     VARCHAR2(200)        NULL,
  constraint BARTENDER_PK primary key(EMPLEADO_ID)
  using index
  (
    create unique index BARTENDER_PK on BARTENDER(EMPLEADO_ID)
    tablespace ix_interno_tbs
  ),
  CONSTRAINT BARTENDER_EMPLEADO_ID_FK FOREIGN KEY (EMPLEADO_ID)
  REFERENCES EMPLEADO(EMPLEADO_ID)
)tablespace tipos_empleado_tbs;

PROMPT CREANDO TABLA MESERO
CREATE TABLE MESERO
(
  EMPLEADO_ID         NUMBER(10,0),
  ANIOS_EXPERIENCIA   NUMBER(10,0)     NOT NULL,
  CALIFICACION        NUMBER(5,0)      NOT NULL,
  AMABLE              CHAR(1)          NOT NULL,
  RAPIDO              CHAR(1)          NOT NULL,  
  BUENA_MEMORIA       CHAR(1)          NOT NULL,
  COOPERATIVO         CHAR(1)          NOT NULL,
  MALA_ACTITUD        CHAR(1)          NOT NULL,
  LENTO               CHAR(1)          NOT NULL,
  AGRESIVO            CHAR(1)          NOT NULL,
  DISTRAIDO           CHAR(1)          NOT NULL,
  constraint MESERO_PK primary key(EMPLEADO_ID)
  using index
  (
    create unique index MESERO_PK on MESERO(EMPLEADO_ID)
    tablespace ix_interno_tbs
  ),
  CONSTRAINT MESERO_EMPLEADO_ID_FK FOREIGN KEY (EMPLEADO_ID) 
  REFERENCES EMPLEADO(EMPLEADO_ID)
)tablespace tipos_empleado_tbs;

PROMPT CREANDO INDICES
CREATE INDEX EMPLEADO_SUELDO_IX ON EMPLEADO(SUELDO)
  tablespace ix_interno_tbs;

CREATE INDEX EMPLEADO_RFC_IX ON EMPLEADO(RFC)
  tablespace ix_interno_tbs;
CREATE INDEX COCINERO_ESPECIALIDAD_ID_IX ON COCINERO(ESPECIALIDAD_ID)
  tablespace ix_interno_tbs;

CREATE INDEX BARTENDER_REGISTRO_IBA_IX ON BARTENDER(REGISTRO_IBA)
  tablespace ix_interno_tbs;

CREATE INDEX MESERO_CALIFICACION_IX ON MESERO(CALIFICACION)
  tablespace ix_interno_tbs;