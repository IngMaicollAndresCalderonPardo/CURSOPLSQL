--SQL DINAMICO Y VECTORES 
/*
Consiste en la ejecución de sentencias SQL o bloques PL/SQL a partir 
de una cadena de texto montadas de manera dinámica.

-El uso de execute immediate es muy cómodo para la construcción de sql 
dinámicos el problema es el parseo de estas sentencias. Las bind variables, 
evita parseos inecesarios. Para evitar SQL Injection en PL/SQL dinámico es
importante utilizar bind variables en vez de concatenación de cadenas.*/


CREATE TABLE linea
    (nro_linea NUMBER(10,0),
     direccion VARCHAR2(100),
     cedula NUMBER(15,0))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  system


INSERT INTO linea VALUES (6302020, 'C 20#12 34', 1)
INSERT INTO linea VALUES (6402020, 'K 50 # 45-28', 2)
INSERT INTO linea VALUES (6502020, 'C 106 # 26A-05 T1 APT104', 3)

/*SINTAXIS DE INDEX 
         
DECLARE 
type tVector IS TABLE OF NUMBER(10)
     INDEX BY BINARY_INTEGER;
     
     vDatostVector;
     type tEmp IS TABLE OF empleado%ROWTYPE INDEX BY BYNARY_INTEGER;
     
     vEmpleados tEmp; */ 
     
 
--EJEMPLO
 
/*DECLARE 
TYPE tEmp IS TABLE OF employees%ROWTYPE 
     INDEX BY BINARY_INTEGER;
hasta NUMBER(3) := 104; 
vEmp tEmp;
BEGIN 
  FOR i IN 100.. hasta LOOP 
      SELECT*
      INTO vEmp(i) FROM employees 
      WHERE employee_id=i; 
  END LOOP;
  FOR i IN vEmp.FIRST.. vEmp.LASTLOOP
    DBMS_OUTPUT.PUT_LINE(vEmp(i).name);
    END LOOP;
  END;*/
  

  
--EJEMPLO REF-CURSOR 

/*TYPE cursor_prueba IS REF CURSOR;
c_prueba cursor_prueba;

OPEN c_prueba
FOR(select..);
LOOP 
  FETC c_prueba INTO qq;
  EXIT WHEN c_prueba%NOTFOUND;
  --Proceso a ejecutar 
END LOOP;
Close C_prueba;*/


--EXEXUTE INMEDIATE 

/*DECLARE 
  ret NUMBER;
  sql_str VARCHARs(1000); 
  BEGIN
  sql_st:= 'UPDATE cliente SET NOMBRE = pedro
  WHERE CODIGO = 1 '; 
  EXECUTE INMEDIATE sql_str;
  RETURN SQL%ROWCOUNT; 
 END*/
 

DECLARE
   TYPE numeros IS TABLE OF NUMBER
      INDEX BY BINARY_INTEGER;

   mis_numeros   numeros;
BEGIN
   FOR j IN 1 .. 12 LOOP
      mis_numeros (j) := j * 10;
   END LOOP;

   FOR j IN mis_numeros.FIRST .. mis_numeros.LAST LOOP
      DBMS_OUTPUT.put_line (mis_numeros (j));
   END LOOP;

   IF mis_numeros.EXISTS (5) THEN
      DBMS_OUTPUT.put_line ('existe ');
      DBMS_OUTPUT.put_line (mis_numeros (5));
   END IF;
END;

------------------------------------------------------
DECLARE
   TYPE r_cliente IS RECORD (
      cedula   cliente.cedula%TYPE,
      nombre   cliente.nombre%TYPE
   );

   TYPE vector_cliente IS TABLE OF r_cliente
      INDEX BY BINARY_INTEGER;

   CURSOR c_cliente IS
      (SELECT cedula, nombre
         FROM cliente);

   v_cliente   vector_cliente;
   i           PLS_INTEGER := 1;
BEGIN
   FOR j IN c_cliente LOOP
      v_cliente (i).cedula := j.cedula;
      v_cliente (i).nombre := j.nombre;
      i:=i+1;
   END LOOP;

   FOR j IN v_cliente.FIRST .. v_cliente.LAST LOOP
      DBMS_OUTPUT.put_line (v_cliente (j).cedula|| ' - '||v_cliente (j).nombre);
   END LOOP;

   IF v_cliente.EXISTS (5) THEN
      DBMS_OUTPUT.put_line (v_cliente (5).cedula|| ' - '||v_cliente (5).nombre);
   END IF;
END;
/


-----------------------------------------------------------

DECLARE
   TYPE vector_cliente IS TABLE OF VARCHAR2 (100)
      INDEX BY VARCHAR2 (100);

   CURSOR c_cliente IS
      (SELECT cedula, nombre
         FROM cliente);

   v_cliente   vector_cliente;
BEGIN
   v_cliente.DELETE;

   FOR j IN c_cliente LOOP
      v_cliente (j.cedula) := j.nombre;
   END LOOP;

   FOR j IN v_cliente.FIRST .. v_cliente.LAST LOOP
      IF v_cliente.EXISTS (j) THEN
--         DBMS_OUTPUT.put_line (j);
         DBMS_OUTPUT.put_line (v_cliente (j));
      END IF;
   END LOOP;
END;
/

