-- ///////Uppgift 8 /////////////////////////

-- övn 2

DELIMITER &&

CREATE PROCEDURE RegistreraElev(IN Personnummer CHAR(10), 
								IN Förnamn VARCHAR(50),
								IN Efternamn VARCHAR(50),
								IN Epost VARCHAR(50),
								IN Telefon CHAR(12),
								IN Ort VARCHAR(50),
                                IN Klassnamn VARCHAR(50))
BEGIN
	DECLARE ElevFinnsResan BOOL DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR 1062 SET ElevFinnsRedan = TRUE;
    DECLARE EXIT HANDLER FOR 1216 
		BEGIN
		ROLLBACK;
    END;
    
    DECLARE EXIT HANDLER FOR 1048 
		BEGIN
		ROLLBACK;
		SET MESSAGE_TEXT = 'Klassen fanns inte!';
    END;
    
    INSERT INTO Elev
    VALUES(
    Personnummer,
    Förnamn,
    Efternamn,
    Epost,
    Telefon,
    (SELECT Kod FROM Klass WHERE Klass.Namn = Klassnamn),
    Ort
    );
    
    IF ElevFinnsRedan THEN
    
	UPDATE Elev 
 		SET Elev.Förnamn = Förnamn,
        Elev.Efternamn = Efternamn,
        Elev.Epost = Epost,
        Elev.Telefon = Telefon,
		Klasskod = (SELECT Kod FROM Klass WHERE Klass.Klassnamn = Klassnam)
        WHERE Elev.Personnummer = Personnummer;
       
	END IF;
    COMMIT;

END &&  

DELIMITER ;