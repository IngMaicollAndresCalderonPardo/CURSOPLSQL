create or replace procedure PR_PRUEBAS is
  p_cedula       cliente.cedula%type;
  r_cliente      cliente%rowtype;
  v_departamento departamento.nom_departamento%type;

  cursor c_cliente(p_cedula in cliente.cedula%type) is
    select * from cliente where cedula = p_cedula;

     cursor c_cliente_por_departamento(p_departamento in departamento.nom_departamento%type) is
    select CL.*
      from cliente cl, CIUDAD ci, departamento dp
     where cl.cod_ciudad = ci.cod_ciudad
       and ci.cod_departamento = dp.cod_departamento
       AND dp.nom_departamento = p_departamento;

  CURSOR C_orden_departamento is
    SELECT DP.NOM_DEPARTAMENTO,
           CASE NOM_DEPARTAMENTO
             WHEN 'SANTANDER' THEN
              1
             WHEN 'BOYACA' THEN
              2
             WHEN 'VALLE' THEN
              3
           END ORDEN
      FROM DEPARTAMENTO DP
     WHERE DP.NOM_DEPARTAMENTo in ('SANTANDER', 'BOYACA', 'VALLE')
     ORDER BY ORDEN;
begin

  /* for i in 1..6 loop
   p_cedula:= i * 11;
  open c_cliente(p_cedula);
   fetch c_cliente into r_cliente;
   close c_cliente;
  dbms_output.put_line (r_cliente.cedula || ' ' || r_cliente.nombre);
  end loop;*/

  /*   for i in 1..3 loop
     if i=1 THEN
        v_departamento:='SANTANDER';
     elsIF I=2 THEN
            v_departamento:='BOYACA';
          ELSIF I=3 THEN          
            v_departamento:='VALLE';
            END IF;
        dbms_output.put_line (v_departamento);
  
      FOR J IN c_cliente_por_departamento(v_departamento) LOOP
       dbms_output.put_line (J.cedula || ' ' || J.nombre); 
      END LOOP;    
  end loop;*/

  FOR i IN C_orden_departamento LOOP
    dbms_output.put_line(i.NOM_DEPARTAMENTO);
    FOR J IN c_cliente_por_departamento(i.NOM_DEPARTAMENTO) LOOP
      dbms_output.put_line(J.cedula || ' ' || J.nombre);
    END LOOP;
  END LOOP;
end PR_PRUEBAS;
/


