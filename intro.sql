/*Iniciar y deteener SQL desde terminal
Debes asegurarse de las configuraciones del sistema*/

mysql.server start
sudo /usr/local/mysql/support-files/mysql.server start

mysql.server stop
sudo /usr/local/mysql/support-files/mysql.server stop

/*Ingresar al servidor con tu usuario y contraseña*/
mysql -u tu_usuario -p

/*El siguiente comando te mostrará una lista de todas las bases de datos disponibles en tu servidor.
Verás algunas bases de datos que pueden parecer extrañas, como information_schema o mysql.
Estas son bases de datos del sistema que MySQL usa para su propio funcionamiento.*/
SHOW DATABASES;

/*Para comenzar a trabajar con una de ellas, simplemente debes seleccionarla con el comando USE.
Por ejemplo, para seleccionar la base de datos sakila debes escribir*/
USE nombre_base_de_datos;

/*Para ver las tablas que forman parte de tu base de datos, puedes usar el comando “SHOW TABLES;”.
Escribe este comando y presiona enter. Verás un listado de todas las tablas que se encuentran en sakila.*/
SHOW TABLES;

/*Para la consulta de datos siempre se utiliza la palabra “SELECT”..
Esa es la consulta más simple que puedes hacer que te traerá todas las filas de la tabla seleccionada.*/
SELECT * FROM nombre_tabla;

/*Crea una base de datos con el nombre mi_bd:*/
CREATE DATABASE mi_bd;

/*Crea una base de datos con el nombre mi_bd_2 y luego de asegurarse su creación,
eliminala utilizando el comando correspondiente: */
DROP DATABASE mi_bd_2;

/*ara crear una tabla en una base de datos se utiliza el comando "CREATE TABLE",
en el cual debes especificar el nombre de la tabla y definir las columnas que contendrá,
junto con los tipos de datos que se utilizarán para esas columnas.*/
CREATE TABLE nombre_de_la_tabla (
    nombre_columna1 tipo_de_dato restriccion_opcional,
    nombre_columna2 tipo_de_dato restriccion_opcional,
);
/*Las columnas de una tabla pueden contener una variedad de tipos de datos,
dependiendo de la naturaleza de los datos que deseas almacenar*/
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    salario DECIMAL(10, 2),
    fecha_contratacion DATE
);
/*Para ver como esta estructurada tu tabla con los tipos de datos de cada columna*/
DESC nombre_de_la _tabla;
