DROP DATABASE IF EXISTS Webbutik;
CREATE DATABASE Webbutik;
Use Webbutik;

CREATE TABLE Kund (
    KundID INT AUTO_INCREMENT,
    Personnummer CHAR(10) NOT NULL,
    Förnamn VARCHAR(50) NOT NULL,
    Efternamn VARCHAR(50) NOT NULL,
    Epost VARCHAR(50) NOT NULL,
    Adress VARCHAR(50) NOT NULL,
    Postnummer CHAR(6) NOT NULL,
    Ort VARCHAR(50) NOT NULL,
    Telefon CHAR(12) NOT NULL,
    PRIMARY KEY (KundID)
);

CREATE TABLE Orders (
    OrderID INT UNSIGNED auto_increment,
    KundID INT,
    OrderDatum DATE NOT NULL,
    Skickad DATE,
    ViktKolli INT,
    FraktSätt VARCHAR(20),
    Rabatt INT,
    PRIMARY KEY (OrderID, KundID),
	FOREIGN KEY (KundID)
        REFERENCES Kund(KundID)
	ON DELETE CASCADE
);

-- //////////////Leverantör //////////////////////
Create TABLE Stad(
	StadsID TINYINT auto_increment,
    Stad VARCHAR (50) NOT NULL,
    PRIMARY KEY(StadsID)
 );
 
CREATE TABLE Leverantör (
    LeverantörID TINYINT AUTO_INCREMENT PRIMARY KEY,
    Namn VARCHAR(50) NOT NULL,
    StadsID TINYINT NOT NULL,
	FOREIGN KEY(StadsID)
		REFERENCES Stad(StadsID)
);


CREATE TABLE Produkt (
    ProduktID CHAR(10) PRIMARY KEY,
    Namn VARCHAR(200),
    LeverantörID TINYINT,
    Pris DOUBLE DEFAULT NULL,
  	FOREIGN KEY (LeverantörID)
        REFERENCES Leverantör (LeverantörID)
);

CREATE INDEX IX_Produkt_Namn ON Produkt(Namn);

CREATE TABLE OrderDetaljer (
    ProduktID CHAR(10),
    OrderID INT UNSIGNED,
    Antal TINYINT UNSIGNED NOT NULL,
    Storlek TINYINT,
    Färg TINYINT,
    PRIMARY KEY (ProduktID, OrderID),
    FOREIGN KEY (ProduktID)
        REFERENCES Produkt (ProduktID),
    FOREIGN KEY (OrderID)
        REFERENCES Orders (OrderID)
);

CREATE TABLE Kategori (
    KategoriID CHAR(4) PRIMARY KEY,
    Namn VARCHAR(25) NOT NULL,
    Beskrivning VARCHAR(200)
);

CREATE TABLE ProduktKategorier (
    ProduktID CHAR(10),
    KategoriID CHAR(4),
    PRIMARY KEY (ProduktID , KategoriID),
    FOREIGN KEY (ProduktID)
        REFERENCES Produkt (ProduktID),
    FOREIGN KEY (KategoriID)
        REFERENCES Kategori (KategoriID)
);

CREATE TABLE BetygVärde (
    ProduktID CHAR,
    KundID INT,
    Betyg VARCHAR(25),
    Värde TINYINT,
    PRIMARY KEY (ProduktID , KundID),
    FOREIGN KEY (ProduktID)
        REFERENCES Produkt (ProduktID),
    FOREIGN KEY (KundID)
        REFERENCES Kund (KundID)
);
 
 -- /////////// Varianter av kläder ////////////////////
 CREATE TABLE Färg (
	FärgID TINYINT PRIMARY KEY auto_increment,
    Färg VARCHAR(10)
);

CREATE TABLE Storlek (
    StorlekID TINYINT PRIMARY KEY auto_increment,
    Storlek CHAR(10)
);   
 
 CREATE TABLE Varianter (
    ProduktID VARCHAR(10),
    StorlekID tinyint,
    FärgID tinyint,
    Antal TINYINT,
    PRIMARY KEY (ProduktID, StorlekID, FärgID),
    FOREIGN KEY (ProduktID)
        REFERENCES Produkt (ProduktID),
	FOREIGN KEY (StorlekID)
        REFERENCES Storlek (StorlekID),
	FOREIGN KEY (FärgID)
        REFERENCES Färg (FärgID)
);   

CREATE TABLE SlutILager (
	ProduktID CHAR(10),
    StorlekID tinyint,
    FärgID tinyint,
	Datum DATE NOT NULL,
    PRIMARY KEY(ProduktID,StorlekID,FärgID)
);

    
-- ///////////// Populate tables ////////////////////

