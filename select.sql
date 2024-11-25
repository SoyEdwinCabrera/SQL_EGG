/*Inserta un nuevo producto en la tabla "productos" con el nombre
"Teléfono móvil" y un precio de 450.00.*/
INSERT INTO productos (nombre, precio)
VALUES ('Teléfono móvil',450.00);

/*Inserta un nuevo cliente en la tabla "clientes" con el nombre "María
García" y la dirección "Constitución 456, Luján".*/
INSERT INTO clientes (nombre, direccion)
VALUES ('María García','Constitución 456, Luján');

/*Modifica la columna correo_electronico de la tabla empleados para que
se genere automáticamente concatenado el nombre, apellido y el string
“@mail.com”.*/
ALTER TABLE empleados
MODIFY correo_electronico VARCHAR(50)
GENERATED ALWAYS AS ( CONCAT(nombre,apellido,'@mail.com')) STORED;

/*Inserta un nuevo empleado en la tabla "empleados" con el nombre
"Luis” y apellido “Fernández", edad 28, salario 2800.00 y que pertenezca
al departamento “ventas”.*/
INSERT INTO empleados
(nombre,apellido,edad,salario,departamento_id)
VALUES ('Luis','Fernández',28,2800.00,1);

/*Actualiza el precio del producto "Laptop" a 1350.00 en la tabla
"productos".*/
UPDATE productos SET precio = 1350.00
WHERE nombre = 'Laptop';

/*Modifica la dirección del cliente "Juan Pérez" a "Alberti 1789, Mar del
Plata" en la tabla "clientes".*/
UPDATE clientes SET direccion = "Alberti 1789, Mar del Plata"
WHERE nombre = 'Juan Pérez';

/*Incrementa el salario de todos los empleados en un 5% en la tabla
"empleados".*/
UPDATE empleados
SET salario = salario * 1.05;

/*Inserta un nuevo producto en la tabla "productos" con el nombre
"Tablet" y un precio de 350.00.*/
INSERT INTO productos (nombre, precio)
VALUES ('Tablet',350.00);

/*Inserta un nuevo cliente en la tabla "clientes" con el nombre "Ana
López" y la dirección "Beltrán 1452, Godoy Cruz".*/
INSERT INTO clientes (nombre, direccion)
VALUES ('Ana López','Beltrán 1452, Godoy Cruz');

/*Inserta un nuevo empleado en la tabla "empleados" con el nombre
"Marta", apellido "Ramírez", edad 32, salario 3100.00 y que pertenezca al
departamento “ventas”.*/
INSERT INTO empleados
(nombre,apellido,edad,salario,departamento_id)
VALUES
('Marta','Ramírez',32,3100.00,1);

/*Actualiza el precio del producto "Teléfono móvil" a 480.00 en la tabla
"productos".*/
UPDATE productos SET precio = 480.00
WHERE nombre = 'Teléfono móvil';

/*Modifica la dirección del cliente "María García" a "Avenida 789, Ciudad
del Este" en la tabla "clientes".*/
UPDATE clientes SET direccion = "Avenida 789, Ciudad del Este"
WHERE nombre = 'María García';

/*Incrementa el salario de todos los empleados en el departamento de
"Ventas" en un 7% en la tabla "empleados".*/
UPDATE empleados
SET salario = salario * 1.07
WHERE departamento_id = 1;

/*Inserta un nuevo producto en la tabla "productos" con el nombre
"Impresora" y un precio de 280.00.*/
INSERT INTO productos (nombre, precio)
VALUES ('Impresora',280.00);

/*Inserta un nuevo cliente en la tabla "clientes" con el nombre "Carlos
Sánchez" y la dirección "Saavedra 206, Las Heras".*/
INSERT INTO clientes (nombre, direccion)
VALUES ('Carlos Sánchez','Saavedra 206, Las Heras');

