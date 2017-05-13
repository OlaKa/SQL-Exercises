
-- Fråga 1
SELECT 
    COUNT(produkt.Namn) AS ANTAL, kategori.Namn AS KategoriNamn
FROM
    Produkt
        INNER JOIN
    ProduktKategorier ON ProduktKategorier.ProduktID = produkt.ProduktID
        INNER JOIN
    Kategori ON kategori.KategoriID = produktkategorier.KategoriID
GROUP BY kategori.Namn
ORDER BY ANTAL DESC;

-- Fråga 2

SELECT 
    Kund.Förnamn,
    Kund.Efternamn,
    SUM(produkt.Pris*orderdetaljer.Antal) AS ProduktPris
FROM
    Kund
        INNER JOIN
    Orders ON Orders.KundID = Kund.KundID
        INNER JOIN
    orderdetaljer ON orderdetaljer.OrderID = orders.OrderID
        INNER JOIN
    produkt ON produkt.ProduktID = orderdetaljer.ProduktID
GROUP BY Kund.KundID;

-- Fråga 3
SELECT 
    Kund.Förnamn, Kund.Efternamn AS Namn
FROM
    Kund
        INNER JOIN
    Orders ON Orders.KundID = Kund.KundID
        INNER JOIN
    orderdetaljer ON orderdetaljer.OrderID = orders.OrderID
        INNER JOIN
    produkt ON produkt.ProduktID = orderdetaljer.ProduktID
        INNER JOIN
	varianter ON produkt.ProduktID = varianter.ProduktID
		AND
	varianter.FärgID = orderdetaljer.Färg
		AND    
	varianter.StorlekID = orderdetaljer.Storlek
		INNER JOIN 
	Färg ON Varianter.FärgID = Färg.FärgID
		INNER JOIN 
	Storlek ON Varianter.StorlekID = Storlek.StorlekID
    where färg.Färg = 'Blå' and storlek.Storlek = '32' and produkt.Namn = 'Nudie Jeans';

-- Kommentar: Fredrik Lundström och Nils Thorwaldsson köpte också Nudie Jeans men i storlek 46 och färg svart

-- Fråga 4
SELECT 
    Kund.Förnamn,
    Kund.Efternamn,
    Kund.Ort,
    SUM(produkt.Pris*orderdetaljer.Antal) AS OrderVärde
FROM
    Kund
        INNER JOIN
    Orders ON Orders.KundID = Kund.KundID
        INNER JOIN
    orderdetaljer ON orderdetaljer.OrderID = orders.OrderID
        INNER JOIN
    produkt ON produkt.ProduktID = orderdetaljer.ProduktID
GROUP BY Kund.KundID
HAVING SUM(produkt.Pris*orderdetaljer.Antal) > 1000;


-- Fråga 5

SELECT  produkt.Namn, SUM(orderdetaljer.antal) AS MestSålt FROM Orders
Inner Join orderdetaljer ON Orders.OrderID = orderdetaljer.OrderID
inner Join produkt ON orderdetaljer.ProduktID = produkt.ProduktID
GROUP BY produkt.Namn 
ORDER BY MestSålt DESC LIMIT 5; 

-- Fråga 6
SELECT monthname(Orders.OrderDatum) AS Månad, SUM(Produkt.Pris) AS SåltPerMånadKronor FROM Orders
INNER JOIN OrderDetaljer ON Orders.OrderID = orderdetaljer.OrderID
INNER JOIN produkt ON produkt.ProduktID = orderdetaljer.ProduktID
GROUP BY Orders.OrderDatum 
ORDER BY SUM(Produkt.Pris) DESC limit 1;
