CREATE TABLE mutante
    (cedula                  NUMBER(8,0) NOT NULL,
    nro_factura              NUMBER(8,0) NOT NULL,
    valor                    NUMBER(3,0)
)
/
CREATE OR REPLACE TRIGGER tr_almacena
   BEFORE INSERT OR UPDATE OF cedula
   ON mutante
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   pak_mutante.posicion := pak_mutante.posicion + 1;
   pak_mutante.v_cedula (pak_mutante.posicion) := :NEW.cedula;
END tr_almacena;
/
CREATE OR REPLACE TRIGGER tr_limita_lineas
   AFTER INSERT OR UPDATE OF cedula
   ON mutante
   REFERENCING NEW AS NEW OLD AS OLD
DECLARE
   nro_maximo_facturas   CONSTANT NUMBER                := 3;
   cantidad                       NUMBER;
   p_cedula                       mutante.cedula%TYPE;
BEGIN
   FOR indice IN 1 .. pak_mutante.posicion LOOP
      p_cedula := pak_mutante.v_cedula (indice);

      SELECT COUNT (*)
        INTO cantidad
        FROM mutante
       WHERE cedula = p_cedula;

      IF cantidad > nro_maximo_facturas THEN
         raise_application_error (-20000,'El cliente maximo puede tener 3 facturas');
      END IF;
   END LOOP;

   pak_mutante.posicion := 0;
END tr_limita_lines;
/

CREATE OR REPLACE PACKAGE pak_mutante AS
   TYPE t_cedula IS TABLE OF mutante.cedula%TYPE
      INDEX BY BINARY_INTEGER;

   v_cedula   t_cedula;
   posicion   BINARY_INTEGER := 0;
END pak_mutante;
/

INSERT INTO mutante
     VALUES (88277790, 1, 100);

SELECT   *
    FROM mutante
ORDER BY cedula, valor;
