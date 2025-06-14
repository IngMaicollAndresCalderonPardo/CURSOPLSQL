--UTILIDADES
/*
El paquete UTL_FILE permite a los programas PL/SQL leer y escribir en archivos de texto del sistema operativo.

Provee una versión restringida de las sentencias del sistema operativo para la entrada y salida de archivos 
(I/O),incluyendo las operaciones de:

Abrir un archivo
Agregar datos
Obtener datos
Cerrar un archivo
*/

--EXCEPCIONES

INVALID_PATH
READ_ERROR
WRITE_ERROR
INVALID_FILENAME
ACCESS_DENIED
DELETE_FAILED
OTHERS.

/*

Una vez que el archivo está abierto, se pueden usar los procedimientos del paquete UTL_FILE como :
PUT_LINE : Escribir un linea 
GET_LINE : Leer una línea de texto

Privilegios para utilizar UTL_FILE
Crear un directorio en el sistema operativo en el cual pueda leer y escribir archivos

- PASOS PARA ACCEDER AL FILE

1. Conectarse como usuario SYS
	CONNECT SYS/password AS SYSDBA

2. Asignar privilegios
	GRANT EXECUTE ON UTL_FILE TO nombre_usuario

3. Crear directorio
	CREATE OR REPLACE DIRECTORY temp_dir AS ‘c:\temp’

4.  Privilegios sobre el directorio al usuario
	GRANT READ, WRITE ON DIRECTORY temp_dir TO nombre_usuario

*/

GRANT EXECUTE ON UTL_FILE TO UsuarioSYS
CREATE OR REPLACE DIRECTORY temp_dir AS ‘c:\temp’

--UTL FILE

CREATE OR REPLACE PROCEDURE ejemplo_archivo AS
   cadena    VARCHAR2 (32767);
   archivo   UTL_FILE.file_type;
BEGIN
 -- Abre en el modo Append
   archivo := UTL_FILE.fopen('TEMP_DIR','mi_archivo_util_file.txt', 'W');
   
   cadena := TO_CHAR (SYSDATE) || ' UTL_FILE de prueba';
   -- Escribe una linea
   UTL_FILE.put_line (archivo, cadena); 
   UTL_FILE.fflush (archivo);  -- vacia el buffer
   UTL_FILE.fclose_all;        -- cierra todos los archivos 
EXCEPTION
WHEN utl_file.invalid_path THEN
raise_application_error(-20000, 'No existe el directorio');
END;

-----------------------------------------------------------

CREATE OR REPLACE PROCEDURE archivo_ciudad
(nombre IN VARCHAR2, codigo IN NUMBER) AS
	cadena VARCHAR2(32767);
	archivo UTL_FILE.FILE_TYPE;
BEGIN
	archivo :=
	UTL_FILE.FOPEN('directorio','ciudad.txt','A');
	cadena := RPAD(nombre,20) ||' ' ||codigo;
	UTL_FILE.PUT_LINE(archivo, cadena);
	UTL_FILE.FFLUSH(archivo);
	UTL_FILE.FCLOSE(archivo);
END;

---------------------------------------------------------------
DECLARE
   archivo   UTL_FILE.file_type;
   linea    VARCHAR2 (250);
BEGIN
   archivo := UTL_FILE.fopen ('CARGUETT', 'archivo.sh', 'R');

   LOOP
      BEGIN
         UTL_FILE.get_line (archivo, linea);
         DBMS_OUTPUT.put_line (linea);
      EXCEPTION
         WHEN OTHERS THEN
            EXIT;
      END;
   END LOOP;

   UTL_FILE.fclose (archivo);
END ;


