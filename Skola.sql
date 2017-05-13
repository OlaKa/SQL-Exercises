DROP DATABASE IF EXISTS SKOLA;
CREATE DATABASE Skola;
USE Skola;

CREATE TABLE Klass (
    Kod CHAR(5) PRIMARY KEY,
    Namn VARCHAR(50) NOT NULL,
    Årskurs INT NOT NULL
);

CREATE TABLE Elev (
    Personnummer CHAR(10) NOT NULL PRIMARY KEY,
    Klasskod CHAR(5) NOT NULL,
    Förnamn VARCHAR(50) NOT NULL,
    Efternamn VARCHAR(50) NOT NULL,
    Epost VARCHAR(50) NOT NULL,
    Telefon CHAR(12) NOT NULL,
    FOREIGN KEY (Klasskod)
        REFERENCES Klass (Kod)
        ON DELETE CASCADE
);

CREATE TABLE Kurs (
    Kod CHAR(5) PRIMARY KEY,
    Namn VARCHAR(50) NOT NULL,
    Startdatum DATE NOT NULL,
    Poäng TINYINT NOT NULL,
    FOREIGN KEY(Kod)
    REFERENCES KlassKurs(Kurskod)
    ON DELETE CASCADE
);

CREATE TABLE KlassKurs (
    Klasskod CHAR(5) NOT NULL,
    Kurskod CHAR(5) NOT NULL,
    PRIMARY KEY (Klasskod , Kurskod),
    FOREIGN KEY (Klasskod)
        REFERENCES Klass (Kod),
    FOREIGN KEY (Kurskod)
        REFERENCES Kurs (Kod)
);

CREATE TABLE KursBetyg (
    Personnummer CHAR(10) NOT NULL,
    Kurskod CHAR(5) NOT NULL,
    Betyg CHAR(2) NOT NULL,
    PRIMARY KEY (Personnummer , Kurskod),
    FOREIGN KEY (Personnummer)
        REFERENCES Elev (Personnummer),
    FOREIGN KEY (Kurskod)
        REFERENCES Kurs (Kod)
);

CREATE TABLE Lokal (
    Lokalnummer INT PRIMARY KEY,
    Namn VARCHAR(50) NOT NULL,
    Antalplatser TINYINT NOT NULL
);


CREATE TABLE KursLokal (
    Kurskod CHAR(5) NOT NULL,
    Lokalnummer INT NOT NULL,
    Datum DATE NOT NULL,
    Tid TIME NOT NULL,
    PRIMARY KEY (Kurskod , Lokalnummer, Datum, Tid),
    FOREIGN KEY (Kurskod)
        REFERENCES Kurs (Kod),
    FOREIGN KEY (Lokalnummer)
        REFERENCES Lokal (Lokalnummer)
);

CREATE TABLE Avdelning (
    Avdelningsnummer INT PRIMARY KEY,
    Namn VARCHAR(50)
);

CREATE TABLE Lärare (
    Anställningsnummer INT PRIMARY KEY,
    Avdelningsnummer INT NOT NULL,
    Epost VARCHAR(50) NOT NULL,
    Förnamn VARCHAR(50) NOT NULL,
    Efternamn VARCHAR(50) NOT NULL,
    Telefon CHAR(12),
    FOREIGN KEY (Avdelningsnummer)
        REFERENCES Avdelning (Avdelningsnummer)
);


CREATE TABLE Undervisar (
    Kurskod CHAR(5) NOT NULL,
    Anställningsnummer INT NOT NULL,
    PRIMARY KEY (Kurskod , Anställningsnummer),
    FOREIGN KEY (Anställningsnummer)
        REFERENCES Lärare (Anställningsnummer),
    FOREIGN KEY (Kurskod)
        REFERENCES Kurs (Kod)
);



