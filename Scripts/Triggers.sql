--TRIGGERS 

/*
Los disparadores (o triggers) son bloques de código PL/SQL asociados a una tabla 
y que se ejecutan automáticamente como reacción a una operación DML específica 
(INSERT, UPDATE o DELETE) sobre dicha tabla.

En definitiva, los disparadores son eventos a nivel de tabla que se ejecutan automáticamente
cuando se realizan ciertas operaciones sobre la tabla.

*/

--SINTAXIS 

CREATE {OR REPLACE} TRIGGER nombre_disp
  [BEFORE|AFTER]
  [DELETE|INSERT|UPDATE {OF columnas}] [ OR [DELETE|INSERT|UPDATE {OF columnas}]...]
  ON tabla
  [FOR EACH ROW [WHEN condicion disparo]]
[DECLARE]
  -- Declaración de variables locales
BEGIN
  -- Instrucciones de ejecución
[EXCEPTION]
  -- Instrucciones de excepción
END;
--Bloque PL/SQL que se ejecuta o “dispara” con la ocurrencia de un evento.

---EJEMPLO
CREATE OR REPLACE TRIGGER au_salario
AFTER UPDATE OF salary ON employees
BEGIN
IF :old.salary < :new.salary * 2 THEN
     RAISE_APPLICATION_ERROR (-20111,
    ‘Actualizacion de salario rechazada!’);
    END IF;
  END;

---------------------------------------------------------------

CREATE OR REPLACE TRIGGER aiud_salario
AFTER INSERT,UPDATE,DELETE ON employees
  BEGIN
    IF INSERTING THEN 
      INSERT INTO bitacora ...
    ELSIF UPDATING THEN
      validaSalario(:new.salary);
    ELSE
      INSERT INTO bitacora ...
    END IF;
  END;
  
------------------------------------------------------------------

CREATE OR REPLACE TRIGGER aiu_salario
AFTER INSERT,UPDATE ON employees
  WHEN :new.dpto = 20
  BEGIN
    IF INSERTING THEN 
      INSERT INTO bitacora ...
    ELSE THEN
      validaSalario(:new.salary);
    END IF;
  END;

-------------------------------------------------------------------------

/* 

CARACTERISTICAS DE LOS TRIGGERS 

No pueden incluir comandos para finalizar una transacción
Son implícitamente invocados o ejecutados
Pueden habilitarse o deshabilitarse
No pueden referenciar la tabla sobre la cuál han sido creados
Se eliminan al borrar la tabla con DROP TABLE
Se ejecutan siempre, sin importar la herramienta que genera el evento que los dispara.

*/


--SINTAXIS 

CREATE [OR REPLACE] TRIGGER nombre
       [temporalidad del evento]
       [granularidad del evento]
  [WHEN condición]
  BEGIN
        cuerpo del trigger
  END;

-----------
CREATE TRIGGER EjemploEdad
AFTER DELETE OF cedula ON cliente
FOR EACH ROW
WHEN ((OLD.nombre=’PEDRO’) OR (OLD.cedula =! 66))
BEGIN
DELETE FROM factura WHERE factura.cedula=:OLD.cedula;
END ;


/*

FUNCIONES

Eliminar un disparador
– DROP TRIGGER nombre_disparador

Ver todos los disparadores y su estado
– SELECT TRIGGER_NAME , STATUS FROM
USER_TRIGGERS;

ver el cuerpo de un disparador
– SELECT TRIGGER_BODY FROM
USER_TRIGGERS WHERE
TRIGGER_NAME=‘nombre_disparador’;

Ver la descripción de un disparador
– SELECT DESCRIPTION FROM
USER_TRIGGERS WHERE
TRIGGER_NAME= ‘nombre_disparador’

*/

--EJERCICIOS 

CREATE TABLE mutante
(cedula NUMBER(8,0) NOT NULL,                 
nro_factura NUMBER(8,0) NOT NULL,             
valor NUMBER(3,0)                   
)

/
CREATE OR REPLACE TRIGGER tr_almacena
   BEFORE INSERT OR UPDATE OF cedula
   ON mutante
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   pak_mutante.posicion := pak_mutante.posicion + 1;
   pak_mutante.v_cedula (pak_mutante.posicion) := :NEW.cedula;
END tr_almacena;

/
CREATE OR REPLACE TRIGGER tr_limita_lineas
   AFTER INSERT OR UPDATE OF cedula
   ON mutante
   REFERENCING NEW AS NEW OLD AS OLD
DECLARE
   nro_maximo_facturas CONSTANT NUMBER:= 3;
   cantidad NUMBER;
   p_cedula mutante.cedula%TYPE;
BEGIN
   FOR indice IN 1 .. pak_mutante.posicion LOOP
      p_cedula := pak_mutante.v_cedula (indice);

      SELECT COUNT (*)
        INTO cantidad
        FROM mutante
       WHERE cedula = p_cedula;

      IF cantidad > nro_maximo_facturas THEN
         raise_application_error (-20000,'El cliente maximo puede tener 3 facturas');
      END IF;
   END LOOP;
   pak_mutante.posicion := 0;
END tr_limita_lines;
/

CREATE OR REPLACE PACKAGE pak_mutante AS
TYPE t_cedula IS TABLE OF mutante.cedula%TYPE
INDEX BY BINARY_INTEGER;
   v_cedula   t_cedula;
   posicion   BINARY_INTEGER := 0;
END pak_mutante;
/

INSERT INTO mutante VALUES (88277790, 1, 100);

SELECT *FROM mutante ORDER BY cedula, valor;


