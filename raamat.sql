CREATE DATABASE raamatGrechishkin;
use raamatGrechishkin;
-- tabeli zanr loomine
CREATE TABLE zanr(
zanrID int PRIMARY KEY identity (1,1),
zanrNimetus varchar(50) not null,
kirjeldus TEXT);
Select * from zanr;
-- tabeli täitmine
INSERT INTO zanr(zanrNimetus, kirjeldus)
VALUES ('märulifilm', 'see on märulifilm zanr');

--tabel autor
CREATE TABLE autor(
autorID int PRIMARY KEY identity (1,1),
eesnimi varchar (50),
perenimi varchar (50) not null,
synniaasta int check(synniaasta > 1900),
elukoht varchar (30)
);
select * from autor;

INSERT INTO autor(eesnimi, perenimi, synniaasta)
VALUES ('Leelo', 'Tungal', 1947);

--tabeli uuendamine
UPDATE autor SET elukoht='Tallinn';

--kustutamine tabelist
DELETE FROM autor WHERE autorID=1;

--tabel raamat
CREATE TABLE raamat(
raamatID int PRIMARY KEY identity (1,1),
raamatuNimetus varchar (100) UNIQUE,
lk int,
autorID int,
FOREIGN KEY (autorID) REFERENCES autor(autorID),
zanrID int,
FOREIGN KEY (zanrID) REFERENCES zanr(zanrID),
);

Select * FROM autor;
Select * FROM zanr;

INSERT INTO raamat (raamatuNimetus, lk, autorID, zanrID)
VALUES ('Juku Naljad', 200, 3, 3);

Select * FROM raamat;

--tabel trykikoda
CREATE TABLE trykikoda(
trykikodaID int PRIMARY KEY identity (1,1),
nimetus varchar (50) UNIQUE,
aadress varchar (50) not null,
);

--tabel trykitudRaamat
CREATE TABLE trykitudRaamat(
trRaamatID int PRIMARY KEY identity (1,1),
trykikodaID int,
FOREIGN KEY (trykikodaID) REFERENCES trykikoda (trykikodaID),
raamatID int,
FOREIGN KEY (raamatID) REFERENCES raamat (raamatID),
kogus varchar(50),
);

select * from trykikoda;
select * from trykitudRaamat;

INSERT INTO trykitudRaamat (trykikodaID, raamatID, kogus)
VALUES 
(1, 1, '500'),
(2, 1, '700'),
(3, 2, '300');


