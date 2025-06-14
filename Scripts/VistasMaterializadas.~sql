--VISTAS MATERIALIZADAS -- 

--Es un objeto de la base de datos que almacena además 
--de la estructura misma de la vista, el resultado de una sentencia SELECT.


/*
METODOS DE CONSTRUCCION 

Inmediato (BUILD IMMEDIATE)
	– Crea la Vista
	– Ejecuta la sentencia SELECT
	– Almacena los resultados en la vista
  
Diferido (BUILD DEFERRED)
	– Crea la Vista
	– No ejecuta el SELECT

*/

--SINTAXIS--
CREATE MATERIALIZED VIEW LOG <nombre>
ON <tabla>
TABLESPACE <nombre>
STORAGE (INITIAL x NEXT y)
WITH OBJECT_ID
PRIMARY KEY
ROWID
SEQUENCE
(Col1, Col2, ... Coln)
INCLUDING | EXCLUDING NEW VALUES;

---------------------------------------------------------------------------

drop table tabla_prueba;

--Crear la tabla_prueba de prueba
CREATE  TABLE tabla_prueba
 (campo1 INT PRIMARY KEY,
 campo2 INT);

SELECT * FROM tabla_prueba
--Inserta datos

INSERT INTO tabla_prueba VALUES (1, 2);
INSERT INTO tabla_prueba VALUES (2, 298);
INSERT INTO tabla_prueba VALUES (3, 223);
INSERT INTO tabla_prueba VALUES (4, 121);
INSERT INTO tabla_prueba VALUES (5, 34);
INSERT INTO tabla_prueba VALUES (6, 34);
INSERT INTO tabla_prueba VALUES (7, 78);
INSERT INTO tabla_prueba VALUES (8, 44);
INSERT INTO tabla_prueba VALUES (9, 34);
INSERT INTO tabla_prueba VALUES (10, 12);

--Crear el view log para la tabla_prueba
CREATE MATERIALIZED VIEW LOG ON tabla_prueba  WITH PRIMARY KEY INCLUDING NEW VALUES;

--Crear la vista materializada on commit
CREATE MATERIALIZED VIEW vm_tabla_prueba_prueba
BUILD IMMEDIATE
REFRESH FAST ON COMMIT
AS SELECT * FROM tabla_prueba;

--Consulta de vista materializada
SELECT *  FROM vm_tabla_prueba_prueba;

--Consulta de tabla_prueba base
SELECT *  FROM tabla_prueba;

--Actualizar un datos de la tabla_prueba base
/* Formatted on 2010/04/30 20:08 (Formatter Plus v4.8.7) */
UPDATE tabla_prueba
   SET campo2 = 555
 WHERE campo1 = 1;


--Eliminar la vista materializada
DROP MATERIALIZED VIEW vm_tabla_prueba_prueba;

--Crear la vista materializada diferida

CREATE MATERIALIZED VIEW vm_tabla_prueba_prueba
--  TABLESPACE datos10m
BUILD DEFERRED REFRESH COMPLETE ON DEMAND
DISABLE QUERY REWRITE AS SELECT * FROM tabla_prueba;


--Refrescar la vista materializada
DECLARE
   vm   VARCHAR2 (40) := 'vm_tabla_prueba_prueba';
BEGIN
   dbms_mview.REFRESH (vm, 'C');
END;
/



--Derechos
/*
grant query rewrite to scott;
grant create materialized view to scott;
alter session set query_rewrite_enabled = true;
*/
