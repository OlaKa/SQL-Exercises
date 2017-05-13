-- övning 1 

CREATE TABLE ElevHistorik(
Personnummer CHAR(10) NOT NULL PRIMARY KEY,
Namn VARCHAR(100) NOT NULL,
Klassnamn VARCHAR(50)
);

ALTER TABLE KursBetyg
	DROP FOREIGN KEY kursbetyg_ibfk_1;
    
ALTER TABLE KursBetyg
	ADD FOREIGN KEY (Personnummer) REFERENCES Elev(Personnummer) ON DELETE CASCADE;

DELIMITER $$
CREATE TRIGGER ArkiveraElev AFTER DELETE ON elev
FOR EACH ROW 
BEGIN
 DECLARE Klassnamn VARCHAR(50);
 SELECT Namn INTO Klassnamn FROM Klass WHERE Kod = OLD.Klasskod;
 
	INSERT INTO ElevHistorik (Personnummer,Namn, Klassnamn)
		VALUES(OLD.Personnummer,concat(OLD.Förnamn, ' ', OLD.Efternamn), Klassnamn);
END $$

DELIMITER ;

-- övn 2

ALTER TABLE kurs
	ADD COLUMN Slutdatum DATE;
    
SELECT * FROM Kurs;

SET GLOBAL event_scheduler = ON;
SHOW processlist;

DROP TABLE avslutadekurser;

CREATE TABLE AvslutadeKurser(

Kod CHAR(5) PRIMARY KEY,
Namn VARCHAR(50) NOT NULL,
Medelbetyg CHAR(2) NOT NULL
);

DELIMITER \\
CREATE Event ArkiveradeAvslutadeKurser
	ON SCHEDULE EVERY 1 DAY STARTS current_date() -- DATETIME ('2017-01-27 00:00:00')
    DO
    BEGIN
	
      
    SELECT Kod, Namn, (SELECT Betyg FROM betygvarde 
		WHERE betygvarde.Varde = (SELECT ROUND(AVG(Varde)) FROM betygvarde
		INNER JOIN kursbetyg ON KursBetyg.Betyg = betygvarde.Betyg
        WHERE KursBetyg.Kurskod =  Kod)) AS Medelbetyg FROM Kurs WHERE Slutdatum < current_date();
    
    END \\
    
  DELIMITER ;
  
SELECT * FROM AvslutadeKurser;
  
DELIMITER $$

-- ///////////////////////////////////////////////////

CREATE FUNCTION GetMedelvFromKurs(kod CHAR (5))
RETURNS CHAR(2)
BEGIN
RETURN(SELECT Betyg FROM betygvarde 
		WHERE betygvarde.Varde = (SELECT ROUND(AVG(Varde)) FROM betygvarde
		INNER JOIN kursbetyg ON KursBetyg.Betyg = betygvarde.Betyg
        WHERE KursBetyg.Kurskod =  Kod));
END $$

DELIMITER ;  
    
-- //////////////////////////////////////////////////////////

-- övn 4

DELIMITER &&

CREATE PROCEDURE RegistreraElev(IN Personnummer CHAR(10), IN Klassnamn VARCHAR(50))
BEGIN
   
	UPDATE Elev SET Klasskod = (SELECT Kod FROM Klass WHERE Klass.Klassnamn = Klassnam)
        WHERE Elev.Personnummer = Personnummer;

END &&  

DELIMITER ;

SELECT * FROM Elev;

-- övn 5

DROP PROCEDURE MakeCommaSepareradEmailLista;
DELIMITER //
CREATE PROCEDURE MakeCommaSepareradEmailLista()
BEGIN
	DECLARE tempEpost VARCHAR(50);
    DECLARE allEpost VARCHAR(5000) DEFAULT ' ';
     
	DECLARE ElevLista CURSOR FOR
		SELECT Epost FROM Elev;
	DECLARE CONTINUE HANDLER FOR NOT FOUND 
    BEGIN 
 		CLOSE ElevLista;
		SELECT allEpost;
    END;
        
	OPEN ElevLista;
    
   	
	WHILE TRUE DO
     FETCH ElevLista INTO tempEpost;
 		SET allEpost = CONCAT(allEpost,tempEpost, ' , ');
		
        END WHILE;
   
 END //

DELIMITER ;
CALL MakeCommaSepareradEmailLista();

    