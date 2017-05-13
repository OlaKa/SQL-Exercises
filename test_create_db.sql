DROP DATABASE IF EXISTS BOENDE;
CREATE DATABASE Boende;

USE Boende;

-- DROP DATABASE IF EXISTS BOENDE
-- DROP TABLE Hus;
-- DROP TABLE Person;

CREATE TABLE Hus (
    Nummer INT NOT NULL AUTO_INCREMENT,
    Adress VARCHAR(50) NOT NULL,
    Postnummer CHAR(5) NOT NULL,
    Ort VARCHAR(50) NOT NULL,
    PRIMARY KEY (Nummer)
);

-- ALTER TABLE HUS
-- DROP COLUMN Ort;
-- ALTER TABLE Hus
-- ADD COLUMN Stad varchar (50) NOT NULL:

-- DROP TABLE Person;
-- DROP TABLE Boende;

-- En till många
CREATE TABLE Person (
    Personnummer CHAR(10) PRIMARY KEY,
    Namn VARCHAR(50) NOT NULL,
    Epost VARCHAR(25) NOT NULL,
    Telefonnummer CHAR(15),
    Husnummer INT NOT NULL,
    FOREIGN KEY (Husnummer)
    -- ta bort alla referenser 
	REFERENCES Hus (Nummer) ON DELETE CASCADE
);

-- Många till många exempel
/*CREATE TABLE Boende (
Husnummer int NOT NULL ,
Personnummer char(10) NOT NULL,
PRIMARY KEY (Husnummer, Personnummer),
FOREIGN KEY (Husnummer) REFERENCES Hus (Nummer),
FOREIGN KEY (Personnummer) REFERENCES Person (Personnummer)
);*/



