create database defensa_hito4;
use defensa_hito4;

create table departamento(
    id_dep int primary key auto_increment not null,
    nombre varchar(50)
);

create table provincia(
    id_prov int primary key auto_increment not null,
    nombre varchar(50),
    id_dep int, foreign key (id_dep) references departamento (id_dep)
);

create table proyecto(
    id_proy int primary key auto_increment not null,
    nombre_Proy varchar(100),
    tipo_Proy varchar(30)
);

create table detalle_Proyeto(
    id_dp int primary key auto_increment not null,
    id_per int, foreign key (id_per) references persona (id_per),
    id_proy int, foreign key (id_proy) references proyecto(id_proy)
);
select * from detalle_Proyeto;

create table persona(
    id_per int primary key auto_increment not null,
    nombre varchar(20),
    apellidos varchar(50),
    fecha_nac date,
    edad int,
    email varchar(50),
    id_dep int, foreign key (id_dep) references departamento(id_dep),
    id_prov int, foreign key (id_prov) REFERENCES provincia(id_prov),
    sexo char(1)
);


insert into departamento(nombre) VALUES
('La Paz'),
('Cochabamba');

insert into provincia(nombre) VALUES
('Coroico'),
('Caranavi');

insert into proyecto(nombre_Proy, tipo_Proy) values
('Armamento' , 'Tecnologico'),
('Deforestacion' , 'Forestacion');

insert into detalle_Proyeto(id_dp, id_per, id_proy) VALUES
(1 , 1 , 1),
(2 , 2 , 2);

insert into persona(nombre, apellidos, fecha_nac, edad, email,  sexo) VALUES
('Andres' , 'Quiroga' , '1998-09-11' , 24 , 'andres@gmail.com' , 'M'),
('Vladimir' , 'Huariste' , '1996-02-26' , 26 , 'andres1@gmail.com' , 'M');


create table audit_proyectos(
    nombre_proy_anterior varchar(30),
    nombre_proy_posterior varchar(30),
    tipo_proy_anterior varchar(30),
    tipo_proy_posterior varchar(30),
    operation varchar(30),
    userld varchar(30),
    hostname varchar(30)
);

create or replace trigger audit_update
    before update on proyecto
    for each row
    begin
        declare nombre_proy_anterior text default '';
        declare nombre_proy_posterior text default '';
        declare tipo_proy_anterior text default '';
        declare tipo_proy_posterior text default '';

        set nombre_proy_anterior = OLD.nombre_Proy;
        set nombre_proy_posterior = NEW.nombre_Proy;
        set tipo_proy_anterior = OLD.tipo_Proy;
        set tipo_proy_posterior = new.tipo_Proy;

        insert into audit_proyectos(nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userld, hostname)
        select  'Forestacion' , 'tecnologia' , 'tecnologico' , 'clasico' , 'manual' , 'mario' , 'jefe';
    end;


create or replace view datos as
select concat(per.nombre , '-' , per.apellidos) as fullname ,
       concat(p.nombre_Proy , '-' , p.tipo_Proy) as desc_proyecto ,
       d.nombre as Departamento
from persona as per
inner join departamento d on per.id_dep = d.id_dep
inner join detalle_Proyeto dP on per.id_per = dP.id_per
inner join proyecto p on dP.id_proy = p.id_proy;

CASE
    when departamento.nombre = 'La PAz' then 'LP'
    when departamento.nombre = 'Cochabamba' then 'Cbb'

    end;
 as cod_Dep

