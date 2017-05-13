UPDATE Varianter SET Antal = (Antal -1) WHERE Varianter.ProduktID = 'Produkt5' and
varianter.StorlekID = (SELECT orderdetaljer.Storlek FROM orderdetaljer WHERE orderdetaljer.ProduktID = 'Produkt5'
and orderdetaljer.OrderID = 8) and Varianter.FärgID = (SELECT orderdetaljer.färg FROM orderdetaljer WHERE orderdetaljer.ProduktID = 'Produkt5'
and orderdetaljer.OrderID = 8);


DROP PROCEDURE LäggTillKundvagn;
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



select * from varianter