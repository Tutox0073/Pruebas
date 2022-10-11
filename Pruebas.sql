DROP database IF EXISTS Pruebas;
create database Pruebas;

use Pruebas;
CREATE TABLE carros (
  placa varchar(5) primary key NOT NULL,
  marca varchar(20) DEFAULT NULL,
  modelo varchar(15) DEFAULT NULL,
  costo float,
  disponible int DEFAULT NULL,
) 

DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
  cedula varchar(20) NOT NULL,
  nombre varchar(20) DEFAULT NULL,
  apellido varchar(20) DEFAULT NULL,
  telefono1 varchar(15) DEFAULT NULL,
  telefono2 varchar(15) DEFAULT NULL,
  PRIMARY KEY (cedula)
) 

DROP TABLE IF EXISTS alquileres;
CREATE TABLE alquileres (
  id int identity(1,1) primary key,
  fecha date,
  valorTotal float,
  saldo float,
  abonoInicial float,
  devuelto bit,
  tiempo int,
  fk_Carro varchar(5) NOT NULL,
  fk_Cliente varchar(20) NOT NULL,
  CONSTRAINT FK_Carros FOREIGN KEY (fk_Carro) REFERENCES carros(placa),
  CONSTRAINT fk_Cliente FOREIGN KEY (fk_Cliente) REFERENCES clientes(cedula)
) 

DROP TABLE IF EXISTS pagos;
CREATE TABLE pagos (
  id int identity (1,1) NOT NULL,
  fechaPago date DEFAULT NULL,
  valor float NULL,
  fk_Alquiler int DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT pagos_ibfk_1 FOREIGN KEY (fk_Alquiler) REFERENCES alquileres (id)
) 

INSERT INTO carros(placa,marca,modelo,costo,disponible) VALUES ('123OT','FORD','Mustang',5000000,1),('356PJ','Mazda','2016',500000,1),('367JJ','Renault','2020',230000,1),('456LI','Tesla','S2021',560000,1),('556PM','Opel','GrandlaxX',790000,1),('786PA','BMW','2022',5000000,1),('983PC','Lexus','ES',230000,1),('986CH','Audi','R8',600000,1);
INSERT INTO clientes(cedula,nombre,apellido,telefono1,telefono2) VALUES ('103122567','paco','gonzales','58624831','310287189'),('123456','Pepito','perez','310123345','3101233445'),('4768203','carlos','rodriguez','3891247','3228921793'),('56382920','maria','rojas','8937129','3108921789'),('7452372761','Noemi','Valencia','14242341','32291273'),('80846392','vanessa','orjuela','8921739','314892179');
INSERT INTO alquileres(fecha,valorTotal,saldo,abonoInicial,devuelto,tiempo,fk_Carro,fk_Cliente) VALUES ('2022-10-01',5000000,250000,4750000,1,3,'123OT','123456'),('2022-10-01',5000000,250000,1000,1,3,'123OT','123456'),('2022-08-20',230000,0,230000,1,3,'367JJ','80846392'),('2022-07-01',5000000,0,5000000,1,3,'786PA','4768203'),('2022-09-25',230000,230000,0,1,3,'983PC','103122567'),('2022-08-10',790000,25000,765000,1,3,'556PM','56382920'),('2022-08-30',600000,0,600000,1,3,'986CH','56382920');
INSERT INTO pagos(fechaPago,valor,fk_Alquiler) VALUES ('2022-08-20',230000,4),('2022-07-01',5000000,5),('2022-08-30',382500,7),('2022-08-15',382500,7),('2022-08-20',1583000,3),('2022-08-20',1583000,3),('2022-08-20',1583000,3);


--consultas 

--1.2
select * from alquileres where fk_Carro = '123OT'
--1.3
select id, saldo, fecha from alquileres where fecha = '2022-10-01'
--1.4
select c.cedula, c.nombre, a.fecha, a.tiempo as 'Tiempo Alquilado', a.saldo, car.placa, car.marca from alquileres as a
inner join clientes as c
ON c.cedula = a.fk_Cliente 
inner join carros as car 
on car.placa = a.fk_Carro;
--1.5
select c.cedula, c.nombre, c.apellido from alquileres as a
inner join clientes as c
ON c.cedula = a.fk_Cliente 
where a.fecha not between '2022-08-01' and '2022-08-30'
--1.6
SELECT a.fecha, COUNT(p.id) 'cuantos pagos', SUM(p.valor) 'total pagado', MAX(p.valor) 'Maximo Valor' FROM alquileres as a 
INNER JOIN pagos as p
on p.fk_Alquiler = a.id
WHERE p.fechaPago >'2022-08-01'
GROUP BY a.fecha
--1.7
SELECT c.placa, MIN(c.modelo), MIN(c.marca), AVG(c.costo), COUNT(a.id) 'Cantidad de alquileres', SUM(a.valorTotal) 'Suma valor total en alquileres' FROM carros as c 
JOIN alquileres as a 
on a.fk_Carro = c.placa AND a.fecha > '2022-08-01' 
GROUP by c.placa;
--1.8
SELECT c.cedula, MIN(a.fecha) FROM clientes as c 
inner JOIN alquileres as a
on a.fk_Cliente = c.cedula
group BY c.cedula
