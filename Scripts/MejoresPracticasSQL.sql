/*  MEJORES PRACTICAS SQL 

PROCESO DE DESARROLLO 

Establecer estándares y guías de trabajo antes de escribir código
– Escogencia de las herramientas de trabajo
– Metodología para escribir código SQL en la aplicación
– Arquitectura para manejo de errores:
– Procedimiento para revisión y prueba al software
-Solicitar ayuda si se está en problemas por mas de 30 minutos
-Efectuar revisiones al código fuente escrito por otros
-Verificar el estricto cumplimiento de los estándares
-Generar código siempre que sea posible y/o conveniente
-Establecer procedimientos formales para pruebas al software
-Contar con personal externo para pruebas funcionales


ESTILO DE CODIFICACION Y CONVENCIONES 

Código escrito con un formato consistente y legible, fácil de mantener

Metodologías para nombrar objetos
– Identificar el alcance de una variable dentro de nombre:
g_XX para variables globales
l_XX para variables locales.
– Usar sufijos para todo tipo de variables (tipos de datos, registros,
colecciones, etc).
– Mayúsculas para las palabras reservadas.
– Si la variable o la rutina tiene mas de una palabra, separarlas mediante “_”.
– No mezclar mayúsculas y minúsculas dentro del nombre
– Agrupar los tipos de variables para facilidad de lectura: Types en un lugar,
Records en otro, etc.

ESTANDARIZAR LOS ENCABEZADOS DE PROGRAMAS

Todo programa debe tener
– Versión, Autor y Copyright
– Ubicación: ¿Dónde está almacenado el programa?
– Descripción: breve reseña de la funcionalidad del programa
– Parámetros: Si la rutina posee parámetros, describir c/u de ellos
– Modificaciones: Reseñar la fecha, autor del cambio y descripción del
cambio implementado, ordenados descendentemente por fecha

FINALIZAR CADA SENTENCIA END CON EL NOMBRE DEL MÓDULONOMBRE DEL MÓDULO

Toda sentencia END, debe estar seguida por el módulo o
rutina que está cerrando; esto facilita la lectura de los
programas, en especial cuando se tienen varios bloques
anidados.
– Ejemplo
Procedure antifraude(linea in number,restriccion in
number,onoff in number)
Begin
---
End; --antifraude

NOMENCLATURA OBJETOS DE BASE DE DATOS

-CHECK
Ch_<validación>
Ejemplo
Ch_sexo
Ch_valida_fecha
Ch_estado
-PRIMARY
PK_<tabla>
-FOREIGN
FK_<detalle>_<maestro>
-INDEX
IN_<tabla>_<columnas>
-TRIGGER
TR_<tabla>_<funcionalidad>
-VISTAS
VI_<nombre>
Para el nombre se usará el mismo estándar de las tablas

IDENTACIÓN

-Utilizar técnicas de identación para claridad del código , enfatizando en la relación del código con el
bloques al que pertenece.
-Utilizar siempre dos espacios, no utilizar tabulador para ello y mantener bajo el mismo nivel tanto las
sentencias que inician, como las que terminan un bloque dado
-En lo posible utilizar formateadores de código

VARIABLES Y ESTRUCTURAS DE DATOS

-NUMBER: especificar su precisión, pues si no se hace Oracle asigna un espacio de 38 dígitos de precisión y por tanto se
desperdicia memoria.
-CHAR y VARCHAR: no utilizarlos.
VARCHAR2: definir su precisión para la sarta que desea manipularse.
INTEGER: para manejo de valores enteros.
PLS_INTEGER: es el formato mas eficiente para manejo de entero


MASIVA UTILIZACIÓN DE %TYPE Y ROWTYPE

Permite a la aplicación ser flexible en cuanto a cambios en el diseño de las tablas y hace posible que los desarrolladores
separen la construcción de los programas, de la estructura de los datos a manipula

NO INICIALIZAR VARIABLES EN SU DECLARACIÓN

DECLARE F date := fecha_proceso_empresa



*/           
