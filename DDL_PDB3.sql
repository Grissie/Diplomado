--@AUTOR: GUTIERREZ SILVESTRE, MARCELINO CISNEROS
--@FECHA CREACION: 10/04/23
--@DESCRIPCION: CREACION DE TABLAS DE LA PDB RESTAURANTE_S3: CLIENTES Y CUENTAS

PROMPT CREANDO TABLA CLIENTE
CREATE TABLE CLIENTE
(
  CLIENTE_ID        NUMBER(10,0),
  NOMBRE            VARCHAR2(40)  NOT NULL,
  APE_PATERNO       VARCHAR2(40)  NOT NULL,   
  APE_MATERNO       VARCHAR2(40)      NULL,
  NIVEL_ESTUDIOS    VARCHAR2(40)  NOT NULL,
  EDAD              NUMBER(5,0)   NOT NULL,
  GENERO            VARCHAR2(40)  NOT NULL,
  RFC               VARCHAR2(40)  NOT NULL,
  constraint CLIENTE_PK primary key(CLIENTE_ID)
  using index
  (
    create unique index CLIENTE_PK on CLIENTE(CLIENTE_ID)
    tablespace ix_clie_cuenta_tbs
  )
)tablespace cliente_tbs;

PROMPT CREANDO TABLA MESA
CREATE TABLE MESA
(
  MESA_ID     NUMBER(5,0),
  MESA        VARCHAR2(40)    NOT NULL,
  CAPACIDAD   NUMBER(5,0)     NOT NULL,
  constraint MESA_PK primary key(MESA_ID)
  using index
  (
    create unique index MESA_PK on MESA(MESA_ID)
    tablespace ix_clie_cuenta_tbs
  )
)tablespace mesa_cuenta_tbs;

PROMPT CREANDO TABLA CUENTA
CREATE TABLE CUENTA
(
  CUENTA_ID         NUMBER(5,0),
  FECHA             DATE          NOT NULL,
  DESCUENTO         NUMBER(10,0)  NOT NULL,      
  COSTO_TOTAL       NUMBER(10,0)  NOT NULL,
  CLIENTE_ID        NUMBER(10,0)      NULL,
  MESA_ID           NUMBER(5,0)   NOT NULL,
  EMPLEADO_RID      NUMBER(10,0)  NOT NULL,
  constraint CUENTA_PK primary key(CUENTA_ID)
  using index
  (
    create unique index CUENTA_PK on CUENTA(CUENTA_ID)
    tablespace ix_clie_cuenta_tbs
  ),
  CONSTRAINT CUENTA_CLIENTE_ID_FK FOREIGN KEY (CLIENTE_ID)
  REFERENCES CLIENTE(CLIENTE_ID),
  CONSTRAINT CUENTA_MESA_ID_FK FOREIGN KEY (MESA_ID)
  REFERENCES MESA(MESA_ID)
)tablespace mesa_cuenta_tbs;

PROMPT CREANDO INDICES
CREATE INDEX CUENTA_COSTO_TOTAL_IX ON CUENTA(COSTO_TOTAL)
  tablespace ix_clie_cuenta_tbs;

CREATE UNIQUE INDEX CLIENTE_RFC_UIX ON CLIENTE(RFC)
  tablespace ix_clie_cuenta_tbs;

CREATE INDEX CLIENTE_EDAD_IX ON CLIENTE(EDAD)
  tablespace ix_clie_cuenta_tbs;

CREATE INDEX CUENTA_MESA_IX ON CUENTA(MESA_ID)
  tablespace ix_clie_cuenta_tbs;

CREATE INDEX CUENTA_FECHA_IX ON CUENTA(to_char(FECHA,'yyyy/mm'))
  tablespace ix_clie_cuenta_tbs;