-- ///////////// Kunder /////////////////////////////

INSERT INTO Kund (Personnummer,Förnamn, Efternamn, Epost,Adress,Postnummer, Ort, Telefon)
VALUES ('8506304578','Bo','Jansson','bosse@gmail.com','Villavägen 20','14578','Upplands Väsby','0701345678');
INSERT INTO Kund (Personnummer,Förnamn, Efternamn, Epost,Adress,Postnummer, Ort, Telefon)
VALUES ('7202107844','Lena','Karlsson','lena72@hotmail.com','Sveavägen 45','16512','Stockholm','0709994445');
INSERT INTO Kund (Personnummer,Förnamn, Efternamn, Epost,Adress,Postnummer, Ort, Telefon)
VALUES ('7811078954','Fredrik','Lundström','freddan78@gmail.com','Djursholmsvgen 42','14578','Djursholm','0706127712');
INSERT INTO Kund (Personnummer,Förnamn, Efternamn, Epost,Adress,Postnummer, Ort, Telefon)
VALUES ('6604176678','Nils','Thorwaldsson','nils.thor@spray.se','Villavägen 20','14578','Göteborg','0702347788');
INSERT INTO Kund (Personnummer,Förnamn, Efternamn, Epost,Adress,Postnummer, Ort, Telefon)
VALUES ('9112105422','Daniel','Högberg','danne@bahnhof.se','Folkungagatan 18','11245','Stockholm','07077888124');

-- ///////////// Ordrar ////////////////////////////

INSERT INTO Orders (KundID,OrderDatum)VALUES(2,'2016-02-15');
INSERT INTO Orders (KundID,OrderDatum)VALUES(1,'2016-03-12');
INSERT INTO Orders (KundID,OrderDatum)VALUES(3,'2016-11-24');
INSERT INTO Orders (KundID,OrderDatum) VALUES(5,'2016-12-10');
INSERT INTO Orders (KundID,OrderDatum) VALUES(4,'2016-12-15');
INSERT INTO Orders (KundID,OrderDatum) VALUES(5,'2016-07-04');
INSERT INTO Orders (KundID,OrderDatum) VALUES(1,'2016-08-14');

-- ////////// Städer //////////////////////////
INSERT INTO Stad (Stad) VALUE ('Borås');
INSERT INTO Stad (Stad) VALUE ('Lund');
INSERT INTO Stad (Stad) VALUE ('Uppsala');
INSERT INTO Stad (Stad) VALUE ('Kiruna');
INSERT INTO Stad (Stad) VALUE ('Bejing');
INSERT INTO Stad (Stad) VALUE ('Uddevalla');
INSERT INTO Stad (Stad) VALUE ('Östersund');

-- /////////// Leverantörer /////////////////

INSERT INTO Leverantör (Namn,StadsID) VALUE ('JeansFabriken AB',1);
INSERT INTO Leverantör (Namn,StadsID) VALUE ('Strumpfabriken AB',2);
INSERT INTO Leverantör (Namn,StadsID) VALUE ('Jackfabriken AB',3);
INSERT INTO Leverantör (Namn,StadsID) VALUE ('Mössfabriken AB',4);
INSERT INTO Leverantör (Namn,StadsID) VALUE ('TailorFactory Ltd',5);
INSERT INTO Leverantör (Namn,StadsID) VALUE ('Toppfabriken AB',6);
INSERT INTO Leverantör (Namn,StadsID) VALUE ('Strumpbyxefabriken AB',7);
INSERT INTO Leverantör (Namn,StadsID) VALUE ('Velour Ltd',5);

-- /////////////// Produkter /////////////////////////

INSERT INTO Produkt VALUES ('Produkt1', 'Nudie Jeans',1, 599.00);
INSERT INTO Produkt VALUES ('Produkt2', 'H&M Strumpor',2, 39.99);
INSERT INTO Produkt VALUES ('Produkt3', 'Underbar Sommarjacka',3, 1299.00);
INSERT INTO Produkt VALUES ('Produkt4', 'Gosig Barnmössa',4, 199.00);
INSERT INTO Produkt VALUES ('Produkt5', 'Everest Vinterjacka',5, 2999.00);
INSERT INTO Produkt VALUES ('Produkt6', 'Fit Top Women',6, 99.00);
INSERT INTO Produkt VALUES ('Produkt7', 'Strumpbyxor',7, 149.00);
INSERT INTO Produkt VALUES ('Produkt8', 'Mysbyxor',8, 399.00);


