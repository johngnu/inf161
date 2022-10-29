-- LDD

CREATE TABLE AUTO(
	codx   number not null enable,
	descriocion varchar2(50),
	constraint AUTO_pk PRIMARY KEY (codx) enable 
);

CREATE TABLE PROPIETARIO(
	ci number not null enable,
	nombre varchar2(),
	codx number,
	constraint PROPIETARIO_pk PRIMARY KEY (ci) enable,
	constraint PROPIETARIO_fk FOREIGN KEY (codx) REFERENCES AUTO(codx) enable
);


------------------------------------------------------------------------------------ 

CREATE TABLE ADMINISTRATIVO(
	item number not null enable,
	nombre varchar2(50),
	apellido varchar2(50),
	salario number,
	constraint ADMINISTRATIVO_pk PRIMARY KEY (item) enable
);

CREATE TABLE GUARDERIA(
	codGuarderia number not null enable,
	razonSocial varchar2(50),
	direccion varchar2(50),
	constraint GUARDERIA_pk PRIMARY KEY (codGuarderia) enable
);

CREATE TABLE PERSONA(
	ci number not null enable,
	nombre varchar2(50),
	apellido varchar2(50),
	direccion varchar2(50),
	constraint PERSONA_pk PRIMARY KEY (ci) enable
);

CREATE TABLE SALON(
	codSalon number not null enable,
	codGuarderia number not null enable,
	nombre varchar2(50),
	color varchar2(50),
	constraint SALON_pk PRIMARY KEY (codSalon,codGuarderia) enable,
	constraint SALON_fk FOREIGN KEY (codGuarderia) REFERENCES GUARDERIA(codGuarderia) enable
);
CREATE TABLE TRABAJA(
	item number not null enable,
	codGuarderia number not null enable,
	turno varchar2(50),
	constraint TRABAJA_pk PRIMARY KEY (item,codGuarderia) enable,
	constraint TRABAJA_fk FOREIGN KEY (item) REFERENCES ADMINISTRATIVO(item) enable,
	constraint TRABAJA_fk1 FOREIGN KEY (codGuarderia) REFERENCES GUARDERIA(codGuarderia) enable
);

CREATE TABLE ADULTO(
	ci number not null enable,
	nacionalidad varchar2(50),
	constraint ADULTO_pk PRIMARY KEY (ci) enable,
	constraint ADULTO_fk FOREIGN KEY (ci) REFERENCES PERSONA(ci) enable
);

CREATE TABLE EDUCADOR(
	ci number not null enable,
	telefono varchar2(50),
	constraint EDUCADOR_pk PRIMARY KEY (ci) enable,
	constraint EDUCADOR_fk FOREIGN KEY (ci) REFERENCES PERSONA(ci) enable
);

CREATE TABLE EDUCA(
	codSalon number not null enable,
	codGuarderia number not null enable,
	ci_educador number not null enable,
	constraint EDUCA_pk PRIMARY KEY (codSalon,codGuarderia,ci_educador) enable,	
	constraint EDUCA_fk1 FOREIGN KEY (codSalon,codGuarderia) REFERENCES SALON(codSalon,codGuarderia) enable,
	constraint EDUCA_fk2 FOREIGN KEY (ci_educador) REFERENCES EDUCADOR(ci) enable
);

CREATE TABLE NINO(
	ci_nino number not null enable,
	nombre varchar2(50),
	fechanac date,
	codSalon number not null enable,
	codGuarderia number not null enable,
	ci_adulto number not null enable,
	constraint NINO_pk PRIMARY KEY (ci_nino) enable,	
	constraint NINO_fk1 FOREIGN KEY (codSalon,codGuarderia) REFERENCES SALON(codSalon,codGuarderia) enable,
	constraint NINO_fk2 FOREIGN KEY (ci_adulto) REFERENCES ADULTO(ci) enable
);

CREATE TABLE GARANTE(
	item1 number not null enable,
	item2 number not null enable,
	constraint GARANTE_pk PRIMARY KEY (item1,item2) enable,	
	constraint GARANTE_fk1 FOREIGN KEY (item1) REFERENCES ADMINISTRATIVO(item) enable,
	constraint GARANTE_fk2 FOREIGN KEY (item2) REFERENCES ADMINISTRATIVO(item) enable
);

