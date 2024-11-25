/*Modifica la columna "edad" para que no pueda tener valores nulos.*/
ALTER TABLE empleados MODIFY edad INT NOT NULL;

/*Modifica la columna "salario" para que tenga un valor predeterminado de 0
en lugar de nulo.*/
ALTER TABLE empleados MODIFY salario INT DEFAULT 0;

/*Agrega una columna llamada "departamento" de tipo VARCHAR(50) para
almacenar el departamento al que pertenece cada empleado.*/
ALTER TABLE empleados ADD departamento VARCHAR(50);

/*Agrega una columna llamada "correo_electronico" de tipo VARCHAR(100)
para almacenar las direcciones de correo electrónico de los empleados.*/
ALTER TABLE empleados ADD correo_electronico VARCHAR(50);

/*Elimina la columna "fecha_contratacion" de la tabla "empleados".*/
ALTER TABLE empleados DROP fecha_contratacion;

/*Vuelve a crear la columna "fecha_contratacion" de la tabla "empleados" pero
con un valor por default que sea la fecha actual. Para eso puedes usar las
funciones “CURRENT_DATE” o “NOW()”.*/
ALTER TABLE empleados ADD fecha_contratacion DATE DEFAULT (CURRENT_DATE);

/*Crea una nueva tabla llamada "departamentos" con las siguientes columnas:
● id (clave primaria, tipo INT AUTO_INCREMENT)
● nombre (tipo VARCHAR(50))*/
CREATE TABLE departamentos (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL
);

/*Agrega una nueva columna llamada "departamento_id" en la tabla
"empleados" que servirá como clave foránea para hacer referencia al
departamento al que pertenece cada empleado.*/
ALTER TABLE empleados ADD COLUMN departamento_id INT;

/*Modifica la tabla “empleados” y establece una restricción de clave foránea en
la columna "departamento_id" para que haga referencia a la columna "id" en
la tabla "departamentos".*/
ALTER TABLE empleados
ADD FOREIGN KEY (departamento_id)
REFERENCES departamentos(id);

/*10.Elimina el campo “departamentos” de la tabla empleados, ahora usaremos la
clave foránea para poder relacionar ambas tablas*/
ALTER TABLE empleados DROP departamento;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/*APLICANDO DML*/

/*Inserta un departamento llamado "Ventas" en la tabla "departamentos".*/
INSERT INTO departamentos (nombre) VALUES ('Ventas');

/*Inserta un departamento llamado "Recursos Humanos" en la tabla
"departamentos".*/
INSERT INTO departamentos (nombre) VALUES ('Recursos Humanos');

/*Inserta un empleado en la tabla "empleados" con los siguientes valores:
○ Nombre: Ana
○ Apellido: Rodríguez.
○ Edad: 28.
○ Salario: 3000.00.
○ Correo electrónico: anarodriguez@mail.com
○ departamento_id: (debe coincidir con el ID del departamento "Ventas"
que insertaste anteriormente, puedes saber el id haciendo una
consulta a la tabla “SELECT * FROM departamentos”).*/
INSERT INTO empleados
(nombre,apellido,edad,salario,correo_electronico,departamento _id)
VALUES ('Ana', 'Rodríguez',28,3000.00,'anarodriguez@mail.com',1 );

/*Insertar más registros*/
INSERT INTO empleados (nombre,apellido,edad,salario,correo_electronico,departamento_id)
VALUES ('Laura','Perez',26,2800.75,'lauraperez@mail.com',1),
('Martin','Gonzalez',30,3100.25,'martingonzalez@gmail.com',2);

/*Actualiza el salario del empleado con nombre "Ana" para aumentarlo en un 10%.*/
UPDATE empleados
SET salario = salario * 1.1
WHERE nombre = 'Ana';

/*Crea un departamento llamado “Contabilidad”.*/
INSERT INTO departamentos (nombre) VALUES ('Contabilidad');

/*Cambia el departamento del empleado con nombre "Carlos" de "Recursos
Humanos" a "Contabilidad":*/
UPDATE empleados
SET departamento_id = 3
WHERE id = 2;

/*Elimina al empleado con nombre "Laura"*/
DELETE FROM empleados WHERE nombre = 'Laura';

/*PRÁCTICA AVANZADA DML*/

/*Crea una tabla llamada "clientes" con columnas para el "id" (entero
autoincremental), "nombre" (cadena de hasta 50 caracteres), y "direccion"
(cadena de hasta 100 caracteres).*/
CREATE TABLE clientes (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
direccion VARCHAR(100)

/*2. Crea una tabla llamada "productos" con columnas para el "id" (entero
autoincremental), "nombre" (cadena de hasta 50 caracteres), y "precio"
(decimal con 10 dígitos, 2 decimales).*/
CREATE TABLE productos (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
precio DECIMAL(10, 2)
);

/*Crea una tabla llamada "ventas" con columnas para "id" (entero
autoincremental), "producto_id" (entero), "cliente_id" (entero), "cantidad"
(entero), “precio_unitario” (decimal con 10 dígitos, 2 decimales), "monto_total"
(decimal con 10 dígitos, 2 decimales), y "empleado_id" (entero).*/
CREATE TABLE ventas (
id INT AUTO_INCREMENT PRIMARY KEY,
producto_id INT,
cliente_id INT,
cantidad INT,
precio_unitario DECIMAL(10, 2),
monto_total DECIMAL(10, 2),
empleado_id INT
);

/*cambiar el nombre de una columna. Se debe registrar el tipo de datos, cliente*/
ALTER TABLE ventas CHANGE product_id producto_id INT;

/*En la tabla creada Ventas, establece restricciones de clave foránea en las
columnas "producto_id," "cliente_id," y "empleado_id" para hacer referencia a
las tablas correspondientes.*/
ALTER TABLE ventas
ADD FOREIGN KEY (producto_id)
REFERENCES productos(id),
ADD FOREIGN KEY (cliente_id )
REFERENCES clientes(id),
ADD FOREIGN KEY (empleado_id)
REFERENCES empleados(id);

/*Inserta un nuevo cliente en la tabla "clientes" con el nombre "Juan Pérez" y
la dirección "Libertad 3215, Mar del Plata"*/
INSERT INTO clientes (nombre, direccion)
VALUES ('Juan Pérez','Libertad 3215, Mar del Plata,');

/*Inserta un nuevo producto en la tabla "productos" con el nombre "Laptop" y
un precio de 1200.00 .*/
INSERT INTO productos (nombre, precio)
VALUES ('Laptop',1200.00);

/*Modifica la columna monto_total de la tabla ventas para que por defecto sea
el resultado de multiplicar la cantidad por el precio del producto_id
Al modificar se agrega nuevamente el tipo de datos*/
ALTER TABLE ventas
MODIFY monto_total DECIMAL(10, 2) GENERATED ALWAYS AS ( cantidad * /*GENERATED ALWAYS AS: Define que la columna monto_total es generada automáticamente con base en una expresión.*/
precio_unitario) STORED;/*STORED Indica que la columna generada será almacenada físicamente en la tabla.*/

/*Crea una venta en la tabla "ventas" donde el cliente "Juan Pérez" compra
"Laptop" por una cantidad de 2 unidades y el vendedor tenga el nombre “Ana"
y apellido "Rodriguez”. Ten en cuenta que debes “tener” los ID y valores
correspondientes previamente, luego aprenderemos a recuperarlos con
subconsultas.*/
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario,
empleado_id)VALUES (1,1,2,1350.00,1);
