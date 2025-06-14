Select a.cedula,sum(a.valor) as total from factura a group by a.cedula order by a.cedula;
Select a.cedula,sum(a.valor) as total from factura a group by a.cedula,rollup(a.valor) order by a.cedula;
Select a.cedula,sum(a.valor) as total from factura a where a.cedula in (11,22) group by a.cedula,rollup(a.valor) order by a.cedula;
Select a.cedula,sum(a.valor) as total from factura a where a.cedula in (11,22) group by rollup(a.cedula,a.valor) order by a.cedula;
Select a.cedula,sum(a.valor) as total from factura a where a.cedula in (11,22) group by rollup(a.cedula) order by a.cedula;
Select d.nom_departamento,c.nom_ciudad,sum(a.valor) as total from factura a,cliente b,ciudad c,departamento d  where a.cedula=b.cedula and 
       b.cod_ciudad=c.cod_ciudad and c.cod_departamento=d.cod_departamento and a.cedula in (11,22) 
       group by rollup(d.nom_departamento,c.nom_ciudad) order by d.nom_departamento,c.nom_ciudad;
Select d.nom_departamento,c.nom_ciudad,sum(a.valor) as total from factura a,cliente b,ciudad c,departamento d  where a.cedula=b.cedula and 
       b.cod_ciudad=c.cod_ciudad and c.cod_departamento=d.cod_departamento and a.cedula in (11,22) 
       group by cube(d.nom_departamento,c.nom_ciudad) order by d.nom_departamento,c.nom_ciudad;       
 Select d.nom_departamento,c.nom_ciudad,a.cedula,sum(a.valor) as total from factura a,cliente b,ciudad c,departamento d  where a.cedula=b.cedula and 
       b.cod_ciudad=c.cod_ciudad and c.cod_departamento=d.cod_departamento and a.cedula in (11,22) 
       group by cube(d.nom_departamento,c.nom_ciudad,a.cedula) order by d.nom_departamento,c.nom_ciudad,a.cedula;       
Select d.nom_departamento,c.nom_ciudad,sum(a.valor) as total,grouping(d.nom_departamento) gd,grouping(c.nom_ciudad) gm from factura a,cliente b,ciudad c,departamento d  where a.cedula=b.cedula and 
       b.cod_ciudad=c.cod_ciudad and c.cod_departamento=d.cod_departamento and a.cedula in (11,22) 
       group by rollup(d.nom_departamento,c.nom_ciudad) order by d.nom_departamento,c.nom_ciudad;

Select decode(grouping(d.nom_departamento),1,decode(grouping(c.nom_ciudad),1,'Total','Subtotal'),decode(grouping(c.nom_ciudad),1,'SubTotal','Detallado')),
       d.nom_departamento,c.nom_ciudad,sum(a.valor) as total,grouping(d.nom_departamento) gd,grouping(c.nom_ciudad) gm
       from factura a,cliente b,ciudad c,departamento d  where a.cedula=b.cedula and 
       b.cod_ciudad=c.cod_ciudad and c.cod_departamento=d.cod_departamento and a.cedula in (11,22) 
       group by cube(d.nom_departamento,c.nom_ciudad) 
       
Select nom_departamento, nom_ciudad, total,gd,gm,decode(gd+gm,2,'Total',1,'SubTotal','Detallado') tipo from
(Select d.nom_departamento,c.nom_ciudad,sum(a.valor) as total,grouping(d.nom_departamento) gd,grouping(c.nom_ciudad) gm
       from factura a,cliente b,ciudad c,departamento d 
       where a.cedula=b.cedula and  b.cod_ciudad=c.cod_ciudad and c.cod_departamento=d.cod_departamento and a.cedula in (11,22) 
       group by cube(d.nom_departamento,c.nom_ciudad) )
 
Select nom_departamento, nom_ciudad, total,gd,gm,gc,decode(gd+gm+gc,3,'Total',0,'Detallado','SubTotal') tipo from
(Select a.cedula,d.nom_departamento,c.nom_ciudad,sum(a.valor) as total,grouping(d.nom_departamento) gd,grouping(c.nom_ciudad) gm,grouping (a.cedula) gc
       from factura a,cliente b,ciudad c,departamento d 
       where a.cedula=b.cedula and  b.cod_ciudad=c.cod_ciudad and c.cod_departamento=d.cod_departamento and a.cedula in (11,22) 
       group by cube(a.cedula,d.nom_departamento,c.nom_ciudad))
      
     
