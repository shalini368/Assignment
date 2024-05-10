CREATE DATABASE ORG;
USE ORG;
CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
Name VARCHAR(255),
Email VARCHAR(255),
JoinDate DATE
);
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
Name VARCHAR(255),
Category VARCHAR(255),
Price DECIMAL(10,2)
);
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
TotalAmount DECIMAL(10, 2),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE OrderDetails (
OrderDetailID INT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
PricePerUnit DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (CustomerID, Name, Email, JoinDate) VALUES
(1, 'John Doe', 'johndoe@example.com', '2020-01-10'),
(2, 'Jane Smith', 'janesmith@example.com', '2020-01-15'),
(3, 'sawn Joe',  'sawnJoe@example.com', '2020-02-14'),
(4, 'Nixie Klie',  'Nixieklie@example.com', '2020-02-26'),
(5, 'Angela Garn',  'Angelagarn@example.com', '2020-03-04'),
(6, 'Harry Jack',  'Harryjack@example.com', '2020-03-20'),
(7, 'Olivia Ethan',  'Oliviaethan@example.com', '2020-04-22'),
(8, 'Paul Leo',  'Paulleo@example.com', '2020-04-06'),
(9, 'Henry James',  'Henryjames@example.com', '2020-05-28'),
(10, 'Alice Johnson', 'alicejohnson@example.com', '2020-03-05');
#SAMPLE DATA
INSERT INTO Products (ProductID, Name, Category, Price) VALUES
(10, 'Laptop', 'Electronics', 999.99),
(20, 'Smartphone', 'Electronics', 499.99),
(30, 'Showpieces', 'Home Decor', 69.99),
(40, 'Beverages', 'Grocery', 149.9),
(50, 'Recliners', 'Furniture', 399.99),
(60, 'Wardrobe', 'Furniture', 199.99),
(70, 'Hair care', 'Beauty', 49.99),
(80, 'Jeans', 'Fashion', 59.99),
(90, 'Dresses', 'Fashion', 99.99),
(100, 'Desk Lamp', 'Home Decor', 29.99);	

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(001, 1, '2020-02-15', 1499.98),
(002, 2, '2020-02-17', 499.99),
(003, 3, '2020-03-14', 1999.99),
(004, 4, '2020-04-06', 89.69),
(005, 5, '2020-05-20', 2599.49),
(006, 6, '2020-05-04', 3499.99),
(007, 7, '2020-03-14', 899.99),
(008, 8, '2020-04-28', 1569.99),
(009, 9, '2020-05-22', 349.99),
(0010, 10, '2020-03-21', 78.99);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity,
PricePerUnit) VALUES
(1, 001, 10, 1, 999.99),
(2, 002, 20, 4, 499.99),
(3, 003, 30, 1, .99),
(4, 004, 40, 2, 149.9),
(5, 005, 50, 10, 399.99),
(6, 006, 60, 8, 199.99),
(7, 007, 70, 6, 49.99),
(8, 008, 80, 4, 59.99),
(9, 009, 90, 4, 99.99),
(10,0010,100, 2, 29.99);


/* Basic Questions */
/* 1.1
Select* from customers;

/*1.2
SELECT * FROM Products WHERE Category = 'Electronics';

/*1.3
SELECT COUNT(*) AS TotalOrders FROM Orders;

/*1.4
SELECT * FROM Orders ORDER BY OrderDate DESC LIMIT 1;

/*2. Joins and Relationships: */
/*2.1
SELECT p.*, c.Name AS CustomerName
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID;

/*2.2
SELECT OrderID, COUNT(*) AS NumberOfProducts
FROM OrderDetails
GROUP BY OrderID
HAVING COUNT(*) > 1;

/*2.3
SELECT c.CustomerID, c.Name AS CustomerName, SUM(od.Quantity * od.PricePerUnit) AS TotalSalesAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.Name;

/*3. Aggregation and Grouping:*/
/*3.1
SELECT Category, SUM(od.Quantity * od.PricePerUnit) AS TotalRevenue
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY Category;

/*3.2
SELECT AVG(TotalAmount) AS AverageOrderValue
FROM Orders;

/*3.3
SELECT MONTH(OrderDate) AS Month, COUNT(*) AS NumberOfOrders
FROM Orders
GROUP BY MONTH(OrderDate)
ORDER BY NumberOfOrders DESC
LIMIT 1;

/*4.Subqueries and Nested Queries:*/
/*4.1
SELECT CustomerID, Name
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

/*4.2
SELECT ProductID, Name
FROM Products
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM OrderDetails);

/*4.3
SELECT p.ProductID, p.Name AS ProductName, p.Category, SUM(od.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.Name, p.Category
ORDER BY TotalQuantitySold DESC
LIMIT 3;

/*5. Date and Time Functions:*/
/*5.1
SELECT *
FROM Orders
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

/*5.2
SELECT CustomerID, Name, JoinDate
FROM Customers
ORDER BY JoinDate
LIMIT 1;

/*6. Advanced Queries:*/
/*6.1
SELECT CustomerID, Name, SUM(TotalAmount) AS TotalSpending
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY CustomerID, Name
ORDER BY TotalSpending DESC;

/*6.2
SELECT Category, COUNT(*) AS TotalOrders
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Category
ORDER BY TotalOrders DESC
LIMIT 1;

/*6.3
SELECT
    MONTH(OrderDate) AS Month,
    YEAR(OrderDate) AS Year,
    SUM(TotalAmount) AS TotalSalesAmount,
    (SUM(TotalAmount) - LAG(SUM(TotalAmount)) OVER (ORDER BY YEAR(OrderDate), MONTH(OrderDate))) / LAG(SUM(TotalAmount)) OVER (ORDER BY YEAR(OrderDate), MONTH(OrderDate)) AS GrowthRate
FROM
    Orders
GROUP BY
    YEAR(OrderDate),
    MONTH(OrderDate)
ORDER BY
    YEAR(OrderDate),
    MONTH(OrderDate);

/*7. Data Manipulation and Updates:*/
/*7.1
INSERT INTO Customers (CustomerID, Name, Email, JoinDate)
VALUES (11, 'Annie Beasant', 'AnnieBeasant@example.com','2020-05-19' );

/*7.2
UPDATE Products
SET Price = 799.99
WHERE ProductID = 10;





















