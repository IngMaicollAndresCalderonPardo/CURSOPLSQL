load data
infile  'c:\basura\ctl\factura.csv'
append
into table qqq.factura
fields terminated by ';' optionally enclosed by '"'
trailing nullcols
(cedula, nro_factura, fecha_factura date "yyyy-mm-dd", valor)
