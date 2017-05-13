use Skola;

-- Printa ut klassnamn också
SELECT 
    Personnummer, Efternamn, Förnamn, Klass.namn AS Klassnamn
FROM
    Elev
        INNER JOIN
    Klass ON Elev.klasskod = Klass.kod
WHERE
    Klass.namn = 'JAVA16'
ORDER BY Klass.namn;

-- List alla elever som har fått betyg VG i kursen Databasteknik

SELECT 
    Personnummer, Efternamn, Förnamn, KursBetyg.betyg
FROM
    Elev
        INNER JOIN
    KursBetyg ON Elev.Personnummer = KursBetyg.Personnummer;
-- //////////////////////////////////////////////////////
SELECT 
    Elev.Personnummer, Elev.Förnamn, elev.Efternamn
FROM
    Elev
        INNER JOIN
    kursbetyg ON Elev.Personnummer = kursbetyg.Personnummer
        INNER JOIN
    Kurs ON kursbetyg.Kurskod = Kurs.kod
WHERE
    kursbetyg.betyg = 'VG'
        AND Kurs.namn = 'Javaprogrammering';

-- //////////////////////////////////////////////////////

SELECT 
    Elev.Personnummer, Elev.Förnamn, elev.Efternamn
FROM
    Elev
        INNER JOIN
    kursbetyg ON Elev.Personnummer = kursbetyg.Personnummer
        INNER JOIN
    Kurs ON kursbetyg.Kurskod = Kurs.kod
WHERE
    kursbetyg.betyg = 'VG'
        AND Kurs.namn = 'Javaprogrammering';

-- ////Implicit JOIN///////////////
SELECT 
    Personnummer, Efternamn, Förnamn, Klass.namn AS Klassnamn
FROM
    Elev,
    Klass
WHERE
    Elev.Klasskod = Klass.kod
        AND Klass.Namn = 'JAVA16';


ALTER table KursBetyg add Betyg char(2);

SELECT 
    *
FROM
    KursBetyg;
SELECT 
    *
FROM
    Klass;
-- Övning 1. 
SELECT 
    Personnummer, Förnamn, Efternamn, Klass.Namn AS Klassnamn
FROM
    Elev
        INNER JOIN
    Klass ON Elev.Klasskod = Klass.Kod
ORDER BY Klass.Namn, Elev.efternamn;

-- Övning 2.

SELECT Förnamn, Efternamn, Epost, Avdelning.Namn 
	FROM Lärare
		INNER JOIN 
        Avdelning  ON Lärare.Avdelningsnummer = avdelning.Avdelningsnummer;

-- Övning 3

UPDATE Klass
    SET Årskurs = 2015
    WHERE Kod = 'E16' ;
    
SELECT * FROM KursLokal;



SELECT Klass.Namn AS Klassnamn, kurslokal.Datum, KursLokal.tid AS Tid, Lokal.Namn AS Lokalnamn FROM Klass
	INNER JOIN KlassKurs ON KlassKurs.Klasskod = Klass.Kod 
		INNER JOIN Kurs ON Kurs.Kod = KlassKurs.Kurskod
			INNER JOIN KursLokal ON KursLokal.Kurskod=Kurs.kod
				INNER JOIN Lokal ON Lokal.Lokalnummer=KursLokal.Lokalnummer
					WHERE KlassKurs.Klasskod = 'J16'
						ORDER BY KursLokal.Datum, KursLokal.Tid;
						


-- Övning 4
select Lokal.Namn, KursLokal.datum AS Datum,Kurslokal.Tid FROM Lokal,KursLokal
	where kurslokal.datum BETWEEN '2017-02-28' 
    and '2017-05-04' and KursLokal.tid >='09:00' and Kurslokal.tid < '12:00';

-- Övning 5
Select	Namn, Poäng,kursbetyg.betyg FROM Kurs,kursbetyg
	where Kurs.Kod = kursbetyg.Kurskod and;
    
-- Övning 6
Select DISTINCT Elev.Personnummer, Elev.Förnamn,Elev.Efternamn, kursbetyg.Betyg FROM Elev
		Inner join kursbetyg on  Elev.Personnummer = kursbetyg.Personnummer and
			kursbetyg.Betyg = 'VG';

-- SELECT * FROM KursLokal;
SELECT Datum,Tid,Lokal.namn AS Sal FROM KursLokal
	inner JOIN Lokal ON Lokal.Lokalnummer = Kurslokal.Lokalnummer;

-- Alla elever som går java16

SELECT * FROM Elev 
	WHERE Elev.klasskod = (SELECT Kod from Klass WHERE Namn= 'JAVA16');

-- Åk 2015 lista kan lista NOT för negation 
SELECT * FROM Elev 
	WHERE Elev.klasskod = (SELECT Kod from Klass WHERE Årskurs= 2015);