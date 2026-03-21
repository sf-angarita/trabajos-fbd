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
SELECT ID2, NOMBRE2, COUNT (S.ID_BEBIDA) AS TOTAL_BEBIDAS
FROM PARRANDEROS.BARES 
INNER JOIN PARRANDEROS.SIRVEN S ON BARES.ID2 = S.ID_BAR
GROUP BY BARES.NOMBRE2, BARES.ID2
ORDER BY TOTAL_BEBIDAS DESC
FETCH FIRST 10 ROWS ONLY;

/* 4. El id, nombre de todos los bebedores a los que les gustan más de 3 bebidas diferentes, junto con la
cantidad de bebidas que cada uno prefiere. Los resultados deben estar ordenados de mayor a menor,
y solo reportar los primeros 20 resultados.*/
SELECT ID, NOMBRE, COUNT(G.ID_BEBIDA) AS CANTIDAD_PREFERIDAS
FROM PARRANDEROS.BEBEDORES
INNER JOIN PARRANDEROS.GUSTAN G ON BEBEDORES.ID = G.ID_BEBEDOR
GROUP BY BEBEDORES.ID, BEBEDORES.NOMBRE
HAVING COUNT(G.ID_BEBIDA) >3
ORDER BY CANTIDAD_PREFERIDAS DESC
FETCH FIRST 20 ROWS ONLY;

/*5. El nombre de los Bares que sirven al menos una bebida de tipo jugo, agua, gaseosa o
aromática en horarios diurnos, ordenados por el nombre del bar y sin repetir. Reporte las primeras 15
filas.*/
SELECT B.NOMBRE2
FROM PARRANDEROS.BARES B
WHERE B.ID2 IN (
    SELECT  S.ID_BAR
    FROM PARRANDEROS.SIRVEN S
    INNER JOIN PARRANDEROS.BEBIDAS BE ON S.ID_BEBIDA=BE.ID
    WHERE HORARIO='diurno' AND BE.TIPO IN (
        SELECT TIP.ID
        FROM PARRANDEROS.TIPOS_BEBIDA TIP
        WHERE NOMBRE='jugo' OR NOMBRE='agua' OR NOMBRE='gaseosa' OR NOMBRE='aromatica'
    )
)
ORDER BY B.NOMBRE2
FETCH FIRST 15 ROWS ONLY;

/* 6. Para cada bebida que tenga entre 4 y 8 grados de alcohol y cuyo nombre no comience con
‘bebida’, mostrar el nombre y el número de bebedores que las prefieren.*/
SELECT B.NOMBRE, COUNT(G.ID_BEBEDOR) AS NUM_BEBEDORES
FROM PARRANDEROS.BEBIDAS B
INNER JOIN PARRANDEROS.GUSTAN G ON B.ID = G.ID_BEBIDA
WHERE B.GRADO_ALCOHOL >= 4 AND B.GRADO_ALCOHOL <= 8 AND B.NOMBRE NOT LIKE 'bebida%'
GROUP BY B.NOMBRE;

/*7. Para las ciudades de Cali, Bogotá y Medellín, obtener el nombre y el ID de todos los bares que sirven
bebidas en horario nocturno, mostrando los resultados ordenados por ciudad y nombre del bar.*/
SELECT ID2 AS ID, NOMBRE2 AS NOMBRE, CIUDAD
FROM PARRANDEROS.BARES
WHERE (CIUDAD='Bogota' OR CIUDAD='Cali' OR CIUDAD='Medellin') AND ID2 IN (
    SELECT ID_BAR AS ID2
    FROM PARRANDEROS.SIRVEN
    WHERE HORARIO='nocturno'
)
ORDER BY CIUDAD, NOMBRE2;

/*8. El nombre de los bares que sirven bebidas de más de 9 grados de alcohol y que hayan sido visitados
por al menos un bebedor, ordenados por el nombre del bar. Reporte las primeras 20 filas*/
SELECT UNIQUE(NOMBRE2) AS NOMBRE -- No especifica nombres unicos
FROM PARRANDEROS.BARES
WHERE ID2 IN (
    SELECT ID_BAR
    FROM PARRANDEROS.SIRVEN S
    INNER JOIN PARRANDEROS.BEBIDAS B ON S.ID_BEBIDA=B.ID
    WHERE B.GRADO_ALCOHOL > 9
) AND ID2 IN (
    SELECT ID_BAR
    FROM PARRANDEROS.FRECUENTAN
)
ORDER BY NOMBRE2
FETCH FIRST 20 ROWS ONLY;

SELECT * FROM SIRVEN;
SELECT * FROM BEBIDAS;
SELECT * FROM TIPOS_BEBIDA;

/* 9. El nombre de las bebidas que les gustan a los bebedores que no hayan visitado ningún bar y cuyo
nombre no contenga la palabra ‘bebida’. Reporte las primeras 10 filas.*/
SELECT DISTINCT BEB.NOMBRE
FROM PARRANDEROS.BEBIDAS BEB
JOIN PARRANDEROS.GUSTAN G ON BEB.ID = G.ID_BEBIDA
WHERE BEB.NOMBRE NOT LIKE '%bebida%' AND G.ID_BEBEDOR NOT IN (SELECT ID_BEBEDOR FROM PARRANDEROS.FRECUENTAN)
FETCH FIRST 10 ROWS ONLY;

/* 10. Los clientes mixtos distintos a los que les gusta la bebida de tipo vino tinto. Un cliente mixto es aquel
que visita bares de todos los presupuestos. Se debe mostrar el nombre del cliente y su ID. Los
resultados deben organizarse de acuerdo con el nombre del bebedor. Reporte las primeras 20 filas.*/
SELECT DISTINCT BEB.NOMBRE, BEB.ID
FROM PARRANDEROS.BEBEDORES BEB



ORDER BY BEB.NOMBRE
FETCH FIRST 20 ROWS ONLY;

/*11. El id, nombre y número de visitas de los bebedores que están entre el top 3 de clientes que más han
visitado bares y a los que sólo les gustan las bebidas de más de 9 grados de alcohol.*/
SELECT F.ID_BEBEDOR, BEB.NOMBRE, F.FECHA_VISITA

ORDER BY 
FECTH FIRST 3 ROWS ONLY