/*Inserta un nuevo empleado en la tabla "empleados" con el nombre
"Lorena", apellido "Guzmán", edad 26, salario 2600.00 y que pertenezca
al departamento “ventas”.*/
INSERT INTO empleados
(nombre,apellido,edad,salario,departamento_id)
VALUES
('Lorena','Guzmán',26,2600.00,1);


/* CLAUSULA DISTINCT */

/*Insertar varios registros en una sentencia*/
INSERT INTO ventas(producto_id, cliente_id,cantidad,precio_unitario,empleado_id)
VALUES(2,2,3,480.00,2),(4,4,1,280.00,6),(1,3,1,1350.00,2),(3,1,2,350.00,5),(2,2,1,480.00,6),(4,4,2,280.00,7);

/*Lista los nombres de los empleados sin duplicados*/
SELECT DISTINCT nombre FROM empleados;

/*Obtén una lista de correos electrónicos únicos de todos los empleados.*/
SELECT DISTINCT correo_electronico FROM empleados;

/*Encuentra la lista de edades distintas entre los empleados.*/
SELECT DISTINCT edad FROM empleados;

/*Muestra los nombres de los empleados que tienen un salario superior a $3200.*/
SELECT nombre FROM empleados WHERE salario > 3200.00;

/*Obtén una lista de empleados que tienen 28 años de edad.*/
SELECT nombre FROM empleados WHERE edad = 28;

/*Lista a los empleados cuyos salarios sean menores a $2700.*/
SELECT nombre FROM empleados WHERE salario < 2700.00;

/*Encuentra todas las ventas donde la cantidad de productos vendidos sea mayor que 2.*/
SELECT * FROM ventas WHERE cantidad > 2;

/*Muestra las ventas donde el precio unitario sea igual a $480.00.*/
SELECT * FROM ventas WHERE precio_unitario = 480.00;

/*Obtén una lista de ventas donde el monto total sea menor que $1000.00.*/
SELECT * FROM ventas WHERE monto_total < 1000.00;

/*Encuentra las ventas realizadas por el empleado con el ID 1.*/
SELECT * FROM ventas WHERE empleado_id = 1;

/* OPERADORES LÓGICOS*/

/*Muestra los nombres de los empleados que trabajan en el Departamento 1 y tienen un salario superior a $3000.*/
SELECT nombre FROM empleados WHERE departamento_id = 1 AND salario >3000.00;

/*12.Lista los empleados que tienen 32 años de edad o trabajan en el Departamento 3.*/
SELECT nombre FROM empleados WHERE edad = 32 OR departamento_id = 3;

/*13.Lista las ventas donde el producto sea el ID 1 y la cantidad sea mayor o igual a 2.*/
SELECT * FROM ventas WHERE producto_id = 1 AND cantidad >= 2;

/*14.Muestra las ventas donde el cliente sea el ID 1 o el empleado sea el ID 2.*/
SELECT * FROM ventas WHERE cliente_id = 1 OR empleado_id = 2;

/*15.Obtén una lista de ventas donde el cliente sea el ID 2 y la cantidad sea mayor que 2.*/
SELECT * FROM ventas WHERE cliente_id = 2 AND cantidad > 2;

/*16.Encuentra las ventas realizadas por el empleado con el ID 1 y donde el
monto total sea mayor que $2000.00.*/
SELECT * FROM ventas WHERE empleado_id = 1 AND monto_total > 2000.00;

/* CLAUSULA BETWEEN*/

/* 17.Encuentra a los empleados cuyas edades están entre 29 y 33 años.
Muestra el nombre y la edad de los registros que cumplan esa
condición.*/
SELECT nombre, edad FROM empleados WHERE edad BETWEEN 29 AND 33;

/*18.Encuentra las ventas donde la cantidad de productos vendidos esté entre 2 y 3.*/
SELECT * FROM ventas WHERE cantidad BETWEEN 2 AND 3;

/*19.Muestra las ventas donde el precio unitario esté entre $300.00 y $500.00.*/
SELECT * FROM ventas WHERE precio_unitario BETWEEN 300.00 AND 500.00;
