create database Hito_4;
use Hito_4;

create table users(
    id_user integer auto_increment primary key not null,
    fullname varchar(50) not null,
    lastname varchar(50) not null,
    age integer not null,
    email varchar(100) not null
);
drop table users;
insert into users(fullname, lastname, age, email) values
('User1' , 'UserLastname1' , 20 , 'user1@gmail.com'),
('User2' , 'UserLastname2' , 30 , 'user2@gmail.com'),
('User3' , 'UserLastname3' , 40 , 'user3@gmail.com'),
('User4' , 'UserLastname4' , 50 , 'user4@gmail.com'),
('User5' , 'UserLastname5' , 60 , 'user5@gmail.com');

select * from users;

#Determinar cuantos usuarios son mayores a 40 anhos

create or replace view user_mayor_40 as
select us.fullname as nombres_persona,
       us.lastname as apellidos_persona,
       us.age as edad_persona
from users as us
where age > 40;

#Mostrar los datos de la tabla virtual

select *
from user_mayor_40;

drop view user_mayor_40;

#Agragar un nuevo registro a la tabla
insert into users(fullname, lastname, age, email) VALUES
('User6' , 'UserLastname6' , 70 , 'user6@gmail.com');

#agragar nnueva columna de nombre password

alter table users add column password varchar(50);

#Generar los passwords en los registros

create or replace trigger genera_password
    before insert on users
    for each row
    begin
        SET new.password = 'pass-123';
    end;

select * from users;

insert into users(fullname, lastname, age, email) VALUES
('User7' , 'UserLastname7' , 70 , 'user7@gmail.com');

# Los triggers se ejecutan de manera automatica cada ves que haga un insert, update y delete
# NEW = INSERT
# OLD = DELETE
# NEW AND OLD = UPDATE

create or replace trigger genera_password2
    before insert on users
    for each row
    begin
        set new.password=  concat(substring(new.fullname,1,2),substring(new.lastname,1,2),substring(new.age,1,2));

    end;

insert into users(fullname, lastname, age, email) VALUES
('User6' , 'UserLastname6' , 70 , 'user6@gmail.com');

create table numeros(
    numero bigint primary key not null,
    cuadrado bigint,
    cubo bigint,
    raizCuadrada real
);

insert into numeros(numero) values (4);
select * from numeros;

create or replace trigger calcula_Valor
before insert on numeros
    for each row
    begin
        set NEW.cuadrado = NEW.numero * NEW.numero;
        set NEW.cubo = NEW.numero * NEW.numero * NEW.numero;
        set NEW.raizCuadrada = sqrt(NEW.numero);
    end;

select * from numeros;










CREATE TABLE autor
(
    id_autor    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name        VARCHAR(100),
    nacionality VARCHAR(50)
);

CREATE TABLE book
(
    id_book   INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    codigo    VARCHAR(25)                        NOT NULL,
    isbn      VARCHAR(50),
    title     VARCHAR(100),
    editorial VARCHAR(50),
    pages     INTEGER,
    id_autor  INTEGER,
    FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);

CREATE TABLE category
(
    id_cat  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    type    VARCHAR(50),
    id_book INTEGER,
    FOREIGN KEY (id_book) REFERENCES book (id_book)
);

CREATE TABLE users
(
    id_user  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ci       VARCHAR(15)                        NOT NULL,
    fullname VARCHAR(100),
    lastname VARCHAR(100),
    address  VARCHAR(150),
    phone    INTEGER
);
drop table users;
CREATE TABLE prestamos
(
    id_prestamo    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_book        INTEGER,
    id_user        INTEGER,
    fec_prestamo   DATE,
    fec_devolucion DATE,
    FOREIGN KEY (id_book) REFERENCES book (id_book),
    FOREIGN KEY (id_user) REFERENCES users (id_user)
);

INSERT INTO autor (name, nacionality)
VALUES ('autor_name_1', 'Bolivia'),
       ('autor_name_2', 'Argentina'),
       ('autor_name_3', 'Mexico'),
       ('autor_name_4', 'Paraguay');

INSERT INTO book (codigo, isbn, title, editorial, pages, id_autor)
VALUES ('codigo_book_1', 'isbn_1', 'title_book_1', 'NOVA', 30, 1),
       ('codigo_book_2', 'isbn_2', 'title_book_2', 'NOVA II', 25, 1),
       ('codigo_book_3', 'isbn_3', 'title_book_3', 'NUEVA SENDA', 55, 2),
       ('codigo_book_4', 'isbn_4', 'title_book_4', 'IBRANI', 100, 3),
       ('codigo_book_5', 'isbn_5', 'title_book_5', 'IBRANI', 200, 4),
       ('codigo_book_6', 'isbn_6', 'title_book_6', 'IBRANI', 85, 4);

