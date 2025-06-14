-- PAQUETES ---------------
/*
Los paquetes en Oracle sirven para agrupar y organizar funcionalidades en una base de datos.
Son estructuras que agrupan objetos PL/SQL (funciones, procedimientos, tipos, etc.).
Ello nos va a permitir tener programas estructurados agrupados por funcionalidades.

Los Paquetes están divididos en 2 partes: especificación (obligatoria) y cuerpo (no obligatoria).

-La especificación o encabezado es la interfaz entre el Paquete y las aplicaciones que lo utilizan 
y es allí donde se declaran los tipos, variables, constantes, excepciones, cursores, procedimientos 
y funciones que podrán ser invocados desde fuera del paquete.

-En el cuerpo del paquete se implementa la especificación del mismo. 
El cuerpo contiene los detalles de implementación y declaraciones privadas, manteniéndose 
todo esto oculto a las aplicaciones externas, siguiendo el conocido concepto de “caja negra”. 
*/

--Packages--  SINTAXIS 

-- Declaración de tipos:
  TYPE <nombreTipo> IS <tipo>;

-- Declaracion de variables y constantes
  <nombreConstante> CONSTANT <tipo> := <valor>;
  <nombreVariable> <tipo>;

-- Declaraciones de funciones y procedimientos
  FUNCTION <nombreFuncion>(<parametro> <tipo>,...) RETURN <tipo>;
  PROCEDURE <nombreProcedimiento>(<parametro> <tipo>, ...);
  END <nombre_del_paquete>

----------------------------------------------------------------------
CREATE OR REPLACE PACKAGE nombre IS
  -- variables publicas
  -- declaracion de subprogramas
END nombre;

CREATE OR REPLACE PACKAGE LiqNomina IS
  pCedula empleado.cedula%TYPE;

  PROCEDURE seleccionar (pdpto IN NUMBER);
  PROCEDURE liquidar (nit IN NUMBER);
  FUNCTION valorNovedad (nit NUMBER, fecha)
		RETURN NUMBER;
END LiqNomina;

/* 

-UTILIZACION DEL PACKAGE 

Liquidar(x); -- dentro del package
liqNomina.liquidar(x);  -- desde una rutina ubicada fuera del package
user.liqNomina.liquidar(x);  -- haciendo el llamado desde otro usuario distinto del propietario del package.


-BORRADO DE PACKAGES 

DROP PACKAGE liqNomina;
DROP PACKAGE BODY liqNomina;

-ESPECIFICACION
Uso general
En ella, solo incluir las rutinas de uso público
Colocar variables en la specification si se requiere preservarlas
Compilar la specification, requiere de la compilación del body

-VENTAJAS 
Encapsulamiento
Facilita el desarrollo
Persistencia en variables globales
Mejora el rendimiento
Una sola copia del código para todos los usuarios
Dependencia entre objetos se simplifica
Overloading


*/

--OVERLOADING
--Un mismo package puede tener rutinas con el mismo nombre, diferenciadas por los parametros de entrada.

CREATE OR REPLACE PACKAGE LiqNomina IS
  PROCEDURE liquidar (nit IN NUMBER);
  PROCEDURE liquidar (  nit IN NUMBER,
          dpto IN NUMBER);
  PROCEDURE liquidar (  nit IN NUMBER ,
          dpto IN NUMBER,
          saldo IN NUMBER);
END LiqNomina;

--UTILIZACION DE FUNCIONES 
--Aplican las mismas restricciones que al llamado de funciones desde SQL.

SELECT id, 
		liqNomina.valorNovedad (id, hire_date) valor
	FROM employees;
