create or replace procedure PR_PRUEBAS2(in_valor IN factura.valor%type) is
 

falla EXCEPTION;
ln_cantidad number(5);
cursor c_factura(p_valor in factura.valor%type) is
SELECT count(*) cantidad FROM FACTURA WHERE VALOR between p_valor-10000 and p_valor+10000;

BEGIN
  open c_factura(in_valor);
  fetch c_factura into ln_cantidad; 
 
  IF ln_cantidad<1 then 
    RAISE falla;
  else
    	dbms_output.put_line('Cantidad de Facturas = ' || ln_cantidad);
  END IF;
  close c_factura;
  EXCEPTION
    WHEN falla THEN
			dbms_output.put_line('no existen registros');
    
end PR_PRUEBAS2;
/
