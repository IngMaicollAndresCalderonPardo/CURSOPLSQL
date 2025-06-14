DECLARE
 RESULTADO NUMBER(2);
 
Begin
  RESULTADO:=0;
 
  For i IN 1..9 LOOP
     dbms_output.put_line('Tabla del '  || I);
     dbms_output.put_line('-----------');
      For j IN REVERSE  1..9 LOOP
          
          RESULTADO:=0;
        
      
          RESULTADO:= I*J;
          dbms_output.put_line(I || '*'  || J || '=' || RESULTADO );
      End lOOP; 
      dbms_output.put_line('===========');
  End lOOP;   
End;  
