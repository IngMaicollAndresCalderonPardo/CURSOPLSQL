/*FUNCIONES ANALITICAS

Las funciones analíticas calculan un valor agregado basado en un grupo de filas.
Una función analítica trabaja sobre varias filas y devuelve el resultado en la fila actual. 
Estas se diferencian de las funciones de grupo/agregadas en que las analíticas devuelven múltiples
filas para cada grupo mientras que las grupales o agregadas retornan un valor por grupo*/
 
/*RANK() PERMITE NUMERAR LOS REGISTROS OBTENIDOS DE ACUERDO 
AL ORDEN ESPERCIFICADO POR LA CLAUSULA ORDER BY QUE ES 
OBLIGATORIA*/

--EJEMPLO

SELECT cedula,
sum(valor),
RANK()OVER(ORDER BY SUM(valor) DESC)
FROM factura
GROUP BY cedula;


--USO PRINCIPAL DE RANK

SELECT*FROM(
SELECT line,
       cedula,
       deuda,
       RANK()OVER(ORDER BY deuda)rango
       FROM lineas)
WHERE rango<=N;

--PERCENT_RANK()
--Muestra con porcentajes la posicion relativa de un registro

---------------------------------------------------------
--CUME_DIST

CUME_DIST()OVER([partition_clause]ORDER BY clause)

--DEFINIDA COMO EL PERCENTIL INVERSO

SELECT cedula,
sum(valor),
RATIO_TO_REPORT (SUM(valor))
over()
FROM factura
GROUP BY cedula;

-- NTILE -- DIVIDE LOS VALORES REPORTADOR POR LA CONSULTA
      
SELECT cedula,valor,
NTILE(10) OVER(ORDER BY valor DESC)
From factura
where valor>0;

--RADIO_TO_REPORT-OBTIENE EL PORCENTAJE QUE UNA FILA APORTA

SELECT cedula,
SUM(valor),
RATIO_TO_REPORT (SUM(valor))
OVER()
FROM factura
GROUP BY cedula;

--ANALISIS LAG -- COMPARA EL REGISTRO I, CON EL REGISTRO I+1

SELECT fecha_factura,valor,
valor-LAG(valor,1) OVER ( ORDER BY fecha_factura) 
FROM
(
SELECT TRUNC(fecha_creacion)fecha_factura,
COUNT(*)valor
FROM factura
WHERE fecha_creacion <'01-NOV-2006'
GROUP BY TRUNC(fecha_creacion)
ORDER BY 1
);

--ANALISIS LEAD -- COMPARA EL REGISTRO I, CON EL REGISTRO I+1
SELECT fecha_factura,valor,
valor-LEAD(valor,1) OVER ( ORDER BY fecha_factura) 
FROM
(
SELECT TRUNC(fecha_creacion)fecha_factura,
COUNT(*)valor
FROM factura
WHERE fecha_creacion <'01-NOV-2006'
GROUP BY TRUNC(fecha_creacion)
ORDER BY 1
);





