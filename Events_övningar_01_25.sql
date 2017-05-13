Use Skola;

-- Övning 1 När Elev raderas från databasen

DELIMITER //

CREATE TRIGGER SparaElev AFTER DELETE ON Elev
	FOR EACH ROW
    BEGIN
    
    INSERT INTO TidigareElever(personnummer, namn, klassnamn)
		VALUES(OLD.Personnummer,concat(OLD.Förnamn, ' ', OLD.Efternamn), 
        (SELECT Namn FROM Klass WHERE Klass.Kod = OLD.Klasskod));
END //

DELIMITER ;

DELETE FROM Elev
where Personnummer='9001011234';

Select * FROM TidigareElever;

DROP TRIGGER SparaElev;


CREATE TABLE TidigareElever(
personnummer VARCHAR(50) NOT NULL,
namn varchar (50) NOT NULL,
klassnamn VARCHAR (20) NOT NULL,
PRIMARY KEY (personnummer)
);


---///////////////////////////////////////////////////////////////////////////////////////////
-- övn 2

ALTER TABLE Kurs ADD Slutdatum DATE;

SELECT * FROM Kurs;

SET SQL_SAFE_UPDATES=0;

UPDATE Kurs
SET Slutdatum ='2017-05-29'
	where Kod = 'N112';
    
ALTER TABLE Kurs
	drop foreign key Kod;
    

CREATE TABLE AvslutadeKurser(
kurskod VARCHAR(50) NOT NULL,
namn varchar (50) NOT NULL,
medelbetyg int NOT NULL,
PRIMARY KEY (kurskod)
);


-- skapa ett event
CREATE EVENT gamla_kurser
	ON SCHEDULE EVERY '1' DAY
		STARTS '00:00:00'
	DO 
		SELECT * FROM Klass
			WHERE Slutdatum < current_date();
        

-- /////////////////////        
DROP TRIGGER AvslutadeKurser;      
      
DELIMITER //



CREATE TRIGGER AvslutadeKurser AFTER DELETE ON Kurs
	FOR EACH ROW
    BEGIN
    
    INSERT INTO AvslutadeKurser(kurskod, namn, medelbetyg)
		VALUES(OLD.kod,OLD.namn, 
        (SELECT Betyg FROM BetygVarde WHERE Varde=(SELECT ROUND(AVG(BetygVarde.Varde), 0) FROM KursBetyg)));
 END //

DELIMITER ;

-- ///////////////////

-- övn 3
drop procedure OnGoingCourses;
DELIMITER //
CREATE PROCEDURE OnGoingCourses(startdate date, stopdate date)
	BEGIN
		SELECT Kurs.namn, Kurs.startdatum, Kurs.slutdatum,concat(Lärare.Förnamn, ' ', Lärare.Efternamn) AS Lärare, 
        COUNT(Kurs.namn) AS Antal FROM Lärare
        inner join Undervisar on Undervisar.Anställningsnummer = Lärare.Anställningsnummer
        inner join Kurs on Undervisar.kurskod = Kurs.kod
        inner join KursLokal on KursLokal.Kurskod = Kurs.kod
        where Kurs.startdatum BETWEEN startdate and stopdate
        group by Kurs.namn;
    
    END //
    
DELIMITER ;
    
 DROP PROCEDURE OnGoingCourses;
CALL OnGoingCourses('2017-01-26','2017-05-30');

select * from lärare;
DROP PROCEDURE GetPagaendeKurser;
DELIMITER //
CREATE PROCEDURE GetPagaendeKurser(startdatum DATE, slutdatum DATE)
BEGIN
	SELECT Kurs.Namn, Lärare.Förnamn, Lärare.Efternamn, COUNT(*) AS 'Antal Lektioner' FROM Kurs
		INNER JOIN Undervisar ON Kurs.Kod = Undervisar.Kurskod
		INNER JOIN Lärare ON Undervisar.Anställningsnummer = Lärare.Anställningsnummer
		INNER JOIN KursLokal ON Kurs.Kod = KursLokal.Kurskod
		WHERE Kurs.Startdatum BETWEEN startdatum AND slutdatum
        GROUP BY Kurs.Namn, Lärare.Förnamn, Lärare.Efternamn;
END //
DELIMITER ;

CALL GetPagaendeKurser('2017-01-25','2017-06-01');

-- övn 4 ////////////////////////////////////////
DROP PROCEDURE RegisterPupil;
DELIMITER //
CREATE PROCEDURE RegisterPupil(personnummer varchar(10), klassnamn varchar(15))
	BEGIN
		INSERT INTO Elev(personnummer, klasskod) VALUES(personnummer, klassnamn);
        INSERT INTO Klass(Namn) VALUES (klassnamn);
        
    END //

DELIMITER ;

CALL RegisterPupil('8102101234','E16');


-- /////////////////////////////////////////////////////////////////////////////////
-- övn 5 Samla ihop alla email adresser hos elev

DELIMITER $$
 
CREATE PROCEDURE build_email_list (INOUT email_list varchar(4000))
BEGIN
 
 DECLARE v_finished INTEGER DEFAULT 0;
        DECLARE v_email varchar(100) DEFAULT "";
 
 -- declare cursor for employee email
 DEClARE email_cursor CURSOR FOR 
 SELECT Epost FROM elev;
 
 -- declare NOT FOUND handler
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1;
 
 OPEN email_cursor;
 
 get_email: LOOP
 
 FETCH email_cursor INTO v_email;
 
 IF v_finished = 1 THEN 
 LEAVE get_email;
 END IF;
 
 -- build email list
 SET email_list = CONCAT(v_email," ; ",email_list);
 
 END LOOP get_email;
 
 CLOSE email_cursor;
 
END$$
 
DELIMITER ;

DROP PROCEDURE build_email_list;

SET @email_list = "";
CALL build_email_list(@email_list);
SELECT @email_list;