--------------------------------------------------------------------
select * 
from libro
order by titulo

select * 
from libro
where cantidad >= 20 
order by titulo

select * 
from libro
where cantidad >= 20 
order by titulo
--------------------------------------------------------------------
-- Repaso
-- 1 
select titulo, precio, anio
from libro where anio >= 2009
order by titulo
-- 2 
select titulo, precio
from libro 
where titulo like '%DE%'
order by titulo
-- 3
select apepaterno, apematerno, nombre, sexo
from persona 
where sexo like 'Femenino'
and to_char(fechanaci, 'yyyy') >= 1990
order by apepaterno, apematerno, nombre
-- 4
select apepaterno, apematerno, nombre
from persona 
where apepaterno like '____'
order by apepaterno, apematerno, nombre
-- 5
select titulo, precio, anio
from libro 
where (anio >= 1999 and anio <= 2005)
or precio > 400
order by titulo
-----------------------------------------------------------------
-- lab2 (NO entre entre tarde)
-- 17/10/2022
-----------------------------------------------------------------
-- lab3
-- 19/10/2022
select titulo 
  from libro l, escrito_por e, autor a
where a.nacionalidad like 'Boliviana'
and e.ci = a.ci
and e.codlibro = l.codlibro
order by titulo

select p.ci, p.nropedido, p.fecha
from pedido p, pedido_libros pl, (select codlibro from libro l
where l.titulo like 'SEGURIDAD INFORMATICA'
or l.titulo like 'TECNICAS DE OPTIMIZACION') tl 
where p.nropedido = pl.nropedido
and pl.codlibro = tl.codlibro
order by ci

select l.titulo
from libro l, pedido_libros pl, (select nropedido from pedido
where to_char(fecha, 'yyyy') = 1993
or to_char(fecha, 'yyyy') = 2006) tp
where pl.nropedido = tp.nropedido
and l.codlibro = pl.codlibro
order by titulo

extract(year from numtoyminterval(months_between(trunc(sysdate),p.fechanaci),'month')) as edad

select l.titulo
from libro l, escrito_por e, persona p, autor a
where p.ci = a.ci
and p.sexo like 'Femenino'
and (2022 - to_char(fechanaci, 'yyyy')) > 29 
and l.codlibro = e.codlibro
and a.ci = e.ci
order by titulo

select distinct l.titulo
from libro l, escrito_por e, persona p
where p.sexo like 'Femenino'
and (to_char(sysdate, 'yyyy') - to_char(fechanaci, 'yyyy')) > 29 
and l.codlibro = e.codlibro
and p.ci = e.ci
order by titulo
-----------------------------------------------------------------
-- auxi1
-- 21/10/2022

-- 1 Desplegar a los clientes que apellidan con las letras iniciales A y Z
-- del sexo 'Femenino'
select apellido,nombre,fnacimiento
from cliente
where (apellido like 'A%' or apellido like 'Z%') and sexo like 'FEMENINO'
order by apellido

-- 2 Desplegar los clientes donde el nombre empieza con la letra A y tiene 5 letras.
select apellido,nombre, (to_char(sysdate, 'yyyy') - to_char(fnacimiento, 'yyyy')) edad
from cliente
where nombre like 'A_____'

-- 3 Desplegar las habitaciones que tienen un costo mayor a 80 y se encuentran entre los
--   pisos 4 y 5. 
select idhabitacion, piso, tipo, costo
from habitacion
where costo >= 80 and piso between 4 and 5
and tipo like 'VIP'

-- 4 Desplegar los clientes que son del signo Escorpio (del 23 octubre al 21 de noviembre)
select apellido, nombre, fnacimiento
from cliente
where (to_char(fnacimiento,'mm')=10 and to_char(fnacimiento,'dd')>=23) or
(to_char(fnacimiento,'mm')=11 and to_char(fnacimiento,'dd')<=21)
order by to_char(fnacimiento,'mm')

