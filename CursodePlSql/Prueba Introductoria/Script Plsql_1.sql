--SCRIPT DE BORRADO DE TABLAS

--SCRIPT DE CREACION DE TABLAS


CREATE TABLE departamento
    (cod_departamento               VARCHAR2(3) NOT NULL,
     nom_departamento               VARCHAR2(60) NOT NULL)
 /


-- Constraints for DEPARTAMENTO

ALTER TABLE departamento
ADD CONSTRAINT pk_depto PRIMARY KEY (cod_departamento)
USING INDEX
/


CREATE TABLE ciudad
    (cod_ciudad                     NUMBER(5,0) NOT NULL,
    cod_departamento          VARCHAR2(3) NOT NULL,
    nom_ciudad                     VARCHAR2(60) NOT NULL)
/


-- Constraints for CIUDAD

ALTER TABLE ciudad
ADD CONSTRAINT pk_ciudad PRIMARY KEY (cod_ciudad)
USING INDEX
/


-- Foreign Key
ALTER TABLE ciudad
ADD CONSTRAINT fk_depto FOREIGN KEY (cod_departamento)
REFERENCES departamento (cod_departamento)
/

CREATE TABLE cliente
    (cedula                         NUMBER(15,0) NOT NULL,
    nombre                         VARCHAR2(60) NOT NULL,
    telefono                       VARCHAR2(20) NOT NULL,
    cod_ciudad                     NUMBER(5,0) NOT NULL,
    estado_cliente                 VARCHAR2(1) NOT NULL)
/

-- Constraints for CLIENTE

ALTER TABLE cliente
ADD CONSTRAINT pk_cliente PRIMARY KEY (cedula)
USING INDEX
/


-- Foreign Key
ALTER TABLE cliente
ADD CONSTRAINT fk_ciudad FOREIGN KEY (cod_ciudad)
REFERENCES ciudad (cod_ciudad)
/

CREATE TABLE factura
    (cedula                         NUMBER(15,0) NOT NULL,
    nro_factura                   NUMBER(6,0) NOT NULL,
    fecha_factura               DATE NOT NULL,
    valor                            NUMBER(12,2) NOT NULL)
/


-- Constraints for FACTURA

ALTER TABLE factura
ADD CONSTRAINT pk_factura PRIMARY KEY (nro_factura)
USING INDEX
/


-- Foreign Key
ALTER TABLE factura
ADD CONSTRAINT fk_cedula FOREIGN KEY (cedula)
REFERENCES cliente (cedula)
/

 

---INLCUIR CAMPOS POR DEFECTO

ALTER TABLE factura  ADD (
    usuario_creacion   VARCHAR2(10) NOT NULL,
    fecha_creacion     DATE NOT NULL,
    usuario_modificacion   VARCHAR2(10) NOT NULL,
    fecha_modificacion DATE NOT NULL
 );


COMMENT ON COLUMN factura.fecha_creacion IS 'Fecha creacion del registro';
COMMENT ON COLUMN factura.fecha_modificacion IS 'Fecha ultima modificacion';
COMMENT ON COLUMN factura.usuario_creacion IS 'Usuario creacion del registro';
COMMENT ON COLUMN factura.usuario_modificacion IS 'Usuario ultima modificacion';

ALTER TABLE cliente  ADD (
    usuario_creacion   VARCHAR2(10) NOT NULL,
    fecha_creacion     DATE NOT NULL,
    usuario_modificacion   VARCHAR2(10) NOT NULL,
    fecha_modificacion DATE NOT NULL
 );


COMMENT ON COLUMN cliente.fecha_creacion IS 'Fecha creacion del registro';
COMMENT ON COLUMN cliente.fecha_modificacion IS 'Fecha ultima modificacion';
COMMENT ON COLUMN cliente.usuario_creacion IS 'Usuario creacion del registro';
COMMENT ON COLUMN cliente.usuario_modificacion IS 'Usuario ultima modificacion';


ALTER TABLE departamento  ADD (
    usuario_creacion   VARCHAR2(10) NOT NULL,
    fecha_creacion     DATE NOT NULL,
    usuario_modificacion   VARCHAR2(10) NOT NULL,
    fecha_modificacion DATE NOT NULL
 );


COMMENT ON COLUMN departamento.fecha_creacion IS 'Fecha creacion del registro';
COMMENT ON COLUMN departamento.fecha_modificacion IS 'Fecha ultima modificacion';
COMMENT ON COLUMN departamento.usuario_creacion IS 'Usuario creacion del registro';
COMMENT ON COLUMN departamento.usuario_modificacion IS 'Usuario ultima modificacion';


ALTER TABLE ciudad   ADD (
    usuario_creacion   VARCHAR2(10) NOT NULL,
    fecha_creacion     DATE NOT NULL,
    usuario_modificacion   VARCHAR2(10) NOT NULL,
    fecha_modificacion DATE NOT NULL
 );


COMMENT ON COLUMN ciudad.fecha_creacion IS 'Fecha creacion del registro';
COMMENT ON COLUMN ciudad.fecha_modificacion IS 'Fecha ultima modificacion';
COMMENT ON COLUMN ciudad.usuario_creacion IS 'Usuario creacion del registro';
COMMENT ON COLUMN ciudad.usuario_modificacion IS 'Usuario ultima modificacion';


--CREAR TRIGGERS

