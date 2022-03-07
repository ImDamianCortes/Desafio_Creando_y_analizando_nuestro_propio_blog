---------------------------------------------------------------------
--1.    Crear base de datos llamada blog.
---------------------------------------------------------------------

CREATE DATABASE blog;
--1.1   Acceder a la base de datos
\c blog;

---------------------------------------------------------------------
--2.    Crear las tablas indicadas de acuerdo al modelo de datos.
---------------------------------------------------------------------

--2.1   create table usuario
CREATE TABLE usuario(id INT, email VARCHAR(50), PRIMARY KEY (id));
--2.2   create table post
CREATE TABLE post(id INT,usuario_id INT, titulo VARCHAR(100), fecha DATE, PRIMARY KEY (id), FOREIGN KEY (usuario_id) REFERENCES usuario(id));
--2.3   create table comentario
CREATE TABLE comentario(id INT,usuario_id INT,post_id INT, texto VARCHAR(100), fecha DATE, PRIMARY KEY (id), FOREIGN KEY (post_id) REFERENCES post(id), FOREIGN KEY (usuario_id) REFERENCES usuario(id));
--2.4   importar registros usuario
COPY usuario FROM 'C:\Users\darkm\Desktop\Modulo 5\Desafio_Creando_y_analizando_nuestro_propio_blog\assets\registros\usuario.csv' csv header;
--2.5   importar registros post
COPY post FROM 'C:\Users\darkm\Desktop\Modulo 5\Desafio_Creando_y_analizando_nuestro_propio_blog\assets\registros\post.csv' csv header;
--2.6   importar registros comentario
COPY comentario FROM 'C:\Users\darkm\Desktop\Modulo 5\Desafio_Creando_y_analizando_nuestro_propio_blog\assets\registros\comentario.csv' csv header;

--2.7   vefificar tablas

SELECT * FROM usuario;

 id |         email
----+-----------------------
  1 | usuario01@hotmail.com
  2 | usuario02@gmail.com
  3 | usuario03@gmail.com
  4 | usuario04@hotmail.com
  5 | usuario05@yahoo.com
  6 | usuario06@hotmail.com
  7 | usuario07@yahoo.com
  8 | usuario08@yahoo.com
  9 | usuario09@yahoo.com
(9 filas)

SELECT * FROM post;

 id | usuario_id |           titulo           |   fecha
----+------------+----------------------------+------------
  1 |          1 | Post 1: Esto es malo       | 2020-06-29
  2 |          5 | Post 2: Esto es malo       | 2020-06-20
  3 |          1 | Post 3: Esto es excelente  | 2020-05-30
  4 |          9 | Post 4: Esto es bueno      | 2020-05-09
  5 |          7 | Post 5: Esto es bueno      | 2020-07-10
  6 |          5 | Post 6: Esto es excelente  | 2020-07-18
  7 |          8 | Post 7: Esto es excelente  | 2020-07-07
  8 |          5 | Post 8: Esto es excelente  | 2020-05-14
  9 |          2 | Post 9: Esto es bueno      | 2020-05-08
 10 |          6 | Post 10: Esto es bueno     | 2020-06-02
 11 |          4 | Post 11: Esto es bueno     | 2020-05-05
 13 |          5 | Post 13: Esto es excelente | 2020-05-30
 12 |          9 | Post 12: Esto es malo      | 2020-07-23
 14 |          8 | Post 14: Esto es excelente | 2020-05-01
 15 |          7 | Post 15: Esto es malo      | 2020-06-17
(15 filas)

SELECT * FROM comentario;
 id | usuario_id | post_id |          texto           |   fecha
----+------------+---------+--------------------------+------------
  1 |          3 |       6 | Este es el comentario 1  | 2020-07-08
  2 |          4 |       2 | Este es el comentario 2  | 2020-06-07
  3 |          6 |       4 | Este es el comentario 3  | 2020-06-16
  4 |          2 |      13 | Este es el comentario 4  | 2020-06-15
  5 |          6 |       6 | Este es el comentario 5  | 2020-05-14
  6 |          3 |       3 | Este es el comentario 6  | 2020-07-08
  7 |          6 |       1 | Este es el comentario 7  | 2020-05-22
  8 |          6 |       7 | Este es el comentario 8  | 2020-07-09
  9 |          8 |      13 | Este es el comentario 9  | 2020-06-30
 10 |          8 |       6 | Este es el comentario 10 | 2020-06-19
 11 |          5 |       1 | Este es el comentario 11 | 2020-05-09
 12 |          8 |      15 | Este es el comentario 12 | 2020-06-17
 13 |          1 |       9 | Este es el comentario 13 | 2020-05-01
 14 |          2 |       5 | Este es el comentario 14 | 2020-05-31
 15 |          4 |       3 | Este es el comentario 15 | 2020-06-28
(15 filas)











---------------------------------------------------------------------
*********************
---------------------------------------------------------------------
--3.   Obtener el ID de la película “Titanic”.
SELECT id FROM peliculas WHERE pelicula='Titanic';

---------------------------------------------------------------------
--4.   Listar a todos los actores que aparecen en la película "Titanic".
--     En este caso se utiliza un consilta anidada en una consicion.
SELECT reparto FROM reparto WHERE id=(SELECT id FROM peliculas WHERE pelicula='Titanic');

---------------------------------------------------------------------
--5.   Consultar en cuántas películas del top 100 participa Harrison Ford.
SELECT COUNT (id) AS total_participacion_t100_Harrison_Ford FROM reparto WHERE reparto='Harrison Ford';

---------------------------------------------------------------------
--6.   Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.
SELECT id,pelicula,ano_estreno FROM peliculas WHERE ano_estreno BETWEEN '1990' AND '1999' ORDER BY ano_estreno ASC;

--------------------------------------------------------------------
--7.   Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.
SELECT id,pelicula, LENGTH(pelicula) AS longitud_titulo FROM peliculas;

---------------------------------------------------------------------
--8.   Consultar cual es la longitud más grande entre todos los títulos de las películas.
--     inicialmemnte de busca dentro de los titulos de peliculas el maximo largo
SELECT MAX(LENGTH(pelicula)) AS longitud_max_titulo FROM peliculas;
--     debido a que el solo se mustra el largo y no los datos se utiliza una consulta anidada para mostrar la id-titulo y el largo cuando se cumpla la condicion de que el largo sea igual al maximo largo encontrado.
SELECT id,pelicula, LENGTH(pelicula) AS max_longitud_titulo FROM peliculas WHERE LENGTH(pelicula)=(SELECT MAX(LENGTH(pelicula)) FROM peliculas);
