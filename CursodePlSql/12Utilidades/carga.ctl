load data
infile  'c:\basura\ctl\cliente.csv'
append
into table qqq.cliente
fields terminated by ';' optionally enclosed by '"'
trailing nullcols
(cedula, nombre, telefono,cod_ciudad, estado_cliente)
