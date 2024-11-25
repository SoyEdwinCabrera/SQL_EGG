/*CONSULTAS MULTITABLA*/

/*Une las tablas de empleados con departamentos y solo muestra las columnas nombre, apellido, edad,
salario de empleados y la columna nombre de departamentos.*/
SELECT e.nombre Nombre, e.apellido Apellido, e.edad Edad, e.salario
Salario, d.nombre Departamento
FROM empleados e, departamentos d
WHERE e.departamento_id = d.id;

/*Une las tablas ventas con la tabla empleados donde se muestren todas
las columnas de ventas exceptuando la columna empleado_id y en su
lugar muestres el nombre y apellido de la tabla empleados.*/
SELECT v.id, v.producto_id, v.cliente_id, v.cantidad, v.precio_unitario,
v.monto_total, CONCAT(e.nombre, " ", e.apellido) "Nombre empleado"
FROM ventas v, empleados e
WHERE v.empleado_id = e.id;

/*Une las tablas ventas con la tabla productos donde se muestren todas
las columnas de ventas exceptuando la columna producto_id y en su
lugar muestres la columna nombre de la tabla productos.*/
SELECT v.id, p.nombre, v.cliente_id, v.cantidad, v.precio_unitario,
v.monto_total, v.empleado_id
FROM ventas v, productos p
WHERE v.producto_id = p.id;

/*Une las tablas ventas con la tabla clientes donde se muestren todas las
columnas de ventas exceptuando la columna cliente_id y en su lugar
muestres la columna nombre de la tabla clientes.*/
SELECT v.id, v.producto_id, c.nombre, v.cantidad, v.precio_unitario,
v.monto_total, v.empleado_id
FROM ventas v, clientes c
WHERE v.cliente_id = c.id;

/*Une las tablas ventas con la tablas empleados y departamentos donde
se muestren todas las columnas de ventas exceptuando la columna
empleado_id y en su lugar muestres el nombre y apellido de la tabla
empleados y además muestres la columna nombre de la tabla departamentos.*/
SELECT v.id, v.producto_id, v.cliente_id, v.cantidad, v.precio_unitario,
v.monto_total, CONCAT(e.nombre, " ", e.apellido) "Nombre empleado",
d.nombre "Nombre departamento"
FROM ventas v, empleados e, departamentos d
WHERE v.empleado_id = e.id AND e.departamento_id = d.id;

/*Une las tablas ventas, empleados, productos y clientes donde se
muestren las columnas de la tabla ventas reemplazando sus columnas
de FOREIGN KEYs con las respectivas columnas de “nombre” de las otras tablas.*/
SELECT v.id, p.nombre "Nombre producto", c.nombre "Nombre cliente",
v.cantidad, v.precio_unitario, v.monto_total, CONCAT(e.nombre, " ",
e.apellido) "Nombre empleado"
FROM ventas v, productos p, clientes c, empleados e
WHERE v.empleado_id = e.id AND v.producto_id = p.id AND v.cliente_id =
c.id;

/*Calcular el salario máximo de los empleados en cada departamento y
mostrar el nombre del departamento junto con el salario máximo.*/
SELECT d.nombre AS "Departamento", MAX(e.salario) AS "Salario Máximo"
FROM empleados e, departamentos d
WHERE e.departamento_id = d.id GROUP BY d.nombre;


/*CONSULTAS MULTITABLAS PARTE 2*/

/*Calcular el monto total de ventas por departamento y mostrar el nombre
del departamento junto con el monto total de ventas.*/
SELECT d.nombre "Nombre del Departamento", SUM(v.monto_total) "Monto Total de Ventas"
FROM empleados e, ventas v, departamentos d
WHERE e.id = v.empleado_id AND e.departamento_id = d.id GROUP BY d.nombre;

/*Encontrar el empleado más joven de cada departamento y mostrar el
nombre del departamento junto con la edad del empleado más joven.*/
SELECT d.nombre, min(e.edad)
FROM empleados e, departamentos d
WHERE e.departamento_id = d.id group by d.nombre;

/*Calcular el volumen de productos vendidos por cada producto (por
ejemplo, menos de 5 “bajo”, menos 8 “medio” y mayor o igual a 8
“alto”) y mostrar la categoría de volumen junto con la cantidad y el nombre del producto.*/
SELECT p.nombre,
CASE
WHEN SUM(v.cantidad) <= 4 THEN 'Bajo'
WHEN SUM(v.cantidad) <= 7 THEN 'Medio'
ELSE 'Alto' END AS "Categoría de volumen", SUM(v.cantidad)
"Cantidad de Productos Vendidos"
FROM ventas v, productos p
WHERE v.producto_id = p.id GROUP BY p.nombre;

/*Encontrar el cliente que ha realizado el mayor monto total de compras y
mostrar su nombre y el monto total.*/
SELECT c.nombre "Nombre del Cliente", MAX(v.monto_total) "Monto Total de
Compras"
FROM clientes c, ventas v
WHERE c.id = v.cliente_id GROUP BY c.nombre;

/*Calcular el precio promedio de los productos vendidos por cada
empleado y mostrar el nombre del empleado junto con el precio
promedio de los productos que ha vendido.*/
SELECT e.nombre "Nombre del Empleado", AVG(p.precio) "Precio Promedio de
Productos Vendidos"
FROM empleados e, ventas v, productos p
WHERE e.id = v.empleado_id AND v.producto_id = p.id
GROUP BY e.nombre;

/*Encontrar el departamento con el salario mínimo más bajo entre los
empleados y mostrar el nombre del departamento junto con el salario mínimo más bajo.*/
SELECT d.nombre "Nombre del Departamento", MIN(e.salario) "Salario Mínimo"
FROM departamentos d, empleados e
WHERE d.id = e.departamento_id
GROUP BY d.nombre;

/*Encuentra el departamento con el salario promedio más alto entre los
empleados mayores de 30 años y muestra el nombre del departamento
junto con el salario promedio. Limita los resultados a mostrar solo los
departamentos con el salario promedio mayor a 3320.*/
SELECT d.nombre "Nombre departamento", AVG(e.salario) "Salario promedio"
FROM empleados e, departamentos d
WHERE e.departamento_id = d.id AND e.edad > 30
GROUP BY d.nombre HAVING AVG(e.salario) > 3320;
