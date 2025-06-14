
--CURSORES SQL 

/*
Un cursor es el nombre para un área memoria privada que contiene información procedente 
de la ejecución de una sentencia SELECT.
-Cada cursor tiene unos atributos que nos devuelven información útil sobre el estado del 
cursor en la ejecución de la sentencia SQL. 
-Cuando un cursor está abierto y los datos referenciados por la consulta SELECT cambian, 
estos cambios no son recogidos por el cursor.

Podemos distinguir dos tipos de cursores:

-Cursores implícitos. Este tipo de cursores se utiliza para operaciones SELECT INTO. 
Se usan cuando la consulta devuelve un único registro.

-Cursores explícitos. Son los cursores que son declarados y controlados por el programador.
Se utilizan cuando la consulta devuelve un conjunto de registros.
Ocasionalmente también se utilizan en consultas que devuelven un único registro por razones de eficiencia. 

Con cada cursor implícito debe existir la palabra clave INTO.
*/

DECLARE 
CURSOR nombre is
SELECT cedula,nombre 
FROM empleado;

SET SERVER OUTPUT ON 
BEGIN
DELETE FROM employees
      WHERE department_id = 20;
DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||'registros borrados');
END;

/*EJEMPLO
x:=5;
y:= NULL;
IF x! =y THEN
  (NO SE EJECUTA!)
  END IF; */


/*CASE 
nEstado  NUMBER(1);
vEstado  VARCHAR(20);
BEGIN
vEstado := CASE nEstado
         WHEN 1 THEN 'BUENO'
         WHEN 2 THEN 'REGULAR'
         WHEN 3 THEN 'MALO'
         ELSE 'Desconocido,
 END;*/
 
 
 /*LOOPS
   INSTRUCCIONES
   ...
   (EXIT WHEN condiciones)
  END LOOP;
  
  SE USA CUANDO LAS INSTRUCCIONES DEBEN EJECUTARSE AL MENOS 1 VEZ*/ 
  
  
 /* TIPOS DE DATOS
  
  DECLARE 
  ...
  TYPE tEmpleado  IS RECORD
  (
       cedula NUMBER(10,0)
       nombre VARCHAR2(60)
       ingreso DATE
  );             
  rEmpleado tEmpleado*/ 
  
  
  /*BEGIN
     SELECT cedula, nombre, hire_date
     INTO rEmpleado
     FROM empleado
     WHERE apellido = 'King';
     
     DBMS_OUTPUT.PUT_LINE(rEmpleado.cedula ||rEmpleado.nombre ||rEmpleado.ingreso);
     END;*/
     
  
    /* %ROWTYPE 
     EJ:
     DECLARE
     ...
     Emp rEmpleado%ROWTYPE;*/
     
     
     /*CURSORES Y REGISTROS
     
     DECLARE
     CURSOR cCliente IS
     SELECT cedula,nombre,telefono
     FROM  cliente;
     rCli cCliente%ROWTYPE;
     BEGIN
      OPEN cCliente;
      LOOP
      FETCH cCliente INTO rCli;
      ...*/
      
           
      
      /*EJEMPLOS
      
      DECLARE
       CURSOR cCliente IS
       SELECT cedula,nombre,telefono       
       from cliente
       BEGIN
        FOR j in cCliente LOOP
          --PUEDE USAR J.CEDULA,J.NOMBRE,J.TELEFONO
          ...
       END LOOP;
       END;*/ 
       
       /*
       DECLARE
       CURSOR cCliente (xNUMBER) IS
       SELECT cedula,nombre,telefono       
       from cliente
       WHERE cCliente =x;
       rCl cCliente%TYPE;
       BEGIN
        OPEN cCliente(20);
        LOOP
        FETCH cCliente INTO rCl
       */ 
       
       
       /*
       DECLARE
       xNUMBER:=20;
       BEGIN 
        FOR i IN (SELECT cedula, nombre, salario
        from cliente  
         WHERE cCliente = x) LOOP
       SELECT cedula,nombre,telefono 
        ...      
        END LOOP;
        END;
       */ 
       
       
       /*
        DECLARE
       CURSOR cCliente IS
       SELECT cedula,nombre,salario 
        FROM cliente
        FOR UPDATE OF salario;
        BEGIN 
          FOR i IN cCliente LOOP
            IF i.salario<5000 THEN
             SET salario = 50000
             WHERE CURRENT OF cCliente;
        END IF;
        END;
  
  
 /* Raise Application Error 
 
 Raise_application_error(numero,txt);
 Numero es del 20000 hasta 2099
 
 EXAMPLE
 
 BEGIN
   DELETE FROM departments
   WHERE dept_id = 20;
   IF SL%NOTFOUN THEN
     RAISE_APPLICATION_ERROR(-20m, 'Imposible Continuar');
     END IF,
     ...
 END;
 */
 
 --PRIMER EJERCICIO
 
 select b.nombre,avg(a.valor) 
 from factura a,cliente b
  where a.cedula=b.cedula 
  and to_char(fecha_factura,'yyyy')='2006' 
  and a.cedula not in(select cedula from factura 
                       where to_char(fecha_factura,'yyyy')='2005') 
                      Group by b.nombre

select 
sum(valor) as valor 
from factura 
where to_char(fecha_factura,'yyyy')='2006'  and to_char(fecha_factura,'mm')<>'02'

--SEGUNDO EJERCICIO TABLA DE MULTIPLICAR

DECLARE
 RESULTADO NUMBER(2);
 Begin
  RESULTADO:=0;
 
  For i IN 1..9 LOOP
     dbms_output.put_line('Tabla del '  || I);
     dbms_output.put_line('-----------');
      For j IN REVERSE  1..9 LOOP
          
          RESULTADO:=0;
        
      
          RESULTADO:= I*J;
          dbms_output.put_line(I || '*'  || J || '=' || RESULTADO );
      End lOOP; 
      dbms_output.put_line('===========');
  End lOOP;   
End;  
  
 
       
     
  
     
     
  
