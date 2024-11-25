/* CLAUSULA IN*/

/*Encuentra los empleados cuyos IDs son 1, 3 o 5.*/
SELECT * FROM empleados WHERE id IN (1, 3, 5);

/*Busca los productos con IDs 2, 4 o 6 en la tabla de productos.*/
SELECT * FROM productos WHERE id IN (2, 4, 6);

/*Encuentra las ventas que tienen los clientes con IDs 1, 3 o 5.*/
SELECT * FROM ventas WHERE cliente_id IN (1, 3, 5);

/*CLAUSULA LIKE*/

/*Encuentra los empleados cuyos nombres comienzan con "L".*/
SELECT * FROM empleados WHERE nombre LIKE 'L%';

/*Busca los productos cuyos nombres contengan la palabra "Teléfono".*/
SELECT * FROM productos WHERE nombre LIKE '%Teléfono%';

/*Encuentra los clientes cuyas direcciones contienen la palabra "Calle".*/
SELECT * FROM clientes WHERE direccion LIKE '%Calle%';

/*CLAUSULA ORDER BY*/

/*Ordena los empleados por salario de manera ascendente.*/
SELECT * FROM empleados ORDER BY salario ASC;

/*Ordena los productos por nombre de manera descendente.*/
SELECT * FROM productos ORDER BY nombre DESC;

/*Ordena las ventas por cantidad de manera ascendente y luego por
precio_unitario de manera descendente*/
SELECT * FROM ventas ORDER BY cantidad ASC, precio_unitario DESC;

/*FUNCION MAX()*/

/*Encuentra el salario máximo de todos los empleados.*/
SELECT MAX(salario) FROM empleados;

/*Encuentra la cantidad máxima de productos vendidos en una sola venta.*/
SELECT MAX(cantidad) FROM ventas;

/*Encuentra la edad máxima de los empleados.*/
SELECT MAX(edad) FROM empleados;

/*FUNCION MIN()*/

/*Encuentra el salario mínimo de todos los empleados.*/
SELECT MIN(salario) FROM empleados;

/*Encuentra la cantidad mínima de productos vendidos en una sola venta.*/
SELECT MIN(cantidad) FROM ventas;

/*Encuentra la edad mínima de los empleados.*/
SELECT MIN(edad) FROM empleados;

/*FUNCION COUNT()*/

/*Cuenta cuántos empleados hay en total.*/
SELECT COUNT(*) FROM empleados;

/*Cuenta cuántas ventas se han realizado.*/
SELECT COUNT(*) FROM ventas;

/*Cuenta cuántos productos tienen un precio superior a $500.*/
SELECT COUNT(*) FROM productos WHERE precio > 500.00;

/* FUNCION SUM()*/

/*Calcula la suma total de salarios de todos los empleados.*/
SELECT SUM(salario) FROM empleados;

/*Calcula la suma total de montos vendidos en todas las ventas.*/
SELECT SUM(monto_total) FROM ventas;

/*Calcula la suma de precios de productos con ID par.*/
SELECT SUM(precio) FROM productos WHERE id % 2 = 0;


/*FUNCION AVG()*/

/*Calcula el salario promedio de todos los empleados.*/
SELECT AVG(salario) FROM empleados;

/*Calcula el precio unitario promedio de todos los productos.*/
SELECT AVG(precio) FROM productos;

/*Calcula la edad promedio de los empleados.*/
SELECT AVG(edad) FROM empleados;


/*GROUP BY()*/

/*Agrupa las ventas por empleado y muestra la cantidad total de ventas realizadas por cada empleado.*/
SELECT empleado_id, COUNT(*) FROM ventas GROUP BY empleado_id;

/*Agrupa los productos por precio y muestra la cantidad de productos con el mismo precio.*/
SELECT precio, COUNT(*) FROM productos GROUP BY precio;

/*Agrupa los empleados por departamento y muestra la cantidad de empleados en cada departamento.*/
SELECT departamento_id, COUNT(*) FROM empleados GROUP BY departamento_id;


/*HAVING*/

/*Encuentra los departamentos con un salario promedio de sus empleados superior a $3,000.*/
SELECT departamento_id, AVG(salario) FROM empleados GROUP BY
departamento_id HAVING salario_promedio > 3000;

SELECT departamento_id, AVG(salario) AS salario_promedio
FROM empleados
GROUP BY departamento_id
HAVING AVG(salario) > 3000;


