Use Webbutik;

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
SELECT monthname(Orders.OrderDatum) AS Månad, SUM(Produkt.Pris*OrderDetaljer.Antal) AS SåltPerMånadKronor FROM Orders
INNER JOIN OrderDetaljer ON Orders.OrderID = orderdetaljer.OrderID
INNER JOIN produkt ON produkt.ProduktID = orderdetaljer.ProduktID
GROUP BY Orders.OrderDatum 
ORDER BY SUM(Produkt.Pris) DESC limit 1;



-- ///////Procedurer triggers mm /////////////////////


-- Övning 1

DELIMITER //
CREATE PROCEDURE LäggTillKundvagn(KundID INT, ProduktID CHAR(10),OrderID INT)
BEGIN
  
    DECLARE EXIT HANDLER FOR 1216 
		BEGIN
		ROLLBACK;
    END;
    
    DECLARE EXIT HANDLER FOR 1062 
		BEGIN
		ROLLBACK;
	END;
  
	START TRANSACTION;
	
	-- if no order exists
	IF(OrderID IS NULL) THEN
        INSERT INTO Orders (KundID,OrderDatum) VALUES(KundID,current_date());
        INSERT INTO OrderDetaljer (ProduktID,OrderID,Antal,Storlek,Färg) VALUES (ProduktID,(SELECT last_insert_id()),1,5,2);
		UPDATE Varianter SET Antal = (Antal -1) WHERE Varianter.ProduktID = ProduktID and
        varianter.StorlekID = (SELECT orderdetaljer.Storlek FROM orderdetaljer WHERE orderdetaljer.ProduktID = ProduktID 
        and orderdetaljer.OrderID =(SELECT last_insert_id()));
	ELSE
		IF EXISTS (SELECT * FROM OrderDetaljer WHERE OrderDetaljer.OrderID = OrderID AND OrderDetaljer.ProduktID = ProduktID) THEN
			UPDATE OrderDetaljer SET OrderDetaljer.Antal=Antal+1 WHERE OrderDetaljer.OrderID = OrderID AND OrderDetaljer.ProduktID = ProduktID;
		ELSE
			INSERT INTO OrderDetaljer(ProduktID,OrderID,Antal,Storlek,Färg) VALUES (ProduktID,OrderID,1,5,2);
		END IF;
	END IF;
    
	IF (OrderID IS NOT NULL) THEN
       UPDATE Varianter SET Antal = (Antal -1) WHERE Varianter.ProduktID = ProduktID and
		varianter.StorlekID = (SELECT orderdetaljer.Storlek FROM orderdetaljer WHERE orderdetaljer.ProduktID = ProduktID
		and orderdetaljer.OrderID = OrderID) and Varianter.FärgID = (SELECT orderdetaljer.färg FROM orderdetaljer WHERE orderdetaljer.ProduktID = ProduktID 
		and orderdetaljer.OrderID = OrderID);
	END IF;

	COMMIT;
END //
DELIMITER ;

-- CALL LäggTillKundvagn(1,'Produkt1',null);
-- SELECT * FROM  Orders;
-- SELECT * FROM Varianter;
-- SELECT * FROM orderdetaljer;

-- Uppgift 2
-- DROP PROCEDURE TopProducts;

DELIMITER //
CREATE PROCEDURE TopProducts(StartDatum DATE,SlutDatum DATE, Antal tinyint)
BEGIN

SELECT produkt.Namn, SUM(orderdetaljer.Antal) AS TopAntal FROM Orders
Inner Join orderdetaljer ON Orders.OrderID = orderdetaljer.OrderID
inner Join produkt ON orderdetaljer.ProduktID = produkt.ProduktID
WHERE Orders.OrderDatum BETWEEN StartDatum and Slutdatum
GROUP BY produkt.Namn
ORDER BY SUM(orderdetaljer.Antal) DESC LIMIT Antal; 

END //
DELIMITER ;

-- CALL TopProducts('2016-01-01','2016-03-28',3)

-- Uppgift 3

DELIMITER $$
CREATE TRIGGER SlutILager AFTER UPDATE ON Varianter
FOR EACH ROW 
BEGIN
IF (NEW.Antal = 0) THEN

INSERT INTO SlutILager(ProduktID,StorlekID,FärgID, Datum)
		VALUES(OLD.ProduktID,OLD.StorlekID,OLD.FärgID,current_date());

END IF;	
    

END $$

DELIMITER ;

-- UPDATE Varianter SET Antal = 0 WHERE Varianter.ProduktID = 'Produkt1' and Varianter.StorlekID = 1 and Varianter.FärgID = 1;
-- SELECT * FROM SlutILager
-- SeLECT * FROM Varianter
-- DROP TRIGGER SlutILager
-- show triggers