-- 5 Desplegar los clientes que tienen ingresos entre 1000 a 2000 y nacieron los años 1990
-- y 2000.
select apellido,nombre,ingreso
from cliente
where ingreso between 1000 and 2000
and (to_char(fnacimiento,'yyyy') = 1990 or to_char(fnacimiento,'yyyy') = 2000)
order by apellido
-----------------------------------------------------------------
-- lab4
-- 24/10/2022
-- Repaso
-- 1 
select nombre, nro from editorial e,
(select ideditorial, count(*) nro from libro
group by ideditorial) c
where c.ideditorial = e.ideditorial
order by nombre

-- 2
select apepaterno, apematerno, nombre, nro from persona p, 
(select ci, count(*) nro from escrito_por e, libro l
where e.codlibro = l.codlibro
group by ci having count(*) > 2) c
where p.ci = c.ci
order by nro

-- 3
select nropedido, sum(cantidad) from pedido_libros
group by nropedido
order by nropedido

-- 4
select apepaterno, apematerno, nombre from persona p, 
(select ci, count(*) cantidad from pedido
group by ci having count(*) > 2) c
where c.ci = p.ci
order by apepaterno

-- 5
select apepaterno, apematerno, nombre from libro l, escrito_por e, persona p
where precio = (select min(precio) from libro)
and l.codlibro = e.codlibro
and e.ci = p.ci

-----------------------------------------------------------------
-- lab45
-- 26/10/2022
-- Repaso
-- 1 
select apepaterno, apematerno, nombre, 
(to_char(sysdate, 'yyyy') - to_char(fechanaci, 'yyyy')) as edad
from persona p,
(select distinct a.ci from libro l, escrito_por ep, autor a
where l.codlibro = ep.codlibro
and a.ci = ep.ci
and a.nacionalidad like 'Boliviana'
and l.precio between 60 and 125) pt
where p.ci = pt.ci
order by apepaterno



select apepaterno, apematerno, nombre, 
(to_char(sysdate, 'yyyy') - to_char(fechanaci, 'yyyy')) as edad
from persona p,
(select distinct a.ci from libro l, escrito_por ep, autor a
where l.codlibro = ep.codlibro
and a.ci = ep.ci
and a.nacionalidad like 'Boliviana'
and l.precio between 60 and 125) pt
where p.ci = pt.ci
order by apepaterno

select codlibro from escrito_por ep,
(select ci from 
(select ci, (to_char(sysdate, 'yyyy') - to_char(fechanaci, 'yyyy')) as edad from persona order by edad) pt
where edad = (select max(to_char(sysdate, 'yyyy') - to_char(fechanaci, 'yyyy')) from persona)) ept
where ep.ci = ept.ci

select codlibro from escrito_por ep,
(select ci from persona p
where (to_char(sysdate, 'yyyy') - to_char(fechanaci, 'yyyy')) = (select max(to_char(sysdate, 'yyyy') - to_char(fechanaci, 'yyyy')) from persona)) pt
where ep.ci = pt.ci

select * from escrito_por ep
where ep.ci=2586947


select ci, (to_char(sysdate, 'yyyy') - to_char(fechanaci, 'yyyy')) from persona p
where (to_char(sysdate, 'yyyy') - to_char(fechanaci, 'yyyy')) =
(select max(edad) from (select l.codlibro, 
 (to_char(sysdate, 'yyyy') - to_char(fechanaci, 'yyyy')) edad from libro l, escrito_por ep, persona p
where ep.codlibro = l.codlibro
and p.ci = ep.ci) tm)


-- 5 
select nacionalidad, count(*) from autor a, escrito_por ep
where ep.ci = a.ci
group by nacionalidad
order by nacionalidad

select distinct titulo from libro l,
(select pdl.codlibro from persona p, pedido pd, pedido_libros pdl
where p.ci = pd.ci
and p.sexo like 'Femenino'
and pdl.nropedido = pd.nropedido) tm
where l.codlibro = tm.codlibro