-- ///////////// Produkter Till Ordrar //////////////////////
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg) VALUES ('Produkt1',1,2,1,1);
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg) VALUES ('Produkt2',1,3,2,3);
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg)VALUES ('Produkt6',1,1,5,2);
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg) VALUES ('Produkt5',2,1,2,1);
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg)VALUES ('Produkt1',3,1,2,2);
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg)VALUES ('Produkt2',3,1,3,3);
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg)VALUES ('Produkt3',4,1,6,2);
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg)VALUES ('Produkt1',5,1,2,2);
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg)VALUES ('Produkt7',6,1,4,2);
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg)VALUES ('Produkt4',7,1,5,3);
INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg)VALUES ('Produkt8',7,1,6,4);

-- /////////////// Kategorier ////////////////////////
INSERT INTO Kategori VALUES ('AA11','Underkläder','Underkläder för män');
INSERT INTO Kategori VALUES ('BB22','Jackor','Underkläder för män');
INSERT INTO Kategori VALUES ('CC33','Vinterkläder','Vinterkläder utomhus');
INSERT INTO Kategori VALUES ('DD44','Sommarkläder','Sommarkläder för män och kvinnor');
INSERT INTO Kategori VALUES ('EE55','Huvudbonader','Allt man kan ha på huvudet');
INSERT INTO Kategori VALUES ('FF66','Mössor','Mössor');
INSERT INTO Kategori VALUES ('LL77','Byxor','Vardagsbyxor');
INSERT INTO Kategori VALUES ('KK88','Blåa Byxor','Färg');


-- /////////////// Produkt Till Kategori (många till många) /////////////
INSERT INTO ProduktKategorier VALUES ('Produkt1', 'LL77');
INSERT INTO ProduktKategorier VALUES ('Produkt3', 'BB22');
INSERT INTO ProduktKategorier VALUES ('Produkt5', 'BB22');
INSERT INTO ProduktKategorier VALUES ('Produkt6', 'DD44');
INSERT INTO ProduktKategorier VALUES ('Produkt4', 'FF66');
INSERT INTO ProduktKategorier VALUES ('Produkt5', 'CC33');
INSERT INTO ProduktKategorier VALUES ('Produkt4', 'CC33');
INSERT INTO ProduktKategorier VALUES ('Produkt2', 'AA11');
INSERT INTO ProduktKategorier VALUES ('Produkt7', 'AA11');
INSERT INTO ProduktKategorier VALUES ('Produkt8', 'LL77');
INSERT INTO ProduktKategorier VALUES ('Produkt1', 'KK88');

-- /////////////// Storlek & antal//////////////////////
INSERT INTO Färg (Färg) VALUES ('Blå');
INSERT INTO Färg (Färg) VALUES ('Svart');
INSERT INTO Färg (Färg) VALUES ('Vit');
INSERT INTO Färg (Färg) VALUES ('Grå');
INSERT INTO Storlek (Storlek) VALUES ('32');
INSERT INTO Storlek (Storlek) VALUES ('46');
INSERT INTO Storlek (Storlek) VALUES ('40-45');
INSERT INTO Storlek (Storlek) VALUES ('S');
INSERT INTO Storlek (Storlek) VALUES ('M');
INSERT INTO Storlek (Storlek) VALUES ('L');
INSERT INTO Storlek (Storlek) VALUES ('XL');

-- //////////////// Varianter ////////////////////////
-- Nudie jeans
INSERT INTO Varianter VALUES ('Produkt1',1,1,10);
INSERT INTO Varianter VALUES ('Produkt1',2,2,10);
-- Strumpor
INSERT INTO Varianter VALUES ('Produkt2',2,3,10);
-- Sommarjacka
INSERT INTO Varianter VALUES ('Produkt3',4,2,10);
INSERT INTO Varianter VALUES ('Produkt3',5,2,10);
INSERT INTO Varianter VALUES ('Produkt3',6,2,10);
-- Mössa
INSERT INTO Varianter VALUES ('Produkt4',4,2,10);
-- Vinterjacka
INSERT INTO Varianter VALUES ('Produkt5',4,2,10);
INSERT INTO Varianter VALUES ('Produkt5',5,2,10);
INSERT INTO Varianter VALUES ('Produkt5',6,2,10);
-- Top kvinnor
INSERT INTO Varianter VALUES ('Produkt6',4,3,10);
INSERT INTO Varianter VALUES ('Produkt6',5,3,10);
INSERT INTO Varianter VALUES ('Produkt6',6,3,10);
-- Strumpbyxor
INSERT INTO Varianter VALUES ('Produkt7',5,2,10);
-- Mysbyxor
INSERT INTO Varianter VALUES ('Produkt8',4,4,10);
INSERT INTO Varianter VALUES ('Produkt8',5,4,10);
INSERT INTO Varianter VALUES ('Produkt8',6,4,10);

