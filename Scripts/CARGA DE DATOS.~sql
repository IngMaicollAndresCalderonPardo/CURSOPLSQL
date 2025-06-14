--CARGE DE DATOS
--
--Carga de valores
INSERT INTO emp (id, name, sal, comm, deptno)
VALUES (4160, 'ADRIAN', 2045, NULL, 30);

--Carga desde Consulta
INSERT INTO bonus SELECT name, sal, comm FROM
emp WHERE comm > sal * 0.25;

--Carga a varias tablas
INSERT ALL
WHEN order_total < 1000000 THEN INTO
small_orders
WHEN order_total > 1000000 AND order_total <
2000000 THEN INTO medium_orders
WHEN order_total > 2000000 THEN INTO
large_orders
SELECT order_id, order_total, sales_rep_id,
customer_id FROM orders;
