USE Skola;

-- uppg 1

SELECT COUNT(KlassKurs.Klasskod) AS Antal, Kurs.Namn FROM Kurs
	-- Inner join KlassKurs ON KlassKurs.Klasskod = Klass.Kod
		Inner Join KlassKurs on Kurs.Kod = KlassKurs.Kurskod
			   GROUP BY  Kurs.namn;
               
--- Lösning
SELECT Kurs.namn, COUNT(Kurskod) AS Antal FROM KlassKurs
INNER JOIN Kurs  ON KlassKurs.KursKod = Kurs.Kod
group by Kurskod, Kurs.namn;


SELECT * FROM Lärare;

-- Uppgift 2.

SELECT Avdelning.namn AS Avdelning, MAX(Lärare.lön) AS Lön, AVG (Lärare.lön) AS Medellön FROM Lärare
	INNER JOIN Avdelning on Avdelning.Avdelningsnummer = Lärare.Avdelningsnummer
		-- where AVG(Lärare.löm) > 10000
		group by Avdelning.namn;
        
-- Uppgift 3. 
-- SET SQL_SAFE_UPDATES=0;

SELECT Elev.Förnamn, Elev.Efternamn, Elev.Ort  FROM elev
where Elev.Ort = 'Uppsala' 
UNION
Select Lärare.Förnamn, Lärare.Efternamn, Lärare.Ort  from Lärare
where Lärare.Ort = 'Uppsala';


-- Uppgift 4
SELECT Förnamn, Efternamn, Kurs.namn AS Kurs FROM Lärare
inner join Undervisar on Lärare.Anställningsnummer=Undervisar.anställningsnummer
inner join Kurs on undervisar.Kurskod=kurs.Kod;

-- lösning
SELECT Lärare.Efternamn, Lärare.Förnamn, undervisar.Kurskod from Lärare
	LEFT JOIN Undervisar ON Lärare.Anställningsnummer = undervisar.Anställningsnummer;
    
    
update  Kurs
set kurs.namn = 'CSharpprogrammering'
where kurs.namn = 'Csharpprogrammering'

