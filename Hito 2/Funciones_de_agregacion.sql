create database function_agregation;

use function_agregation;

create table estudiantes(
    id_est integer auto_increment primary key not null,
    nombres varchar(50),
    apellidos varchar(50),
    edad integer,
    gestion integer,
    fono integer,
    email varchar(100),
    direccion varchar(100),
    sexo varchar(10)
);

select est.*
from estudiantes as est;

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Miguel' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Sandra' ,'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Joel' ,'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Andrea' ,'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Santos' ,'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

# Crear la consulta sql
# que modifique el campo GESTION
# y que asigne a todos el valor 2022

update estudiantes
set gestion = '2022'
where id_est > 0;

CREATE TABLE materias
(
  id_mat INTEGER AUTO_INCREMENT PRIMARY KEY  NOT NULL,
  nombre_mat VARCHAR(100),
  cod_mat VARCHAR(100)
);

CREATE TABLE inscripcion
(
  id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_est INT NOT NULL,

  id_mat INT NOT NULL,
  semestre VARCHAR(20),
  gestion INTEGER,
  FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
  FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);

INSERT INTO materias (nombre_mat, cod_mat) VALUES
    ('Introduccion a la Arquitectura','ARQ-101'),
    ('Urbanismo y Diseno','ARQ-102'),
    ('Dibujo y Pintura Arquitectonico','ARQ-103'),
    ('Matematica discreta','ARQ-104'),
    ('Fisica Basica','ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES
 (1, 1, '1er Semestre', 2015),
 (1, 2, '2do Semestre', 2015),
 (2, 4, '1er Semestre', 2016),
 (2, 3, '2do Semestre', 2016);

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES
 (3, 3, '2do Semestre', 2017),
 (3, 1, '3er Semestre', 2017),
 (4, 4, '4to Semestre', 2017),
 (5, 5, '5to Semestre', 2017);


# Mostrar los nombres y apellidos de los estudiantes inscritos en la materia
# ARQ-104, adicionalmente mostrar el nombre de la materia.
# tablas relacionadas:
# estudiantes
# inscrption
# materia

select est.nombres, est.apellidos, mat.nombre_mat
from inscripcion as ins
inner join estudiantes as est on ins.id_est = est.id_est
inner join materias as mat on ins.id_mat = mat.id_mat
where mat.cod_mat = 'ARQ-104';

# Contar cuantos registros tiene la tabla estudiantes

select count(est.id_est) as 'Cantidad de Estudiantes'
from estudiantes as est;

# Mostrar el promedio de edad en la tabla estudiantes.

 select avg(est.edad) as 'Promedio de Edad'
from estudiantes as est;

# Mostrar la máxima edad que se tiene en la tabla estudiantes.

SELECT MAX(est.edad)
FROM estudiantes AS est;


# Mostrar la mínima edad que se tiene en la estudiantes.
SELECT MIN(est.edad)
FROM estudiantes AS est;

# Determinar la maxima edad de los estudiantes cuyo genero sea masculino o femenino

select max(est.edad) as 'Edad Maxima'
from estudiantes as est
where est.sexo = 'Masculino' && est.edad >20;

# Crear una función que devuelve el máximo valor del campo edad en la tabla estudiantes.

create or replace function get_max_edad()
    returns integer

    begin
            return (
                SELECT MAX(est.edad)
                FROM estudiantes AS est
            ) ;
    end;

select get_max_edad() as MaxEdad;



# Crear una función que obtenga la menor edad de los estudiantes.
# Crear una función que obtenga el promedio de las edades.
# Crear una función que obtenga la mayor edad de los estudiantes (cuyo sexo seas masculino o femenino).

create or replace function get_min_edad()
    returns integer

    begin
            return (
                SELECT MIN(est.edad)
                FROM estudiantes AS est
            );
    end;

select get_min_edad() as MinEdad;

create or replace function get_promedio()
    returns integer

    begin
            return (
                select avg(est.edad) as 'Promedio de Edad'
                from estudiantes as est
                );

    end;


select get_promedio() as Promedio;

create or replace  function get_edad_mayor()
    returns integer

    begin
                return (select max(est.edad) as 'Edad Maxima'
                        from estudiantes as est
                        where est.sexo = 'Masculino' && est.edad >20);
    end;

select get_edad_mayor() as Edadmayor;

#  Mostrar el registro de la tabla estudiantes (nombre y apellidos) donde cuyo id_est sea el máximo.

create or replace function get_max_id()
    returns integer
    begin
            return (
                select max(est.id_est)
                 from estudiantes as est
            );
    end;

select est.nombres, est.apellidos,est.id_est
from estudiantes as est
where est.id_est = get_max_id();
