create database diagnostico;

use diagnostico;

create table cars
 (
     id_cars integer Primary key ,
     marca varchar(50),
     precio varchar(50)
);

insert into cars (id_cars, marca, precio) values(4, 'toyota', '4000bs');
insert into cars (id_cars, marca, precio) values(6, 'nissan', '6000bs');

select *from cars;

create  database universidad;
use universidad;

create table estudiantes(
    id_est integer auto_increment primary key not null,
    nombres varchar(100),
    apellidos varchar(100),
    edad integer,
    fono integer,
    email varchar(50)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email) VALUES ('nombre1', 'apellidos1', 12, 123456, 'nombre1@gmail.com');

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email) VALUES ('nombre2', 'apellidos2', 15, 123456, 'nombre2@gmail.com');

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email) VALUES ('nombre3', 'apellidos3', 19, 123456, 'nombre3@gmail.com');


select *from estudiantes;
# Mostrar el ID del último valor agregado.
select  last_insert_id();

# Agregar un nuevo campo a la tabla estudiantes.
alter table estudiantes add column direccion varchar(100);

# Agregar 2 nuevos campos con una sola instrucción
# para agregar un valor por defecto usamos DAFAULT y el valor
alter table estudiantes
    add column fax varchar(10) default 'fax-123',
    add column sexo varchar(10);

# Eliminar el campo sexo de la tabla estudiantes.
alter table estudiantes drop column sexo;


# Mostrar los registros de aquellos estudiantes que su nombre sea igual a ‘nombre4’.
# Mostrar todos los registros(nombres, apellidos y edad) de los estudiantes en donde la edad sea mayor a 18 años
 select est.nombres, est.apellidos, est.edad
from estudiantes as est
where est.edad >18;

# Mostrar los registros donde cuyo ID sea PAR.  (o IMPAR).

select *
    from estudiantes as est
where est.id_est % 2 = 1;

create database libros;
use libros;

create table categories(
    category_id integer primary key ,
    name varchar(50)
);
drop table publishers;

create table publishers(
    publisher_id integer primary key ,
    name varchar(50)
);

create table books(
    book_id integer not null ,
    title varchar(50) not null ,
    isbn varchar(50) not null ,
    published_date date not null ,
    description varchar(50),
    category_id integer not null,
    publisher_id integer not null ,
    foreign key (category_id) references categories (category_id),
    foreign key  (publisher_id) references  publishers (publisher_id)

);


