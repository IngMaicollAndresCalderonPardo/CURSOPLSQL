--------------------------------------------------------------------------
--SCRIPT DE TABLAS PARA PRUEBAS
--------------------------------------------------------------------------
CREATE TABLE valores    (
    uno                            NUMBER(5,0),
    dos                            NUMBER(5,0),
    tres                           NUMBER(5,0))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
/


INSERT INTO valores VALUES(1,2,3)
/
INSERT INTO valores VALUES(3,2,1)
/
INSERT INTO valores VALUES(2,1,3)
/

SELECT * FROM pruebas

CREATE TABLE pruebas
    (linea                          NUMBER(10,0),
    cadena                         VARCHAR2(500)
    )
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  system
/


-- End of DDL Script for Table QQQ.PRUEBAS

INSERT INTO PRUEBAS  VALUES (6448897,'Actualización masivas de tarifas. Nueva tarifa $45000, Anterior tarifa $75000. Autorizado por Mercadeo, Ticket Nro 7020');
INSERT INTO PRUEBAS  VALUES (6321844,'Actualización masivas de tarifas. Nueva tarifa $33000, Anterior tarifa $46800. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6489507,'Actualización masivas de tarifas. Nueva tarifa $45000, Anterior tarifa $51825. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6772817,'Actualización masivas de tarifas. Nueva tarifa $33000, Anterior tarifa $39500. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6590254,'Actualización masivas de tarifas. Nueva tarifa $45000, Anterior tarifa $48750. Autorizado por Mercadeo, Ticket Nro 7020');
INSERT INTO PRUEBAS  VALUES (6780124,'Actualización masivas de tarifas. Nueva tarifa $52000, Anterior tarifa $54975. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6591239,'Actualización masivas de tarifas. Nueva tarifa $35000, Anterior tarifa $37487. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6463335,'Actualización masivas de tarifas. Nueva tarifa $85000, Anterior tarifa $37487. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6731518,'Actualización masivas de tarifas. Nueva tarifa $35000, Anterior tarifa $37487. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6583985,'Actualización masivas de tarifas. Nueva tarifa $85000, Anterior tarifa $37487. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6361062,'Actualización masivas de tarifas. Nueva tarifa $35000, Anterior tarifa $37487. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6417970,'Actualización masivas de tarifas. Nueva tarifa $85000, Anterior tarifa $46725. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6312411,'Actualización masivas de tarifas. Nueva tarifa $45000, Anterior tarifa $46725. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6373478,'Actualización masivas de tarifas. Nueva tarifa $45000, Anterior tarifa $46724. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6459906,'Actualización masivas de tarifas. Nueva tarifa $45000, Anterior tarifa $46724. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6478473,'Actualización masivas de tarifas. Nueva tarifa $256750, Anterior tarifa $256877. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6574538,'Actualización masivas de tarifas. Nueva tarifa $256750, Anterior tarifa $256877. Autorizado por Mercadeo, Ticket Nro 7183');
INSERT INTO PRUEBAS  VALUES (6481406,'Actualización masivas de tarifas. Nueva tarifa $45000, Anterior tarifa $45022. Autorizado por Mercadeo, Ticket Nro 7183');
commit;
--------------------------------------------------------------------------
-- FIN DEL SCRIPT
--------------------------------------------------------------------------

--------------------------------------------------------------------------
-- PL QUE IMPRIMA LA CANTIDAD DE DIAS MARTES Y DOMINGO DE UN MES
--------------------------------------------------------------------------
DECLARE
   mes                 NUMBER (2)    := 3;
   dias                NUMBER;
   fecha               DATE;
   cantidad_martes     PLS_INTEGER   := 0;
   cantidad_domingos   PLS_INTEGER   := 0;
   dia                 VARCHAR2 (20);
BEGIN
   fecha := TO_DATE ('01' || LPAD (mes, 2, 0) || '2010', 'ddmmyyyy');
   dias := TO_CHAR (LAST_DAY (fecha), 'dd');

   FOR j IN 1 .. dias LOOP
      fecha := fecha + 1;
      dia := UPPER (TO_CHAR (fecha, 'day'));

--      DBMS_OUTPUT.put_line (dia);
      CASE TRIM (dia)
         WHEN 'DOMINGO' THEN
            cantidad_domingos := cantidad_domingos + 1;
         WHEN 'MARTES' THEN
            cantidad_martes := cantidad_martes + 1;
         ELSE
            NULL;
      END CASE;
   END LOOP;

   DBMS_OUTPUT.put_line ('Cantidad Martes   = ' || cantidad_martes);
   DBMS_OUTPUT.put_line ('Cantidad Domingos = ' || cantidad_domingos);
END;
/

--ALTER SESSION SET NLS_LANGUAGE=AMERICAN

--------------------------------------------------------------------------
--GENERAR UN SEMAFORO SEGUN EL VALOR
--------------------------------------------------------------------------
SELECT DECODE (LEAST (uno, dos, tres), uno, 'VERDE',decode(GREATEST (uno, dos, tres),  uno,'ROJO', 'AMARILLO')) color_uno,
       DECODE (LEAST (uno, dos, tres), dos, 'VERDE',decode(GREATEST (uno, dos, tres),  dos,'ROJO', 'AMARILLO')) color_dos,
       DECODE (LEAST (uno, dos, tres), tres, 'VERDE',decode(GREATEST (uno, dos, tres),  tres,'ROJO', 'AMARILLO')) color_tres,
       t.*
  FROM valores t;


SELECT *  FROM valores

--------------------------------------------------------------------------
--EXTRER LOS VALORES DE LA TARIFA NUEVA Y ANTERIOR DE LA CADENA
--------------------------------------------------------------------------
SELECT   linea, cadena
    FROM (SELECT t.*,
                 SUBSTR (cadena,
                         INSTR (cadena, '$') + 1,
                         INSTR (cadena, ',') - INSTR (cadena, '$') - 1
                        ) valor_nuevo,
                 SUBSTR (cadena,
                         INSTR (cadena, 'Anterior') + 17,
                         INSTR (cadena, '. A') - INSTR (cadena, 'Anterior')
                         - 17
                        ) valor_anterior
            FROM pruebas t
           WHERE cadena LIKE '%7183%') d
   WHERE TO_NUMBER (valor_nuevo) > TO_NUMBER (valor_anterior)
ORDER BY valor_anterior - valor_nuevo DESC;

--------------------------------------------------------------------------------
--OTRA MANERA DE EXTRER LOS VALORES DE LA TARIFA NUEVA Y ANTERIOR DE LA CADENA
--------------------------------------------------------------------------------
select substr(cadena, instr(cadena,'$')+1,instr(cadena,',')-instr(cadena,'$')-1) valor_nuevo,
       substr(cadena, instr(cadena, '$',1,2)+1, instr(cadena,'.',1,2)-instr(cadena, '$',1,2)-1) valor_anterior,
       cadena
from pruebas;




--------------------------------------------------------------------------------
-- Querys
--------------------------------------------------------------------------------




--Declarar una variable enter
enter varchar2(2):=chr(13)||chr(10)