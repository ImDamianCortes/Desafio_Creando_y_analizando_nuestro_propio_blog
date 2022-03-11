---
--1.Crear base de datos llamada blog.
---

CREATE DATABASE blog;
--1.1   Acceder a la base de datos
\c blog;

---
--2.Crear las tablas indicadas de acuerdo al modelo de datos.
---

--2.1   create table usuario
CREATE TABLE usuario(id INT, email VARCHAR(50), PRIMARY KEY (id));
--2.2   create table post
CREATE TABLE post(id INT,usuario_id INT, titulo VARCHAR(100), fecha DATE, PRIMARY KEY (id), FOREIGN KEY (usuario_id) REFERENCES usuario(id));
--2.3   create table comentario
CREATE TABLE comentario(id INT,usuario_id INT,post_id INT, texto VARCHAR(100), fecha DATE, PRIMARY KEY (id), FOREIGN KEY (post_id) REFERENCES post(id), FOREIGN KEY (usuario_id) REFERENCES usuario(id));

---
--3.Insertar los siguientes registros.
---

--3.1   importar registros usuario
COPY usuario FROM 'C:\Users\darkm\Desktop\Modulo 5\Desafio_Creando_y_analizando_nuestro_propio_blog\assets\registros\usuario.csv' csv header;
--3.2   importar registros post
COPY post FROM 'C:\Users\darkm\Desktop\Modulo 5\Desafio_Creando_y_analizando_nuestro_propio_blog\assets\registros\post.csv' csv header;
--3.3   importar registros comentario
COPY comentario FROM 'C:\Users\darkm\Desktop\Modulo 5\Desafio_Creando_y_analizando_nuestro_propio_blog\assets\registros\comentario.csv' csv header;

--3.4   vefificar tablas

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

---
--4.Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
---

SELECT post.usuario_id, usuario.email, post.id, post.titulo
FROM usuario
INNER JOIN post
ON usuario.id = post.usuario_id AND usuario.id=5;

 id |        email        | id |           titulo
----+---------------------+----+----------------------------
  5 | usuario05@yahoo.com |  2 | Post 2: Esto es malo
  5 | usuario05@yahoo.com |  6 | Post 6: Esto es excelente
  5 | usuario05@yahoo.com |  8 | Post 8: Esto es excelente
  5 | usuario05@yahoo.com | 13 | Post 13: Esto es excelente
(4 filas)

---
--5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
---

SELECT comentario.usuario_id, usuario.email, comentario.id, comentario.texto
FROM usuario
INNER JOIN comentario
ON usuario.id = comentario.usuario_id WHERE NOT usuario.email='usuario06@hotmail.com';

 usuario_id |         email         | id |          texto
------------+-----------------------+----+--------------------------
          3 | usuario03@gmail.com   |  1 | Este es el comentario 1
          4 | usuario04@hotmail.com |  2 | Este es el comentario 2
          2 | usuario02@gmail.com   |  4 | Este es el comentario 4
          3 | usuario03@gmail.com   |  6 | Este es el comentario 6
          8 | usuario08@yahoo.com   |  9 | Este es el comentario 9
          8 | usuario08@yahoo.com   | 10 | Este es el comentario 10
          5 | usuario05@yahoo.com   | 11 | Este es el comentario 11
          8 | usuario08@yahoo.com   | 12 | Este es el comentario 12
          1 | usuario01@hotmail.com | 13 | Este es el comentario 13
          2 | usuario02@gmail.com   | 14 | Este es el comentario 14
          4 | usuario04@hotmail.com | 15 | Este es el comentario 15
(11 filas)

--tambien se puede ordenar por id

SELECT comentario.usuario_id, usuario.email, comentario.id, comentario.texto
FROM usuario
INNER JOIN comentario
ON usuario.id = comentario.usuario_id WHERE NOT usuario.email='usuario06@hotmail.com' ORDER BY usuario.id;

 usuario_id |         email         | id |          texto
