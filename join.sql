/*--------------PRIMERA HOJA---------------------*/


/*1. Encuentra el nombre y apellido de los empleados junto con la cantidad total
de ventas que han realizado.*/

/*SIN JOIN*/
SELECT e.nombre, e.apellido, SUM(v.cantidad) as "Total Ventas"
FROM empleados e, ventas v
WHERE e.id = v.empleado_id
GROUP BY e.nombre, e.apellido;

/*CON JOIN*/
SELECT e.nombre, e.apellido, SUM(v.cantidad) as "Total de Ventas"
FROM empleados e
INNER JOIN ventas v
ON e.id = v.empleado_id
GROUP BY e.nombre, e.apellido;

/*2. Calcula el monto total vendido a cada cliente y muestra el nombre del cliente,
su dirección y el monto total.*/

/*SIN JOIN*/
SELECT c.nombre, c.direccion,
  (SELECT SUM(v.monto_total)
   FROM ventas v
   WHERE v.cliente_id = c.id) AS "Monto Total"
FROM clientes c;
/*Se usa una subconsulta correlacionada para calcular el total de ventas (SUM(v.monto_total)) por cada cliente.
La subconsulta filtra las ventas (ventas) relacionadas con el cliente actual (c.id).
La tabla clientes se recorre completamente y para cada cliente, la subconsulta devuelve el monto total.*/

/*CON JOIN*/
SELECT c.nombre, c.direccion , SUM(v.monto_total) as "Monto Total"
FROM clientes c
LEFT JOIN ventas v
ON c.id = v.cliente_id
GROUP BY c.nombre, c.direccion;
/*Propósito: Muestra el nombre y la dirección de cada cliente junto con el monto total de sus compras.
Claves:
LEFT JOIN: Incluye todos los clientes, incluso aquellos que no tienen ventas asociadas.
SUM(v.monto_total): Suma el monto total de las compras realizadas por cada cliente.
GROUP BY c.nombre, c.direccion: Agrupa los resultados por cliente para calcular el monto total.*/


/*--------------EJERCICIO 3  ---------------------*/

/*3. Encuentra los productos vendidos por cada empleado en el departamento de
"Ventas" y muestra el nombre del empleado junto con el nombre de los
productos que han vendido.*/

/*SIN JOIN*/
SELECT CONCAT(e.nombre, " ", e.apellido) AS "Empleado",
 (SELECT GROUP_CONCAT(p.nombre)
 FROM ventas v, productos p
 WHERE v.empleado_id = e.id
 AND v.producto_id = p.id) AS "Productos"
FROM empleados e
WHERE e.departamento_id = (SELECT id FROM departamentos WHERE nombre = "Ventas");
/* La subconsulta en el SELECT utiliza las tablas ventas y productos para encontrar
los productos vendidos por cada empleado (v.empleado_id = e.id).
La cláusula WHERE filtra los empleados que pertenecen al departamento "Ventas".
GROUP_CONCAT combina los nombres de los productos vendidos por cada empleado.*/

/*CON JOIN*/
SELECT CONCAT(e.nombre, " ", e.apellido) "Empleado", p.nombre producto
FROM empleados e
INNER JOIN ventas v
ON e.id = v.empleado_id
INNER JOIN productos p
ON v.producto_id = p.id
INNER JOIN departamentos d
ON e.departamento_id = d.id WHERE d.nombre = "Ventas";
/*Propósito: Lista los empleados del departamento de "Ventas" y los productos que han vendido.
Claves:
INNER JOIN: Asegura que solo se incluyan registros relacionados entre las tablas.
WHERE d.nombre = "Ventas": Filtra empleados solo del departamento "Ventas".
Relaciones:
empleados → ventas → productos → departamentos.
*/


/*--------------EJERCICIO 4  ---------------------*/

/*4. Encuentra el nombre del cliente, el nombre del producto y la cantidad
comprada de productos con un precio superior a $500.*/

