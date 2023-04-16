IF EXISTS(SELECT * FROM sys.databases WHERE name = 'GuitarShopDB')
  DROP DATABASE GuitarShopDB
GO
 CREATE DATABASE GuitarShopDB
GO
USE GuitarShopDB
CREATE TABLE Categories(
   CategoryID INT PRIMARY KEY IDENTITY(1,1),
   CategoryName varchar(50) NOT NULL UNIQUE
  )
CREATE TABLE Products(
   ProductID INT PRIMARY KEY IDENTITY(1,1),
   CategoryID INT,
   ProductCode nvarchar(10) NOT NULL UNIQUE,
   ProductName varchar(50) NOT NULL,
   Description varchar(500),
   DateAdded date
   FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
  )
CREATE TABLE Customers(
   CustomerID INT PRIMARY KEY IDENTITY(1,1),
   Email nvarchar(50) NOT NULL UNIQUE,
   Password varchar(50) NOT NULL,
   FirstName nvarchar(50) NOT NULL,
   LastName nvarchar(50) NOT NULL,
   Address nvarchar(100) NOT NULL,
   IsPasswordChanged bit DEFAULT 'false'
  )
CREATE TABLE Orders(
   OrderID INT PRIMARY KEY IDENTITY(1,1),
   CustomerID INT,
   OrderDate date NOT NULL,
   ShipAddress nvarchar(100),
   FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
  )
CREATE TABLE OrderItems(
   OrderID INT,
   ProductID INT,
   Quantity smallint NOT NULL, 
   CHECK (Quantity > 0),
   UnitPrice money,
   DiscountPercent decimal(4,2),
   CHECK(DiscountPercent >= 0 AND DiscountPercent <= 75),
   FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
   FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
  )
GO

INSERT INTO Categories VALUES('Acoustic Guitars')
INSERT INTO Categories VALUES('Electric Guitars')
INSERT INTO Categories VALUES('Bass Guitars')
INSERT INTO Categories VALUES('Electro-acoustic Guitar')

INSERT INTO Products VALUES(2,'ES-335','Gibson Les Paul','Electric Guitars','2019-06-03')
INSERT INTO Products VALUES(2,'ES-336','Fender Mustang','Electric Guitars','2021-02-15')
INSERT INTO Products VALUES(1,'ES-337','Martin D-28','Acoustic Guitars','2021-09-29')
INSERT INTO Products VALUES(1,'ES-338','Taylor Dreadnought','Acoustic Guitars','2022-04-01')
INSERT INTO Products VALUES(2,'ES-339','Gibson Hummingbird','Electric Guitars','2018-03-02')
INSERT INTO Products VALUES(1,'ES-340','Martin D-35','Electric Guitars','2022-06-03')
INSERT INTO Products VALUES(3,'ES-341','Fender Jazz','Bass Guitars','2019-01-01')
INSERT INTO Products VALUES(3,'ES-342','Fender Precision','Bass Guitars','2022-02-08')
INSERT INTO Products VALUES(4,'ES-343','Martin Junior Series DJR-10E','Electro-acoustic Guitar','2020-08-20')
INSERT INTO Products VALUES(4,'ES-344','Taylor American Dream AD17E Blacktop','Electro-acoustic Guitar','2020-12-10')

INSERT INTO Customers VALUES('rick@raven.com','abc123','rick','raven','23 nguyen van qua, go vap','true')
INSERT INTO Customers VALUES('tu@gmail.com','abc123','tu','tran','19 dang van bi, tp thu duc','true')
INSERT INTO Customers VALUES('phuong@gmail.com','abc123','phuong','nguyen','113 kha van can, tp thu duc','true')
INSERT INTO Customers VALUES('tan@gmail.com','abc123','tan','ho','115 le van viet, tp thu duc','true')
INSERT INTO Customers VALUES('huy@gmail.com','abc123','huy','duong','1 le duan, quan 1','true')
INSERT INTO Customers VALUES('nguyen@gmail.com','abc123','nguyen','tran','100 D3, tp thu duc','true')
INSERT INTO Customers VALUES('hung@gmail.com','abc123','hung','vu','30 man thien, tp thu duc','true')
INSERT INTO Customers VALUES('minh@gmail.com','abc123','minh','nguyen','200 ly thuong kiet, quan 10','true')
INSERT INTO Customers VALUES('bac@gmail.com','abc123','bac','duong','300 pham van dong, tp thu duc','true')
INSERT INTO Customers VALUES('thoai@gmail.com','abc123','thoai','ho','99 duong so 7, quan 7','true')
INSERT INTO Customers VALUES('vinh@gmail.com','abc123','vinh','duong','25 huynh tan phat, quan 7 ','true')

