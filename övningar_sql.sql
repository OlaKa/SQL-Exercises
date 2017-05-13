USE Skola;

-- DISTINCT tar bort dubletter
-- select DISTINCT Efternamn AS Lastname FROM Elev ORDER BY Efternamn ASC;

select Förnamn, Efternamn, Klasskod FROM Elev WHERE Efternamn= 'Parker' ORDER BY Efternamn ASC;


select Förnamn, Efternamn FROM Elev 
	WHERE Efternamn='Parker'AND Klasskod='P16';
    
select Förnamn, Efternamn,Klasskod FROM Elev 
	WHERE Efternamn='Parker'OR Efternamn='Levin' ORDER BY Klasskod;
    
    
    
select Namn, Startdatum FROM Kurs 
	WHERE Startdatum >= '2014-01-01' AND Startdatum <= '2014-12-31';
   
-- Poäng större än 20 mellan datum   
select Namn, Startdatum FROM Kurs 
	WHERE Startdatum BETWEEN '2014-01-01' AND '2014-12-31'
    AND Poäng > 20;
    
-- Börjar med N N%
-- Innehåller:  %SS%
select Förnamn, Efternamn FROM Lärare
		Where Förnamn LIKE 'M%';

-- Insert into
insert Into Lärare VALUES (6,12,'parker@mail.com','Gunnarssson','Gunnar',13456789);
    
-- UPDATE

UPDATE Lärare
SET Telefon = '1212127777'
where Anställningsnummer=6;

-- Delete

DELETE FROM Lärare
Where Anställningsnummer = 6;





    
    