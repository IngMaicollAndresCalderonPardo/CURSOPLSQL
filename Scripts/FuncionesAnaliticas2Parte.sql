---CAPACIDADES ANALITICAS 

SELECT cedula, 
nro_factura, 
fecha_factura, 
SUM(valor)
FROM factura
GROUP BY cedula, 
nro_factura, 
fecha_factura;

      
--ROLLUP - Ejemplos

SELECT cedula, 
nro_factura, 
fecha_factura, 
sum(valor)
From factura
GROUP BY ROLLUP(cedula, nro_factura, fecha_factura);

--ROLLUP PARCIAL
--Valor por cada cedula y valor total por cedula
select f.cedula,sum(valor)
from factura f
GROUP BY f.cedula,ROLLUP(valor);


select f.cedula,sum(valor)
from factura f
GROUP BY ROLLUP(cedula,valor);

--CUBE-
--Este calcula todos los subtotales relativos a la consulta
---Genera todos los totales para cada una de las dimensiones
--del cubo de datos

--EJEMPLO 

SELECT cedula, 
nro_factura,  
sum(ROUND (valor/1000,2))
From factura
GROUP BY CUBE (cedula, nro_factura);


--CUBE PARCIAL 
SELECT cedula, 
nro_factura,
fecha_creacion,
sum(ROUND (valor/1000,2))
From factura
GROUP BY fecha_creacion, CUBE (cedula, nro_factura);

--valor por cada cedula y valor total por cedula
select f.cedula, sum(valor)
from factura f
group by f.cedula, CUBE(valor)

--valor por cada cedula, valor total por cedula,valor general
select f.cedula,sum(valor)
from factura f
group by CUBE(cedula,valor)

--GROUPING FUNCTIONS 
--ROLLUP y CUBE  

SELECT cedula, 
nro_factura,
fecha_creacion,
SUM(valor),
GROUPING(cedula),
GROUPING(nro_factura),
GROUPING(fecha_creacion),
GROUPING_ID(cedula,nro_factura,fecha_creacion)
FROM factura
GROUP BY CUBE(cedula,nro_factura,fecha_creacion)
HAVING GROUPING_ID(cedula,nro_factura) = 1;

--GROUPING SET 

SELECT   d.nom_departamento,ci.nom_ciudad, SUM (valor) valor
    FROM factura f, cliente c, departamento d, ciudad ci
   WHERE f.cedula = c.cedula
     AND c.cod_ciudad = ci.cod_ciudad
     AND ci.cod_departamento = d.cod_departamento
GROUP BY GROUPING SETS (nom_departamento,nom_ciudad );

--COLUMNAS COMPUESTAS 

-- AGRUPAMIENTOS CONCATENADOR 
--Genera combinaciones de grupos útiles para el análisis de datos que se está realizando.

