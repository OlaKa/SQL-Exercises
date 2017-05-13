USE Skola;

INSERT INTO Klass VALUES ('J16','JAVA16','2016');
INSERT INTO Klass VALUES ('P16','PROG16','2016');
INSERT INTO Klass VALUES ('E16','EL16','2015');
INSERT INTO Klass VALUES ('M16','MF16','2017');
INSERT INTO Klass VALUES ('UX16','UX16','2014');
-- INSERT INTO Hus (Adress,Postnummer,Ort) VALUES('Gatan 1','12121','Staden');
INSERT INTO Elev VALUES ('9001011234','J16','Peter','Parker','spidey@mail.com','12345678');
-- SELECT * FROM Elev;
INSERT INTO Elev VALUES ('9101011234','P16','Bruce','Parker','bruce@mail.com','12345678');
INSERT INTO Elev VALUES ('9201011235','E16','Niklas','Parker','niklas@mail.com','12345678');
INSERT INTO Elev VALUES ('9301011234','UX16','Ola','Parker','ola@mail.com','12345678');
INSERT INTO Elev VALUES ('9401011234','J16','Martina','Levin','martina@mail.com','12345678');
INSERT INTO Elev VALUES ('9501011234','UX16','Christoffer','Parker','krille@mail.com','12345678');
INSERT INTO Elev VALUES ('9601011234','J16','Nicole','Sandberg','spidey@mail.com','12345678');
INSERT INTO Elev VALUES ('9701011234','M16','Sey','Ran','spidey@mail.com','12345678');
INSERT INTO Elev VALUES ('9801011234','M16','Rand','Botani','rand@mail.com','12345678');
INSERT INTO Elev VALUES ('8901011234','P16','Bruce','Banner','spidey@mail.com','12345678');
-- Avdelning
-- SELECT * FROM Avdelning;
INSERT INTO Avdelning VALUES(11,'IT-avdelningen');
INSERT INTO Avdelning VALUES(12,'Samhäll-avdelningen');
INSERT INTO Avdelning VALUES(13,'Matematik-avdelningen');
-- Lärare
INSERT INTO Lärare VALUES(1,11,'techer@mail.com','Kalle','Anka',13456789);
INSERT INTO Lärare VALUES(2,12,'techer@mail.com','Donald','Trump',13456789);
INSERT INTO Lärare VALUES(3,13,'techer@mail.com','Melania','Trump',13456789);
INSERT INTO Lärare VALUES(4,13,'techer@mail.com','Steve','Bannon',13456789);
INSERT INTO Lärare VALUES(5,11,'techer@mail.com','Clark','Kent',13456789);
-- SELECT * FROM Undervisar;
-- Kurser
INSERT INTO Kurs VALUES('K112','Javaprogrammering',170501,50);
INSERT INTO Kurs VALUES('N112','Csharpprogrammering',170501,50);
INSERT INTO Kurs VALUES('L112','Javascript',170501,50);
INSERT INTO Kurs VALUES('M112','Databaser',170501,50);
INSERT INTO Kurs VALUES('N113','Backend',170501,50);
-- Lokal
INSERT INTO Lokal VALUES(19,'C410',30);
INSERT INTO Lokal VALUES(20,'B304W',25);
INSERT INTO Lokal VALUES(21,'A101',30);
-- KursLokal
INSERT INTO KursLokal VALUES('K112',19,'2017-5-4',2555);
INSERT INTO KursLokal VALUES('N113',20,'2017-2-5',2444);
INSERT INTO KursLokal VALUES('M112',21,'2017-2-28',2444);
-- SHOW TABLES IN Skola;
INSERT INTO Undervisar VALUES('K112', 1);
INSERT INTO Undervisar VALUES('N112', 2);
INSERT INTO Undervisar VALUES('K112', 3);
INSERT INTO Undervisar VALUES('M112', 4);
INSERT INTO Undervisar VALUES('N113', 5);

-- Betyg på elever
INSERT INTO KursBetyg VALUES('9301011234', 'K112', 'VG');
INSERT INTO KursBetyg VALUES('9501011234', 'N112', 'G');
INSERT INTO KursBetyg VALUES('8901011234', 'M112', 'VG');
INSERT INTO KursBetyg VALUES('9701011234', 'L112', 'VG');
INSERT INTO KursBetyg VALUES('9101011234', 'N113', 'VG');

-- Klasskurs

INSERT INTO KlassKurs VALUES('J16', 'K112');
INSERT INTO KlassKurs VALUES('P16', 'N112');
INSERT INTO KlassKurs VALUES('E16', 'K112');
INSERT INTO KlassKurs VALUES('M16', 'M112');
INSERT INTO KlassKurs VALUES('UX16', 'N113');
INSERT INTO KlassKurs VALUES('SOCIA', 'FB100');
INSERT INTO KlassKurs VALUES('SPONT', 'DB001');