------------+-----------------------+----+--------------------------
          1 | usuario01@hotmail.com | 13 | Este es el comentario 13
          2 | usuario02@gmail.com   | 14 | Este es el comentario 14
          2 | usuario02@gmail.com   |  4 | Este es el comentario 4
          3 | usuario03@gmail.com   |  6 | Este es el comentario 6
          3 | usuario03@gmail.com   |  1 | Este es el comentario 1
          4 | usuario04@hotmail.com | 15 | Este es el comentario 15
          4 | usuario04@hotmail.com |  2 | Este es el comentario 2
          5 | usuario05@yahoo.com   | 11 | Este es el comentario 11
          8 | usuario08@yahoo.com   | 12 | Este es el comentario 12
          8 | usuario08@yahoo.com   | 10 | Este es el comentario 10
          8 | usuario08@yahoo.com   |  9 | Este es el comentario 9
(11 filas)

---
--6. Listar los usuarios que no han publicado ningún post.
---

SELECT * 
FROM usuario
FULL OUTER JOIN post ON usuario.id=post.usuario_id
WHERE post.id is null;

 id |        email        | id | usuario_id | titulo | fecha
----+---------------------+----+------------+--------+-------
  3 | usuario03@gmail.com |    |            |        |
(1 fila)

---
--7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).
---

SELECT *
FROM post
LEFT JOIN comentario
ON post.id = comentario.post_id;

 id | usuario_id |           titulo           |   fecha    | id | usuario_id | post_id |          texto           |   fecha
----+------------+----------------------------+------------+----+------------+---------+--------------------------+------------
  6 |          5 | Post 6: Esto es excelente  | 2020-07-18 |  1 |          3 |       6 | Este es el comentario 1  | 2020-07-08
  2 |          5 | Post 2: Esto es malo       | 2020-06-20 |  2 |          4 |       2 | Este es el comentario 2  | 2020-06-07
  4 |          9 | Post 4: Esto es bueno      | 2020-05-09 |  3 |          6 |       4 | Este es el comentario 3  | 2020-06-16
 13 |          5 | Post 13: Esto es excelente | 2020-05-30 |  4 |          2 |      13 | Este es el comentario 4  | 2020-06-15
  6 |          5 | Post 6: Esto es excelente  | 2020-07-18 |  5 |          6 |       6 | Este es el comentario 5  | 2020-05-14
  3 |          1 | Post 3: Esto es excelente  | 2020-05-30 |  6 |          3 |       3 | Este es el comentario 6  | 2020-07-08
  1 |          1 | Post 1: Esto es malo       | 2020-06-29 |  7 |          6 |       1 | Este es el comentario 7  | 2020-05-22
  7 |          8 | Post 7: Esto es excelente  | 2020-07-07 |  8 |          6 |       7 | Este es el comentario 8  | 2020-07-09
 13 |          5 | Post 13: Esto es excelente | 2020-05-30 |  9 |          8 |      13 | Este es el comentario 9  | 2020-06-30
  6 |          5 | Post 6: Esto es excelente  | 2020-07-18 | 10 |          8 |       6 | Este es el comentario 10 | 2020-06-19
  1 |          1 | Post 1: Esto es malo       | 2020-06-29 | 11 |          5 |       1 | Este es el comentario 11 | 2020-05-09
 15 |          7 | Post 15: Esto es malo      | 2020-06-17 | 12 |          8 |      15 | Este es el comentario 12 | 2020-06-17
  9 |          2 | Post 9: Esto es bueno      | 2020-05-08 | 13 |          1 |       9 | Este es el comentario 13 | 2020-05-01
  5 |          7 | Post 5: Esto es bueno      | 2020-07-10 | 14 |          2 |       5 | Este es el comentario 14 | 2020-05-31
  3 |          1 | Post 3: Esto es excelente  | 2020-05-30 | 15 |          4 |       3 | Este es el comentario 15 | 2020-06-28
 11 |          4 | Post 11: Esto es bueno     | 2020-05-05 |    |            |         |                          |
 12 |          9 | Post 12: Esto es malo      | 2020-07-23 |    |            |         |                          |
 10 |          6 | Post 10: Esto es bueno     | 2020-06-02 |    |            |         |                          |
  8 |          5 | Post 8: Esto es excelente  | 2020-05-14 |    |            |         |                          |
 14 |          8 | Post 14: Esto es excelente | 2020-05-01 |    |            |         |                          |
