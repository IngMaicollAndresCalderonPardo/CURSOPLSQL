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
