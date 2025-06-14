DECLARE
TYPE VECTOR_NUMEROS IS TABLE OF NUMBER 
  INDEX BY BINARY_INTEGER;
  
  NUMEROS VECTOR_NUMEROS;
BEGIN
  FOR i IN 1 .. 12 LOOP
     NUMEROS (i) := i * 10;
   END LOOP;
   --
   DBMS_OUTPUT.put_line ('TABLA DE MULTIPLICAR');
   DBMS_OUTPUT.put_line ('--------------------');
   --
   FOR i IN 1 .. 12 LOOP 
      DBMS_OUTPUT.put_line ('NUMERO '  || NUMEROS (i));
   END LOOP;
END;    


DECLARE
   TYPE REG_CLIENTE IS RECORD (
      CEDULA   CLIENTE.CEDULA%TYPE,
      NOMBRE   CLIENTE.NOMBRE%TYPE
   );

   TYPE VEC_CLIENTE IS TABLE OF REG_CLIENTE
      INDEX BY BINARY_INTEGER;

   CURSOR C_CLIENTE IS
      SELECT CEDULA, NOMBRE  FROM CLIENTE ;

   V_CLIENTE   VEC_CLIENTE;
   j           NUMBER;
   
BEGIN
   
   j:=0;
   
   FOR i IN C_CLIENTE LOOP
      V_CLIENTE (j).CEDULA := i.CEDULA;
      V_CLIENTE (j).NOMBRE := i.NOMBRE;
      j:=j+1;
   END LOOP;
   ---
   DBMS_OUTPUT.put_line ('TABLA DE CLIENTE');
   DBMS_OUTPUT.put_line ('----------------');
   --
   FOR j IN V_CLIENTE.FIRST .. V_CLIENTE.LAST LOOP
      DBMS_OUTPUT.put_line (LPAD(V_CLIENTE (j).CEDULA,2,'0')|| ' - '||V_CLIENTE (j).NOMBRE);
   END LOOP;
END;


DECLARE
   TYPE REG_CLIENTE IS RECORD (
        NOMBRE   CLIENTE.NOMBRE%TYPE
   );

   TYPE VEC_CLIENTE IS TABLE OF REG_CLIENTE
      INDEX BY BINARY_INTEGER;

   CURSOR C_CLIENTE IS
      SELECT NOMBRE  FROM CLIENTE ORDER BY CEDULA ;

   V_CLIENTE   VEC_CLIENTE;
   j           NUMBER;
   
BEGIN
   
   j:=0;
   
   FOR i IN C_CLIENTE LOOP
      V_CLIENTE (j).NOMBRE := i.NOMBRE;
      j:=j+1;
   END LOOP;
   ---
   DBMS_OUTPUT.put_line ('TABLA DE CLIENTE INDEXADA POR CEDULA');
   DBMS_OUTPUT.put_line ('------------------------------------');
   --
   FOR j IN V_CLIENTE.FIRST .. V_CLIENTE.LAST LOOP
      DBMS_OUTPUT.put_line (V_CLIENTE (j).NOMBRE);
   END LOOP;
END;