INSERT INTO Orders VALUES(1,'2022-02-20','23 nguyen van qua, go vap')
INSERT INTO Orders VALUES(2,'2020-08-04','19 dang van bi, tp thu duc')
INSERT INTO Orders VALUES(3,'2021-11-10','113 kha van can, tp thu duc')
INSERT INTO Orders VALUES(4,'2022-12-24','115 le van viet, tp thu duc')
INSERT INTO Orders VALUES(5,'2021-10-23','1 le duan, quan 1')
INSERT INTO Orders VALUES(6,'2021-10-18','100 D3, tp thu duc')
INSERT INTO Orders VALUES(7,'2021-04-02','30 man thien, tp thu duc')
INSERT INTO Orders VALUES(8,'2022-09-10','200 ly thuong kiet, quan 10')
INSERT INTO Orders VALUES(9,'2022-11-19','300 pham van dong, tp thu duc')
INSERT INTO Orders VALUES(10,'2020-10-10','99 duong so 7, quan 7')
INSERT INTO Orders VALUES(11,'2022-08-01','203 truong chinh, quan 12')
INSERT INTO Orders VALUES(8,'2022-09-10','200 ly thuong kiet, quan 10')
INSERT INTO Orders VALUES(9,'2022-11-19','300 pham van dong, tp thu duc')
INSERT INTO Orders VALUES(10,'2020-10-10','99 duong so 7, quan 7')
INSERT INTO Orders VALUES(11,'2022-08-01','203 truong chinh, quan 12')


INSERT INTO OrderItems VALUES(1,1,2,1000,10)
INSERT INTO OrderItems VALUES(2,1,3,1000,10)
INSERT INTO OrderItems VALUES(3,2,2,1500,10)
INSERT INTO OrderItems VALUES(4,2,4,1500,10)
INSERT INTO OrderItems VALUES(5,1,5,1000,10)
INSERT INTO OrderItems VALUES(6,3,7,600,10)
INSERT INTO OrderItems VALUES(7,3,9,600,10)
INSERT INTO OrderItems VALUES(8,4,10,900,10)
INSERT INTO OrderItems VALUES(9,4,17,900,10)
INSERT INTO OrderItems VALUES(10,3,20,600,10)
INSERT INTO OrderItems VALUES(6,3,3,600,10)
INSERT INTO OrderItems VALUES(7,3,10,600,10)
INSERT INTO OrderItems VALUES(8,4,12,900,10)
INSERT INTO OrderItems VALUES(9,4,1,900,10)
INSERT INTO OrderItems VALUES(11,3,2,600,10)


GO
/* B */
SELECT ProductCode, ProductName, Description, DateAdded
FROM Products

SELECT * FROM Products
WHERE DATEDIFF(month,DateAdded,GETDATE()) >= 12
ORDER BY DateAdded DESC

/* C */
UPDATE Customers
SET Password = 'Secret''@1234!', IsPasswordChanged = 'false'
WHERE Email = 'rick@raven.com'

/* D */
SELECT FullName
FROM
	(SELECT DISTINCT CONCAT(FirstName,',',' ',LastName) AS 'FullName',LastName
	 FROM Customers
	 WHERE LastName LIKE '[M-Z]%')t

ORDER BY LastName

/* E */
SELECT ProductName,DateAdded,UnitPrice FROM Products a
JOIN OrderItems b
ON a.ProductID = b.ProductID
WHERE UnitPrice > 500 AND UnitPrice < 2000
GROUP BY ProductName,DateAdded,UnitPrice
ORDER BY DateAdded DESC

/* F */
SELECT 
	a.CustomerID, FirstName, LastName, Email, Address,UnitPrice,
	FORMAT(SUM((Quantity * UnitPrice)*(1-DiscountPercent/100)),'N2') AS 'TotalPrice'
FROM Customers a
JOIN Orders b ON a.CustomerID = b.CustomerID
JOIN OrderItems c ON b.OrderID = c.OrderID
GROUP BY a.CustomerID, FirstName, LastName, Email, Address,UnitPrice
ORDER BY CustomerID