INSERT INTO category (type, id_book)
VALUES ('HISTORIA', 1),
       ('HISTORIA', 2),
       ('COMEDIA', 3),
       ('MANGA', 4),
       ('MANGA', 5),
       ('MANGA', 6);

INSERT INTO users (ci, fullname, lastname, address, phone)
VALUES ('111 cbba', 'user_1', 'lastanme_1', 'address_1', 111),
       ('222 cbba', 'user_2', 'lastanme_2', 'address_2', 222),
       ('333 cbba', 'user_3', 'lastanme_3', 'address_3', 333),
       ('444 lp', 'user_4', 'lastanme_4', 'address_4', 444),
       ('555 lp', 'user_5', 'lastanme_5', 'address_5', 555),
       ('666 sc', 'user_6', 'lastanme_6', 'address_6', 666),
       ('777 sc', 'user_7', 'lastanme_7', 'address_7', 777),
       ('888 or', 'user_8', 'lastanme_8', 'address_8', 888);

INSERT INTO prestamos (id_book, id_user, fec_prestamo, fec_devolucion)
VALUES (1, 1, '2017-10-20', '2017-10-25'),
       (2, 2, '2017-11-20', '2017-11-22'),
       (3, 3, '2018-10-22', '2018-10-27'),
       (4, 3, '2018-11-15', '2017-11-20'),
       (5, 4, '2018-12-20', '2018-12-25'),
       (6, 5, '2019-10-16', '2019-10-18');


create or replace view bookcontent as
select title as tittleBook, editorial as editorialBook, pages as pagesBook ,
       (case
           when pages > 10 and pages <= 30 then 'Contenido Basico'
           when pages > 30 and pages <= 80 then 'Contenido Mediano'
           when pages > 80 and pages <= 150 then 'Contenido Superior'
           when pages > 150  then 'Contenido Avanzzado'
    end) as typeContentBook , get_myFuntion(pages )
from book;

select *
from bookcontent;

create or replace function get_myFuntion(pages integer) returns text
begin
    declare respuesta text default '';

    case
           when pages > 10 and pages <= 30 then set respuesta ='Contenido Basico';
           when pages > 30 and pages <= 80 then set respuesta= 'Contenido Mediano';
           when pages > 80 and pages <= 150 then set respuesta = 'Contenido Superior';
           when pages > 150  then set respuesta = 'Contenido Avanzzado';
    end case;
    return respuesta;
end;


select concat(bk.title,' - ', bk.editorial,' - ', cat.type) AS BOOK_DETAIL, concat(au.name,' - ', au.nacionality) AS AUTOR_DETAIL
    from book as bk
       inner join autor as au on bk.id_autor = au.id_autor
       inner join category as cat on bk.id_book = cat.id_book
WHERE au.nacionality = 'Argentina' or au.nacionality='Bolivia';






create table numeros(
    numero bigint primary key not null,
    cuadrado bigint,
    cubo bigint,
    raizCuadrada real
);

insert into numeros(numero) values (2);

select * from numeros;

create or replace trigger tr_numeros
    before insert on numeros
    for each row
    begin
        declare valorCuadrado integer default 0;
        declare valorCubo integer default 0;
        declare valorRaizCuadrada integer default 0;

        set  valorCuadrado = pow(NEW.numero , 2);
        set  valorCubo = pow(NEW.numero , 3);
        set  valorRaizCuadrada = sqrt(NEW.numero);

        set NEW.cuadrado = valorCuadrado;
        set NEW.cubo = valorCubo;
        set NEW.raizCuadrada = valorRaizCuadrada;
    end;

insert into numeros(numero) values (4);


CREATE TABLE auditoria_autor
(
   #columnas de auditoria
   operation    CHAR(1)   NOT NULL, -- ('D', 'U', 'I')
   stamp        TIMESTAMP NOT NULL,
   userid       TEXT      NOT NULL,
   hostname     TEXT      NOT NULL,
   #columnas adicionales de la tabla AUTOR
   type text not null ,
   id_book text not null
);

create or replace trigger tr_audit_category
    before update on category
    for each row
    begin
        declare typeCat text default '';
        declare idBookCat text default '';

        set typeCat = NEW.type;
        set idBookCat = NEW.id_book;

        insert into auditoria_autor(operation, stamp, userid, hostname, type , id_book)
        select 'U' , now() , user() , @@hostname , typeCat , idBookCat;

    end;