/*Encuentra los productos que se han vendido al menos 5 veces.*/
SELECT producto_id, COUNT(*) FROM ventas GROUP BY producto_id HAVING COUNT(*) >= 5;

/*Selecciona los empleados que tengan una “o” en su nombre o apellido
y agrúpalos por departamento y muestra los que tengan el salario máximo.*/
SELECT departamento_id, MAX(salario) FROM empleados WHERE nombre
LIKE"%o%" OR apellido LIKE "%o%" GROUP BY departamento_id HAVING MAX(salario)
= MAX(salario);


/*CLAUSULA AS*/

/*Crea una consulta que muestre el salario de los empleados junto con el
salario aumentado en un 10% nombrando a la columna como “Aumento del 10%”.*/
SELECT salario, salario * 1.1 AS "Aumento del 10%" FROM empleados;

/*Crea una consulta que calcule el monto total de las compras realizadas
por cliente y que la columna se llame “Monto total gastado”.*/
SELECT cliente_id, SUM(monto_total) AS "Monto total gastado" FROM ventas
GROUP BY cliente_id;

/*Muestra los nombres completos de los empleados concatenando los
campos "nombre" y "apellido" y que la columna se llame “Nombre y
apellido”.*/
SELECT CONCAT(nombre, ' ', apellido) AS "Nombre y apellido" FROM empleados;


/*CLAUSULA LIMIT*/

/*Muestra los 5 productos más caros de la tabla "productos".*/
SELECT * FROM productos ORDER BY precio DESC LIMIT 5;

/*Muestra los 10 primeros empleados en orden alfabético por apellido.*/
SELECT * FROM empleados ORDER BY apellido ASC LIMIT 10;

/*Muestra las 3 ventas con el monto total más alto.*/
SELECT * FROM ventas ORDER BY monto_total DESC LIMIT 3;


/*CLAUSUAL CASE*/

/*Crea una consulta que muestre el nombre de los productos y los
categorice como "Caro" si el precio es mayor o igual a $500, "Medio" si
es mayor o igual a $200 y menor que $500, y "Barato" en otros casos.*/
SELECT nombre AS Nombre_Producto,
CASE
WHEN precio >= 500 THEN 'Caro'
WHEN precio >= 200 AND precio < 500 THEN 'Medio'
ELSE 'Barato'
END AS Categoria
FROM productos;

/*Crea una consulta que muestre el nombre de los empleados y los
categorice como "Joven" si tienen menos de 30 años, "Adulto" si tienen
entre 30 y 40 años, y "Mayor" si tienen más de 40 años.*/

SELECT CONCAT(nombre, ' ', apellido) AS Nombre_Completo,
CASE
WHEN edad < 30 THEN 'Joven'
WHEN edad BETWEEN 30 AND 40 THEN 'Adulto'
ELSE 'Mayor'
END AS Categoria
FROM empleados;

/*Crea una consulta que muestre el ID de la venta y los categorice como
"Poca cantidad" si la cantidad es menor que 3, "Cantidad moderada" si
es igual o mayor que 3 y menor que 6, y "Mucha cantidad" en otros casos.*/
SELECT id AS ID_Venta,
CASE
WHEN cantidad < 3 THEN 'Poca cantidad'
WHEN cantidad >= 3 AND cantidad < 6 THEN 'Cantidad moderada'
ELSE 'Mucha cantidad'
END AS Categoria
FROM ventas;

/*Crea una consulta que muestre el nombre de los clientes y los
categorice como "Comienza con A" si su nombre comienza con la letra
'A', "Comienza con M" si comienza con 'M' y "Otros" en otros casos.*/
SELECT nombre AS Nombre_Cliente,
CASE
WHEN nombre LIKE 'A%' THEN 'Comienza con A'
WHEN nombre LIKE 'M%' THEN 'Comienza con M'
ELSE 'Otros'
END AS Categoria
FROM clientes;

/*Crea una consulta que muestre el nombre de los empleados y los
categorice como "Salario alto" si el salario es mayor o igual a $3500,
"Salario medio" si es mayor o igual a $3000 y menor que $3500, y
"Salario bajo" en otros casos.*/
SELECT CONCAT(nombre, ' ', apellido) AS Nombre_Completo,
CASE
WHEN salario >= 3500 THEN 'Salario alto'
WHEN salario >= 3000 AND salario < 3500 THEN 'Salario medio'
ELSE 'Salario bajo'
END AS Categoria
FROM empleados;