/*SIN JOIN*/
SELECT c.nombre AS Cliente,
       (SELECT p.nombre
        FROM productos p, ventas v
        WHERE v.cliente_id = c.id
          AND v.producto_id = p.id
          AND p.precio > 500
        LIMIT 1) AS Producto,
       (SELECT SUM(v.cantidad)
        FROM ventas v, productos p
        WHERE v.cliente_id = c.id
          AND v.producto_id = p.id
          AND p.precio > 500) AS "Cantidad"
FROM clientes c;
/* Se utilizan dos subconsultas correlacionadas:
Una para obtener el nombre de un producto con precio superior a $500.
Otra para calcular la cantidad total de productos vendidos al cliente con ese criterio.
La tabla clientes es la base, y las subconsultas filtran los productos y ventas relacionadas.*/

/*CON JOIN*/
SELECT c.nombre Cliente, p.nombre Producto, SUM(v.cantidad) "Cantidad"
FROM clientes c
INNER JOIN ventas v
ON c.id = v.cliente_id
INNER JOIN productos p
ON v.producto_id = p.id WHERE p.precio > 500
GROUP BY p.nombre, c.nombre;
/*Propósito: Muestra el nombre del cliente, el producto comprado y la cantidad de productos con precio superior a $500.
Claves:
WHERE p.precio > 500: Filtra solo productos con precio mayor a $500.
GROUP BY p.nombre, c.nombre: Agrupa por producto y cliente para calcular la cantidad total comprada.*/


/*------------SEGUNDA HOJA--------------------*/

/*--------------EJERCICIO 1  ---------------------*/

/*1.Calcula la cantidad de ventas por departamento, incluso si el departamento
no tiene ventas.*/

/*SIN JOIN*/
SELECT d.nombre AS Departamento,
       (SELECT COUNT(v.id)
        FROM empleados e, ventas v
        WHERE e.departamento_id = d.id
          AND v.empleado_id = e.id) AS "Cantidad de Ventas"
FROM departamentos d;
/*La subconsulta correlacionada cuenta las ventas (COUNT(v.id)) para cada departamento.
Si un departamento no tiene ventas, la subconsulta devuelve NULL o 0, dependiendo del manejo de la base de datos.*/

/*CON JOIN*/
SELECT d.nombre Departamento, COUNT(v.id) as "Cantidad de Ventas"
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id
LEFT JOIN ventas v
ON e.id = v.empleado_id
GROUP BY d.nombre;
/*Propósito: Muestra la cantidad de ventas realizadas por departamento, incluyendo departamentos sin ventas.
Claves:
LEFT JOIN: Incluye todos los departamentos, incluso si no hay empleados o ventas asociadas.
COUNT(v.id): Cuenta el número de ventas realizadas por cada departamento.*/

/*--------------EJERCICIO 2  ---------------------*/

/*2. Encuentra el nombre y la dirección de los clientes que han comprado más de
3 productos y muestra la cantidad de productos comprados.*/

/*SIN JOIN*/
SELECT c.nombre AS Cliente, c.direccion AS Direccion,
       (SELECT COUNT(DISTINCT v.producto_id)
        FROM ventas v
        WHERE v.cliente_id = c.id) AS "Cantidad de Productos Comprados"
FROM clientes c
HAVING "Cantidad de Productos Comprados" > 3;
/* Una subconsulta cuenta la cantidad de productos únicos (COUNT(DISTINCT v.producto_id)) comprados por cada cliente.
   La cláusula HAVING filtra los clientes con más de 3 productos.*/

/*CON JOIN*/
SELECT c.nombre AS Cliente, c.direccion AS Direccion, COUNT(DISTINCT
v.producto_id) AS "Cantidad de Productos Comprados"
FROM clientes c
LEFT JOIN ventas v
ON c.id = v.cliente_id
GROUP BY c.nombre, c.direccion
HAVING COUNT(DISTINCT v.producto_id) > 3;
/*Propósito: Encuentra clientes que han comprado más de 3 productos diferentes, mostrando su nombre, dirección y cantidad de productos.
Claves:
HAVING COUNT(DISTINCT v.producto_id) > 3: Filtra clientes que han comprado más de 3 productos distintos.*/

/*--------------EJERCICIO 3  ---------------------*/

