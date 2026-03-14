ALTER SESSION SET CURRENT_SCHEMA = PARRANDEROS;  

/* 1. Los nombres y grados de alcohol de todas las bebidas que tengan más de 9 grados de alcohol y cuyo
nombre no contenga la palabra ‘bebida’. */
SELECT NOMBRE, GRADO_ALCOHOL
FROM PARRANDEROS.BEBIDAS
WHERE GRADO_ALCOHOL > 9 AND NOT (NOMBRE LIKE '%bebida%');

-- 2. Las ciudades que tienen 6 o más bares y entre 30 y 50 sedes
SELECT CIUDAD
FROM BARES
GROUP BY CIUDAD
HAVING SUM(CANT_SEDES) > 30 AND SUM(CANT_SEDES) < 50 AND COUNT(*) >= 6;

/* 3. Los nombres e ids de los 10 bares con mayor oferta de bebidas, incluyendo el número de diferentes
bebidas servidas en cada bar*/
SELECT NOMBRE, ID
FROM BARES 
INNER JOIN BARES.SIRVEN ON (BARES.ID)
FETCH FIRST 10 ROWS ONLY;

/* 4. El id, nombre de todos los bebedores a los que les gustan más de 3 bebidas diferentes, junto con la
cantidad de bebidas que cada uno prefiere. Los resultados deben estar ordenados de mayor a menor,
y solo reportar los primeros 20 resultados.*/

/*5. El nombre de los Bares que sirven al menos una bebida de tipo jugo, agua, gaseosa o
aromática en horarios diurnos, ordenados por el nombre del bar y sin repetir. Reporte las primeras 15
filas.*/

/* 6. Para cada bebida que tenga entre 4 y 8 grados de alcohol y cuyo nombre no comience con
‘bebida’, mostrar el nombre y el número de bebedores que las prefieren.*/

/*7. Para las ciudades de Cali, Bogotá y Medellín, obtener el nombre y el ID de todos los bares que sirven
bebidas en horario nocturno, mostrando los resultados ordenados por ciudad y nombre del bar.*/

/*8. El nombre de los bares que sirven bebidas de más de 9 grados de alcohol y que hayan sido visitados
por al menos un bebedor, ordenados por el nombre del bar. Reporte las primeras 20 filas*/

/* 9. El nombre de las bebidas que les gustan a los bebedores que no hayan visitado ningún bar y cuyo
nombre no contenga la palabra ‘bebida’. Reporte las primeras 10 filas.*/

/* 10. Los clientes mixtos distintos a los que les gusta la bebida de tipo vino tinto. Un cliente mixto es aquel
que visita bares de todos los presupuestos. Se debe mostrar el nombre del cliente y su ID. Los
resultados deben organizarse de acuerdo con el nombre del bebedor. Reporte las primeras 20 filas.*/

/*11. El id, nombre y número de visitas de los bebedores que están entre el top 3 de clientes que más han
visitado bares y a los que sólo les gustan las bebidas de más de 9 grados de alcohol.*/





