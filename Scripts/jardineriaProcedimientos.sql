CREATE OR REPLACE PROCEDURE Actualiza_Salario(cuenta NUMBER, new_salario NUMBER)
IS 

BEGIN 
    UPDATE EMPLOYEE2
    SET SALARY = new_salario,
    birthdate = SYSDATE
    WHERE SALARY = cuenta;
END Actualiza_Salario;

BEGIN 
    Actualiza_Salario(100055,2500);
    COMMIT;
END;

BEGIN 
    Actualiza_Salario(cuenta => 2500, new_salario => 1700);
    COMMIT;
END;

BEGIN 
Actualiza_Salario(000070,17000);
COMMIT;
END; 

BEGIN 
Actualiza_Salario(cuenta=>000050,new_salario=>17000);
COMMIT;
END; 

select * from EMPLOYEE2;

CREATE OR REPLACE PROCEDURE today_is AS 
BEGIN
dbms_output.put_line('Hoy es'|| TO_CHAR(sysdate,'DD/MM/YYYY'));
END today_is; 

SET SERVEROUTPUT ON;
BEGIN
today2_is();
END;

CREATE OR REPLACE PROCEDURE today2_is (fecha DATE) AS 
BEGIN
dbms_output.put_line('Hoy es: '|| TO_CHAR(sysdate,'DD/MM/YYYY'));
END today2_is; 

SET SERVEROUTPUT ON;
BEGIN
today2_is(to_date('21/04/2021'));
END;

SET SERVEROUTPUT ON;
BEGIN
today2_is(fecha=>to_date('21/04/2021'));
END;