CREATE OR REPLACE TRIGGER tr_iu_factura
   BEFORE INSERT OR UPDATE
   ON factura
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   IF INSERTING THEN
      :NEW.usuario_creacion := USER;
      :NEW.fecha_creacion := SYSDATE;
   END IF;
 
   :NEW.usuario_modificacion := USER;
   :NEW.fecha_modificacion := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER tr_iu_cliente
   BEFORE INSERT OR UPDATE
   ON cliente
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   IF INSERTING THEN
      :NEW.usuario_creacion := USER;
      :NEW.fecha_creacion := SYSDATE;
   END IF;
 
   :NEW.usuario_modificacion := USER;
   :NEW.fecha_modificacion := SYSDATE;
END;
/


CREATE OR REPLACE TRIGGER tr_iu_departamento
   BEFORE INSERT OR UPDATE
   ON departamento
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   IF INSERTING THEN
      :NEW.usuario_creacion := USER;
      :NEW.fecha_creacion := SYSDATE;
   END IF;
 
      :NEW.usuario_modificacion := USER;
   :NEW.fecha_modificacion := SYSDATE;

END;
/


CREATE OR REPLACE TRIGGER tr_iu_ciudad
   BEFORE INSERT OR UPDATE
   ON ciudad
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   IF INSERTING THEN
      :NEW.usuario_creacion := USER;
      :NEW.fecha_creacion := SYSDATE;
   END IF;
 
      :NEW.usuario_modificacion := USER;
   :NEW.fecha_modificacion := SYSDATE;

END;
/



--SCRIPT DE POBLADO DE DATOS

INSERT INTO departamento (cod_departamento,nom_departamento) 
     VALUES ('1', 'SANTANDER')
/
INSERT INTO departamento (cod_departamento,nom_departamento) 
     VALUES ('2', 'CUNDINAMARCA')
/
INSERT INTO departamento (cod_departamento,nom_departamento) 
     VALUES ('3', 'BOYACA')
/
INSERT INTO departamento (cod_departamento,nom_departamento) 
     VALUES ('4', 'ANTIOQUIA')
/
INSERT INTO departamento (cod_departamento,nom_departamento) 
     VALUES ('5', 'VALLE')
/
INSERT INTO ciudad (cod_ciudad,cod_departamento, nom_ciudad)
     VALUES (10, '1', 'BUCARAMANGA')
/
INSERT INTO ciudad (cod_ciudad,cod_departamento, nom_ciudad)
     VALUES (20, '2', 'USME')
/
INSERT INTO ciudad (cod_ciudad,cod_departamento, nom_ciudad)
     VALUES (30, '3', 'TUNJA')
/
INSERT INTO ciudad (cod_ciudad,cod_departamento, nom_ciudad)
     VALUES (40, '4', 'MEDELLIN')
/
INSERT INTO ciudad (cod_ciudad,cod_departamento, nom_ciudad)
     VALUES (50, '5', 'CALI')
/

INSERT INTO cliente (cedula, nombre, telefono, cod_ciudad, estado_cliente)
     VALUES (11, 'JAIRO', '6449704', 10, 'A')
/
INSERT INTO cliente (cedula, nombre, telefono, cod_ciudad, estado_cliente)
     VALUES (22, 'URIEL', '6487954', 20, 'A')
/
INSERT INTO cliente (cedula, nombre, telefono, cod_ciudad, estado_cliente)
     VALUES (33, 'SERGIO', '6459745', 30, 'I')
/
INSERT INTO cliente (cedula, nombre, telefono, cod_ciudad, estado_cliente)
     VALUES (1, 'WILSON', '6449704', 10, 'A')
/
INSERT INTO cliente (cedula, nombre, telefono, cod_ciudad, estado_cliente)
     VALUES (2, 'JAVIER', '6487954', 10, 'A')
/
INSERT INTO qqq.cliente (cedula, nombre, telefono, cod_ciudad, estado_cliente)
     VALUES (3, 'SEBASTIAN', '6459745', 30, 'I')
/

INSERT INTO cliente (cedula, nombre, telefono, cod_ciudad, estado_cliente)
     VALUES (44, 'CLAUDIA', '6457898', 40, 'A')
/
INSERT INTO cliente (cedula, nombre, telefono, cod_ciudad, estado_cliente)
     VALUES (55, 'HUMBERTO', '6547821', 50, 'I')
/
INSERT INTO cliente (cedula, nombre, telefono, cod_ciudad, estado_cliente)
     VALUES (66, 'PEDRO', '6587458', 10, 'A')
/

INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (11, 100, '31/mar/2006', 120000)
/
INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (22, 200, '10/may/2005', 34000)
/
INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (33, 300, '08/oct/2006', 350000)
/
INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (44, 400, '10/oct/2006', 550000)
/
INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (55, 500, '01/feb/2006', 600000)
/
INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (66, 600, '10/ene/2006', 1500000)
/
INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (11, 501, '04/oct/2005', 15000)
/

INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (44, 700, '10/feb/2005', 50000)
/
INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (55, 800, '01/feb/2005', 60000)
/
INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (66, 900, '10/ene/2006', 70000)
/
INSERT INTO factura (cedula, nro_factura, fecha_factura, valor)
     VALUES (11, 502, '04/oct/2005', 90000)
/




