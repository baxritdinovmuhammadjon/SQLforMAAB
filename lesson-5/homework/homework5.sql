CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE Products_Discounted (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    StockQuantity INT
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Salary DECIMAL(10,2),
    Department VARCHAR(100)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    SaleAmount DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT
);

SELECT ProductName AS Name FROM Products;

SELECT * FROM Customers AS Client;

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;

SELECT DISTINCT CustomerName, Country FROM Customers;

SELECT ProductName, Price,
    CASE
        WHEN Price > 1000 THEN 'High'
        ELSE 'Low'
    END AS PriceCategory
FROM Products;

SELECT ProductName, StockQuantity,
    IIF(StockQuantity > 100, 'Yes', 'No') AS StockOver100
FROM Products_Discounted;

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;

SELECT ProductName, Price,
    IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceLabel
FROM Products;

SELECT * FROM Employees
WHERE Age < 25 OR Salary > 60000;

UPDATE Employees
SET Salary = Salary * 1.1
WHERE Department = 'HR' OR EmployeeID = 5;

SELECT SaleID, SaleAmount,
    CASE
        WHEN SaleAmount > 500 THEN 'Top Tier'
        WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
        ELSE 'Low Tier'
    END AS SaleCategory
FROM Sales;

SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Sales;

SELECT CustomerID, Quantity,
    CASE
        WHEN Quantity = 1 THEN '3%'
        WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
        ELSE '7%'
    END AS DiscountPercentage
FROM Orders;