select distinct codlibro from pedido_libros pdl,
(select nropedido from persona p, pedido pd
where p.ci = pd.ci
and p.sexo like 'Femenino') tmp
where pdl.nropedido = tmp.nropedido

-- 3
select apepaterno, apematerno, nombre from persona p,
(select ci from escrito_por ep, libro l,
(select ideditorial from editorial
where nombre like 'Aguazul S.A. De C.V' or nombre like 'Hemisferio') t
where l.ideditorial = t.ideditorial
and ep.codlibro = l.codlibro) tp
where tp.ci = p.ci
order by apepaterno

-----------------------------------------------------------------
-- auxi2
-- 28/10/2022

-- 1. Desplegar los clientes que hicieron uso del servicio de KARAOKE.
select apellido, nombre, descripcion
from cliente c, se_hospeda sh, hab_ser hs, servicio s
where c.idcliente = sh.idcliente
and hs.idhabitacion = sh.idhabitacion
and hs.idservicio = s.idservicio
and s.descripcion like 'KARAOKE'
order by apellido

-- 2. Desplegar los clientes de nacionalidad colombiana que están ocupando habitaciones
-- de tipo VIP.
select c.idcliente, apellido, nombre, tipo
from cliente c, se_hospeda sh, habitacion h
where c.idcliente = sh.idcliente
and sh.idhabitacion = h.idhabitacion
and h.tipo like 'VIP'
and c.idpais = (select idpais from pais where nombre like 'COLOMBIA')
order by apellido

-- 3. Desplegar los clientes del sexo ‘MASCULINO’ que tienen el menor ingreso.
select nombre, apellido, ingreso from cliente c
where ingreso = (select min(ingreso) from cliente)
and sexo = 'MASCULINO'


-- 4. Desplegar el cliente que tiene el mayor de los ingresos, de los huéspedes que
-- ingresaron en el mes de julio del 2013.
select nombre, apellido, ingreso, idhabitacion, fechaingreso from cliente c, se_hospeda sh
where c.idcliente = sh.idcliente
and ingreso = (select max(ingreso) 
                 from cliente c, se_hospeda sh
                 where c.idcliente = sh.idcliente
                 and to_char(fechaingreso, 'MM') = 7
                 and to_char(fechaingreso, 'yyyy') = 2013)

-- 5. Desplegar la cantidad de clientes por país
select p.idpais, p.nombre, count(*) nro from pais p, cliente c
where c.idpais = p.idpais
group by p.idpais, p.nombre
order by idpais

-- 6. Desplegar la cantidad huéspedes por habitación. De las habitaciones de tipo VIP
select h.idhabitacion, h.tipo, count(*) nro from habitacion h, se_hospeda sh
where tipo = 'VIP'
and h.idhabitacion = sh.idhabitacion
group by h.idhabitacion, h.tipo

-- 7. Desplegar la cantidad de huéspedes por tipo de habitación
select h.tipo, count(*) nro from habitacion h, se_hospeda sh
where h.idhabitacion = sh.idhabitacion
group by h.tipo

-- 8. Listar los clientes que se hospedan en las habitaciones que hicieron uso de más de dos
-- servicios
select apellido, nombre from cliente c, se_hospeda sh,
(select h.idhabitacion, count(*) nro  from habitacion h, hab_ser hs
where h.idhabitacion = hs.idhabitacion
group by h.idhabitacion having count(*) > 2) tm
where sh.idhabitacion = tm.idhabitacion
and c.idcliente = sh.idcliente
order by apellido

-- 9 Del ejercicio anterior. Desplegar los clientes que son de nacionalidad Argentina o
-- Uruguaya.
select apellido, nombre from cliente c, se_hospeda sh,
(select h.idhabitacion, count(*) nro  from habitacion h, hab_ser hs
where h.idhabitacion = hs.idhabitacion
group by h.idhabitacion having count(*) > 2) tm
where sh.idhabitacion = tm.idhabitacion
and c.idcliente = sh.idcliente
and c.idpais in (select idpais from pais where 'ARGENTINA'||'URUGUAY' like '%'||nombre||'%')
order by apellido
