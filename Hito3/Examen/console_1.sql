create database Defensa_Hito_3_2022;
use Defensa_Hito_3_2022;

-- Crear una funcion que permita el uso de una varieble global
set @admin = 'admin';
select @admin;
set @admin = 'Andres';
create or replace function ejemplo() returns varchar(60)
begin
    declare respuesta varchar(60) default '';
    if @admin = 'admin'
    then
        set respuesta = 'Usuario Admin';
        else
        set respuesta = 'Usuario Invitado';
    end if;
    return respuesta;
end;

select ejemplo();

-- crear una funcion que verifique el texto: cadenas iguales o cadenas distintas

set @DBAI = 2;
create or replace function compareStrings('DBA I' text) returns text
begin
        declare respuesta varchar(50) default '';
        case
        when @DBAI >5 then set respuesta = 'Cadenas Iguales';
        else set respuesta = 'Cadenas Distintas';
        end case;
        return respuesta;
end;

create table Clientes(
    id_client integer primary key,
    fullname varchar(60),
    lastname varchar(60),
    age integer,
    genero char(1)
);

insert into clientes (id_client , fullname, lastname, age, genero)
values (1 , 'Andres Vladimir' , 'Quiroga' , 24 , 'M'),
       (2 , 'Vladimi' , 'Putin' , 69 , 'M'),
       (3 , 'Lisa' , 'Simpsons' , 8 , 'F');

create or replace function edad_maxima() returns integer

    begin
            return (
                SELECT MAX(client.age)
                FROM clientes AS client
            ) ;
    end;

select edad_maxima();

create or replace function descenciente(limite integer) returns text
begin
     declare response text default '';
    declare z integer;

    if limite % 2 = 0
    then
    set z = 2;
    else
    if limite % 2 = 1
    then
    set z = 1;
    end if;
    end if;

    while z <= limite do
        set response = CONCAT( z ,','  , response);
        set z = z + 2;

    end while;
    return response;
end;

select descenciente(69);

-- Crear una funcion que genere la serie fibonacci

create or replace function serie_fibonacci(limite integer) returns text
begin
    declare w integer default 0;
    declare d integer default 1;
    declare i integer default 0;
    declare siguiente integer default 0;
    declare respuesta text default 0;

    while i <= limite do
        set i = i + 1;
        if i <= 1
            then
            set siguiente = i;
            else
            set siguiente = w + d;
            set  w = d;
            set d = siguiente;
        end if;
        set respuesta = concat(respuesta , siguiente , ',');
end while;
    return respuesta;
end;

select serie_fibonacci(7);

-- crear una funcion que reciba un parametro de tipo text, la funcion retorna la cadena al reves

create or replace function cadena() returns text
begin
    declare respuesta text default '';
        select reverse('hola') into  respuesta;
    return respuesta;
end;

select cadena();