(20 filas)

--tambien se puede ordenar por post.id

SELECT *
FROM post
LEFT JOIN comentario
ON post.id = comentario.post_id ORDER BY post.id;

 id | usuario_id |           titulo           |   fecha    | id | usuario_id | post_id |          texto           |   fecha
----+------------+----------------------------+------------+----+------------+---------+--------------------------+------------
  1 |          1 | Post 1: Esto es malo       | 2020-06-29 | 11 |          5 |       1 | Este es el comentario 11 | 2020-05-09
  1 |          1 | Post 1: Esto es malo       | 2020-06-29 |  7 |          6 |       1 | Este es el comentario 7  | 2020-05-22
  2 |          5 | Post 2: Esto es malo       | 2020-06-20 |  2 |          4 |       2 | Este es el comentario 2  | 2020-06-07
  3 |          1 | Post 3: Esto es excelente  | 2020-05-30 | 15 |          4 |       3 | Este es el comentario 15 | 2020-06-28
  3 |          1 | Post 3: Esto es excelente  | 2020-05-30 |  6 |          3 |       3 | Este es el comentario 6  | 2020-07-08
  4 |          9 | Post 4: Esto es bueno      | 2020-05-09 |  3 |          6 |       4 | Este es el comentario 3  | 2020-06-16
  5 |          7 | Post 5: Esto es bueno      | 2020-07-10 | 14 |          2 |       5 | Este es el comentario 14 | 2020-05-31
  6 |          5 | Post 6: Esto es excelente  | 2020-07-18 |  1 |          3 |       6 | Este es el comentario 1  | 2020-07-08
  6 |          5 | Post 6: Esto es excelente  | 2020-07-18 |  5 |          6 |       6 | Este es el comentario 5  | 2020-05-14
  6 |          5 | Post 6: Esto es excelente  | 2020-07-18 | 10 |          8 |       6 | Este es el comentario 10 | 2020-06-19
  7 |          8 | Post 7: Esto es excelente  | 2020-07-07 |  8 |          6 |       7 | Este es el comentario 8  | 2020-07-09
  8 |          5 | Post 8: Esto es excelente  | 2020-05-14 |    |            |         |                          |
  9 |          2 | Post 9: Esto es bueno      | 2020-05-08 | 13 |          1 |       9 | Este es el comentario 13 | 2020-05-01
 10 |          6 | Post 10: Esto es bueno     | 2020-06-02 |    |            |         |                          |
 11 |          4 | Post 11: Esto es bueno     | 2020-05-05 |    |            |         |                          |
 12 |          9 | Post 12: Esto es malo      | 2020-07-23 |    |            |         |                          |
 13 |          5 | Post 13: Esto es excelente | 2020-05-30 |  9 |          8 |      13 | Este es el comentario 9  | 2020-06-30
 13 |          5 | Post 13: Esto es excelente | 2020-05-30 |  4 |          2 |      13 | Este es el comentario 4  | 2020-06-15
 14 |          8 | Post 14: Esto es excelente | 2020-05-01 |    |            |         |                          |
 15 |          7 | Post 15: Esto es malo      | 2020-06-17 | 12 |          8 |      15 | Este es el comentario 12 | 2020-06-17
(20 filas)

---
--8. Listar todos los usuarios que hayan publicado un post en Junio.
---

SELECT * 
FROM usuario
INNER JOIN post
ON usuario.id = post.usuario_id
WHERE post.fecha BETWEEN '2020-06-01' AND '2020-06-30';

 id |         email         | id | usuario_id |         titulo         |   fecha
----+-----------------------+----+------------+------------------------+------------
  1 | usuario01@hotmail.com |  1 |          1 | Post 1: Esto es malo   | 2020-06-29
  5 | usuario05@yahoo.com   |  2 |          5 | Post 2: Esto es malo   | 2020-06-20
  6 | usuario06@hotmail.com | 10 |          6 | Post 10: Esto es bueno | 2020-06-02
  7 | usuario07@yahoo.com   | 15 |          7 | Post 15: Esto es malo  | 2020-06-17
(4 filas)