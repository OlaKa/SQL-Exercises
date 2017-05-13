Use Northwind;

-- Övn. 2
select ContactName, Address, PostalCode From Customers 
LIMIT 5;

-- övn 3
select ContactName, Address, PostalCode From Customers 
where Customers.City = 'London';

-- övn 4
select ContactName, Address, PostalCode From Customers 
where Customers.ContactName = 'John Steel';

-- övn 5
select distinct City From Customers 
order by City;

-- övn 6
select ContactName, Address,PostalCode, CompanyName From Customers 
order by PostalCode ASC;

-- övn 7
select ContactName, Address,PostalCode, CompanyName From Customers 
order by PostalCode DESC;

-- övn 8
select ContactName, Address, PostalCode, CompanyName, Region From Customers 
where Region = 'WA' and PostalCode > 1010;

-- övn 9
select City, Address, PostalCode, CompanyName, Region From Customers 
where City = 'Paris' or City = 'London';

-- övn 10
select count(*) FROM Customers;

-- övn 11
select City, Address, PostalCode, CompanyName, Region From Customers 
where Region is null;

-- övn 12

SELECT City, CompanyName, ContactName from Customers
where CompanyName != 'Ernst Handel'
order by CompanyName;

-- övn 13
SELECT City, CompanyName, ContactName, Region from Customers
where Region = 'BC' or Region = 'SP' or Region= 'WA' or Region = 'CA';

-- övn 14

select LastName, FirstName, A.Country from Employees A
INNER JOIN(SELECT Country, COUNT(*) AS Antal FROM Employees) B
where A.Country = 'UK' group by Country;

SELECT Country, COUNT(*) AS Antal FROM Employees
GROUP by Country;

-- övn 15
SELECT City, CompanyName, ContactName, Region from Customers
where (CompanyName = 'Island Trading' and Region = 'Isle of Wight') OR
(CompanyName = 'White Clover Markets' and Region = 'WA');

-- Övn 16
INSERT INTO Customers(CompanyName,Address,PostalCode,Region,ContactName,CustomerID)
VALUES('Nackademin','Tomtebodavägen 3A',
17156,'Solna', 'Per Svensson','NACK');

-- övn 17
INSERT INTO Customers(CompanyName,Address,PostalCode,Region,ContactName,CustomerID)
VALUES('BR Leksaker','Barkarby Handelsplats',
17738,'Järfälla', 'Anna Persson','BRLE');

-- övn 18
INSERT INTO Customers(CompanyName,Address,Region,ContactName,CustomerID)
VALUES('Elgiganten','Kungens Kurva','Kungens Kurva', 'Malin Lundkvist','ELGI');

-- övn 19
INSERT INTO Customers(Address,Region,ContactName,CustomerID)
VALUES('Kungens Kurva','Kungens Kurva', 'Malin Lundkvist','ELGI');

-- CompanyName does not have a default value

-- övn 20

Create table sporthall(
Customers varchar(50),
Tracks int,
Bookings varchar (50)
);

-- övn 21
UPDATE Customers
SET ContactTitle= 'Program Manager'
where CompanyName='Nackademin';

-- SELECT * FROM Customers
-- where CompanyName='Nackademin';

-- övn 22
UPDATE Customers
SET Region='SO'
where CompanyName='BR Leksaker';

-- övn 23
UPDATE Customers
SET PostalCode= 14175 and Region ='KU'
where CompanyName='Elgiganten';

-- övn 24
UPDATE Customers
SET Country= 'Sweden'
where CompanyName='Elgiganten' OR CompanyName='Nackademin' OR CompanyName='BR Leksaker';

-- övn 25
DELETE FROM Customers
where CustomerID='ELGI';

-- övn 26

DELETE FROM Customers
where City='Järfälla';

-- övn 27

-- övn 28
SELECT * FROM Customers
where Region is null;

-- övn 29
SELECT * FROM Customers
where Region is not null or Region='';

-- övn 30
SELECT CompanyName, City, coalesce(Region, 'No Region') AS Region FROM Customers;

-- select ifnull(Region,"No Region") As Region from Customers

-- övn 31
select concat(PostalCode,' ', Region) AS Postadress from Customers;

-- övn 32
SELECT * FROM Products
where UnitsInStock = 0;

-- övn 33
SELECT * FROM Customers
where ContactName LIKE 'J%';
-- övn 34
SELECT * FROM Customers
where CompanyName LIKE '%Market%';

-- övn 35
select * from Customers 
where Address like '%blvd.';

-- övn 36
select CompanyName, City from Customers
where City = 'Berlin' OR City = 'Madrid' OR City = 'Paris';

-- övn 37
select CustomeriD,DATE(OrderDate) AS OrderMånad FROM Orders; 
-- INNER JOIN(SELECT  DATE(OrderDate) AS OrderMånad FROM Orders) B

-- övn 38

select CompanyName,concat(Country,' ',Region) AS Landregion from Suppliers
WHERE CompanyName LIKE '%l%';

-- övn 48
SELECT *
FROM Orders 
WHERE OrderDate <= NOW();

-- övn 49
SELECT *
FROM orders
WHERE YEAR(OrderDate) = '1996';

-- övn 50
SELECT * FROM orders WHERE OrderDate < NOW();

-- övn 51

SELECT * FROM orders WHERE MONTH(OrderDate) = 2 AND YEAR(OrderDate) = '1996';
select * from orders 
  where OrderDate between '1996-02-01' and '1996-02-28';
  
-- övn 52
SELECT * FROM orders WHERE DAY(OrderDate) = 20;
  
-- övn 53

