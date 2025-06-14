-- Start of DDL Script for Package SEGU.PAK_CORREO
-- Generated 14-Abr-2010 20:33:07 from SEGU@XE

CREATE OR REPLACE 
PACKAGE pak_correo IS
/*
VERSION:    1.0
AUTOR:      Uriel Cardenas - Yeomar Rios
COPYRIGHT:

DESCRIPCION:

HISTORIAL DE CAMBIOS
AUTOR       FECHA             ACTIVIDAD
---------   ----------------  ----------------------------------
UCN         03/05/2008        Creacion del paquete
*/
   TYPE lista IS TABLE OF VARCHAR2 (255)
      INDEX BY BINARY_INTEGER;

   mail_host          VARCHAR2 (100)      := '192.168.2.251';
   conexion           UTL_SMTP.connection;
   lista_de_correos   LONG;

--Envia un correo a la lista de destinatarios
   PROCEDURE enviar (destino IN lista, tema IN VARCHAR2, mensaje IN VARCHAR2);

--Crea la lista de destinatarios en en vector
   FUNCTION lista_email (p_cadena IN VARCHAR2, p_vector_lista IN lista)
      RETURN VARCHAR2;
END;
/

-- Grants for Package
GRANT EXECUTE ON pak_correo TO sgi_consulta
/
GRANT EXECUTE ON pak_correo TO sgi_actualizacion
/

CREATE OR REPLACE 
PACKAGE BODY      pak_correo IS
   PROCEDURE enviar (destino IN lista, tema IN VARCHAR2, mensaje IN VARCHAR2) AS
      correo_administrador   VARCHAR2 (40) := 'uriel@qq.com';
      sistema                VARCHAR2 (20) := 'Sistema SGI';
   BEGIN
      conexion := UTL_SMTP.open_connection (mail_host);
      UTL_SMTP.helo (conexion, mail_host);
      UTL_SMTP.mail (conexion, correo_administrador);
      lista_de_correos := lista_email ('To: ', destino);
      UTL_SMTP.open_data (conexion);
      UTL_SMTP.write_data (conexion,
                           'From: ' || sistema || UTL_TCP.crlf
                          );
      UTL_SMTP.write_data (conexion,
                           'To: ' || lista_de_correos || UTL_TCP.crlf
                          );
      UTL_SMTP.write_data (conexion, 'Subject: ' || tema || UTL_TCP.crlf);
      UTL_SMTP.write_data (conexion, UTL_TCP.crlf || mensaje);
      UTL_SMTP.close_data (conexion);
      UTL_SMTP.quit (conexion);
   EXCEPTION
      WHEN UTL_SMTP.transient_error OR UTL_SMTP.permanent_error THEN
         UTL_SMTP.quit (conexion);
         raise_application_error (-20000,
                                  'Falló el envio del mail-Error: ' || SQLERRM
                                 );
      WHEN OTHERS THEN
         raise_application_error (-20001, 'Ocurrio el error: ' || SQLERRM);
   END enviar;

   FUNCTION lista_email (p_cadena IN VARCHAR2, p_vector_lista IN lista)
      RETURN VARCHAR2 IS
      lista_de_correos   LONG;
   BEGIN
      FOR i IN 1 .. p_vector_lista.COUNT LOOP
         UTL_SMTP.rcpt (conexion, p_vector_lista (i));

         IF (lista_de_correos IS NULL) THEN
            lista_de_correos := p_cadena || p_vector_lista (i);
         ELSE
            lista_de_correos :=
                               lista_de_correos || ', ' || p_vector_lista (i);
         END IF;
      END LOOP;

      RETURN lista_de_correos;
   END lista_email;
END pak_correo;

/*
--------------------------------------------------------------------------
-- PRUEBAS
--------------------------------------------------------------------------
--Con sys activar el servicio
DECLARE
   l_mailhost    VARCHAR2 (255)          := '172.27.1.2';
   l_mail_conn   SYS.UTL_SMTP.connection;
BEGIN
   l_mail_conn := SYS.UTL_SMTP.open_connection (l_mailhost, 25);
END;
/


DECLARE
   destino   VARCHAR2 (40)  := 'ucn@prueba.com';
   tema      VARCHAR2 (200) := 'QQ';
   mensaje   VARCHAR2 (200) := 'Toy en la base de datos';
   destina   segu.pak_correo.lista; 
BEGIN
  destina(1):=destino;
   pak_correo.enviar (destina, tema, mensaje);
END;
/
*/
/


-- End of DDL Script for Package SEGU.PAK_CORREO

