create database Hito_4;
use Hito_4;

create table users(
    id_user integer auto_increment primary key not null,
    fullname varchar(50) not null,
    lastname varchar(50) not null,
    age integer not null,
    email varchar(100) not null
);

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