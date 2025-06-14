select b.nombre,avg(a.valor) from factura a,cliente b where a.cedula=b.cedula and to_char(fecha_factura,'yyyy')='2006' and a.cedula not in(select cedula from factura where
       to_char(fecha_factura,'yyyy')='2005') Group by b.nombre


select sum(valor) as valor from factura where to_char(fecha_factura,'yyyy')='2006'  and to_char(fecha_factura,'mm')<>'02'