/*3. Calcula el monto total de ventas realizadas por cada departamento y muestra
el nombre del departamento junto con el monto total de ventas.*/

/*SIN JOIN*/
SELECT d.nombre AS Departamento,(SELECT SUM(v.monto_total)
FROM empleados e, ventas v
WHERE e.departamento_id = d.id
AND v.empleado_id = e.id) AS "Monto Total de Ventas"
FROM departamentos d;
/*Una subconsulta calcula el monto total (SUM(v.monto_total)) de ventas realizadas por cada departamento.
La tabla departamentos se recorre completamente, y para cada uno, la subconsulta filtra y suma las ventas relacionadas.*/


/*CON JOIN*/
SELECT d.nombre Departamento, SUM(v.monto_total) "Monto Total de Ventas"
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id
LEFT JOIN ventas v
ON e.id = v.empleado_id
GROUP BY d.nombre;
/*Propósito: Muestra el nombre del departamento junto con el monto total de ventas realizadas.
Claves:
SUM(v.monto_total): Suma el monto total de las ventas asociadas a los empleados de cada departamento.
LEFT JOIN: Asegura que todos los departamentos aparezcan en el resultado, incluso si no tienen ventas.*/





/*-----------COMPLEMENTARIO-----------------*/

/*--------------------------EJERCICIO 1----------------------------------------*/

/*1. Muestra el nombre y apellido de los empleados
que pertenecen al departamento de "Recursos Humanos" y han realizado más de 5 ventas.*/
/*SIN JOIN*/
SELECT e.nombre, e.apellido
FROM empleados e
WHERE e.departamento_id = (SELECT id
                           FROM departamentos
                           WHERE nombre = "Recursos Humanos")
  AND (SELECT COUNT(*)
       FROM ventas v
       WHERE v.empleado_id = e.id) > 5;
/*La subconsulta (SELECT id FROM departamentos WHERE nombre = "Recursos Humanos") encuentra el ID del departamento "Recursos Humanos".
Se filtran los empleados que pertenecen a ese departamento mediante e.departamento_id.
Otra subconsulta (SELECT COUNT(*) FROM ventas v WHERE v.empleado_id = e.id) cuenta las ventas realizadas por cada empleado.
Se aplica la condición > 5 para filtrar los empleados con más de 5 ventas.*/

/*CON JOIN*/
SELECT e.nombre, e.apellido
FROM empleados e
INNER JOIN departamentos d ON e.departamento_id = d.id
INNER JOIN ventas v ON e.id = v.empleado_id
WHERE d.nombre = "Recursos Humanos"
GROUP BY e.id, e.nombre, e.apellido
HAVING COUNT(v.id) > 5;
/* INNER JOIN relaciona la tabla empleados con departamentos mediante e.departamento_id = d.id.
INNER JOIN adicional relaciona empleados con ventas mediante e.id = v.empleado_id.
Se filtran solo los departamentos con el nombre "Recursos Humanos".
GROUP BY agrupa las ventas por empleado, y HAVING COUNT(v.id) > 5 filtra empleados con más de 5 ventas.*/

/*--------------------------EJERCICIO 2----------------------------------------*/

/*2. Muestra el nombre y apellido de todos los empleados junto con la cantidad
total de ventas que han realizado, incluso si no han realizado ventas.*/
/*SIN JOIN*/
SELECT e.nombre, e.apellido,
       (SELECT SUM(v.cantidad)
        FROM ventas v
        WHERE v.empleado_id = e.id) AS "Total # de Ventas"
FROM empleados e;
/*Se seleccionan el nombre y apellido de cada empleado desde la tabla empleados.
Una subconsulta (SELECT SUM(v.cantidad) FROM ventas v WHERE v.empleado_id = e.id) calcula la cantidad total de ventas por empleado.
Si un empleado no tiene ventas, la subconsulta devuelve NULL.*/

