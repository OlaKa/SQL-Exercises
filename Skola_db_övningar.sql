USE Skola;

SELECT 1+1 AS Summa; 

Select Årskurs FROM Klass WHERE Kod='J16';

Select * From Elev ORDER BY Personnummer LIMIT 1;

SELECT substring(Namn,5) FROM Klass;

SELECT LEFT(Namn,5) from klass;

SELECT concat(Förnamn,'  ', Efternamn) FROM ELEV;

-- Hur många elever?

SELECT COUNT(*) AS 'Antal elever' FROM Elev;

SELECT MAX(Personnummer) FROM Elev;


-- Hur många lärare har respektive avdelning?

SELECT avdelning.namn, COUNT(Avdelning.Avdelningsnummer) FROM  Lärare
	INNER JOIN avdelning on Lärare.Avdelningsnummer = Avdelning.Avdelningsnummer
		GROUP BY avdelning.Avdelningsnummer;

    
-- Antal lärare per avdelning som har mer än 1 lärare
SELECT avdelning.namn, COUNT(Avdelning.Avdelningsnummer) AS Antal FROM  Lärare
	INNER JOIN avdelning on Lärare.Avdelningsnummer = Avdelning.Avdelningsnummer
		GROUP BY avdelning.Avdelningsnummer
        HAVING Antal > 1;
        
CREATE VIEW EleverMedVG AS
	SELECT Förnamn, Efternamn FROM Elev
    INNER JOIN kursbetyg ON Betyg = 'VG';
    
SELECT DISTINCT * FROM elevermedvg;
SELECT * FROM kursbetyg;

-- /////////////////////////////

-- Lista alla elever i kursen db-teknik med betyg


SELECT 
    Förnamn, Efternamn, Kurskod, Betyg
FROM
    Elev
        left JOIN
    KursBetyg ON Elev.Personnummer = KursBetyg.Personnummer;
    
-- //////////////////////////////////


SELECT 
    Förnamn, Efternamn
FROM
    Elev
        UNION
    SELECT Betyg FROM KursBetyg:
    
--//////////////////

ALTER TABLE Elev 
	ADD Column Ort char(50);
    
Update Elev
	SET Ort = 'Uppsala'
     where Elev. = 5;
    
    Select * FROM Elev;

ALTER TABLE Lärare 
	modify column Lön double NOT NULL;