/*CON JOIN*/
SELECT e.nombre, e.apellido, IFNULL(SUM(v.cantidad), 0) AS "Total # de Ventas"
FROM empleados e
LEFT JOIN ventas v ON e.id = v.empleado_id
GROUP BY e.id, e.nombre, e.apellido;
/*LEFT JOIN asegura que todos los empleados se incluyan, incluso si no tienen ventas relacionadas.
SUM(v.cantidad) suma las ventas por empleado, y IFNULL reemplaza los valores nulos con 0 para empleados sin ventas.
GROUP BY agrupa los resultados por empleado.*/

/*--------------------------EJERCICIO 3----------------------------------------*/

/*3. Encuentra el empleado más joven de cada departamento y muestra el
nombre del departamento junto con el nombre y la edad del empleado más joven.*/
/*SIN JOIN*/
SELECT d.nombre AS Departamento,
       (SELECT CONCAT(e.nombre, " ", e.apellido)
        FROM empleados e
        WHERE e.departamento_id = d.id
        ORDER BY e.edad ASC
        LIMIT 1) AS "Empleado Más Joven",
       (SELECT MIN(e.edad)
        FROM empleados e
        WHERE e.departamento_id = d.id) AS "Edad"
FROM departamentos d;
/*La tabla departamentos se recorre para obtener los nombres de los departamentos.
Una subconsulta encuentra el empleado más joven en cada departamento mediante ORDER BY e.edad ASC LIMIT 1.
Otra subconsulta (SELECT MIN(e.edad) FROM empleados e WHERE e.departamento_id = d.id) calcula directamente la edad mínima.
Ambas subconsultas están relacionadas con cada departamento por d.id.*/

/*CON JOIN*/
SELECT d.nombre AS Departamento, CONCAT(e.nombre, " ", e.apellido) AS "Empleado Más Joven", e.edad
FROM departamentos d
INNER JOIN empleados e ON d.id = e.departamento_id
WHERE e.edad = (SELECT MIN(e2.edad) FROM empleados e2 WHERE e2.departamento_id = d.id);
/*INNER JOIN relaciona departamentos con empleados mediante d.id = e.departamento_id.
El filtro en WHERE selecciona solo a los empleados con la menor edad por departamento, utilizando una subconsulta para encontrar MIN(e2.edad).*/



/*--------------------------EJERCICIO 4----------------------------------------*/

/*4. Calcula el volumen de productos vendidos por cada producto
(por ejemplo, menos de 5 como "bajo", entre 5 y 10 como "medio", y más de 10 como "alto")
y muestra la categoría de volumen junto con la cantidad y el nombre del producto.*/

/*SIN JOIN*/
(SELECT SUM(v.cantidad)
 FROM ventas v
 WHERE v.producto_id = p.id) AS "Cantidad Vendida",
CASE
    WHEN (SELECT SUM(v.cantidad)
          FROM ventas v
          WHERE v.producto_id = p.id) < 5 THEN "Bajo"
    WHEN (SELECT SUM(v.cantidad)
          FROM ventas v
          WHERE v.producto_id = p.id) BETWEEN 5 AND 10 THEN "Medio"
    ELSE "Alto"
END AS "Categoría de Volumen"
FROM productos p;
/*La tabla productos se recorre para obtener los nombres de los productos.
Una subconsulta (SELECT SUM(v.cantidad) FROM ventas v WHERE v.producto_id = p.id) calcula el total de productos vendidos.
La categoría de volumen se determina usando una cláusula CASE:*/

/*CON JOIN*/
SELECT p.nombre AS Producto, SUM(v.cantidad) AS "Cantidad Vendida",
 CASE
  WHEN SUM(v.cantidad) < 5 THEN "Bajo"
  WHEN SUM(v.cantidad) BETWEEN 5 AND 10 THEN "Medio"
  ELSE "Alto"
END AS "Categoría de Volumen"
FROM productos p
LEFT JOIN ventas v ON p.id = v.producto_id
GROUP BY p.id, p.nombre;

/* LEFT JOIN relaciona productos con ventas mediante p.id = v.producto_id, asegurando que todos los productos se incluyan, incluso si no tienen ventas.
SUM(v.cantidad) calcula la cantidad total vendida por producto.
La cláusula CASE categoriza el volumen de ventas en "Bajo", "Medio", o "Alto".
GROUP BY agrupa las ventas por producto.*/
