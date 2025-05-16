CREATE TABLE Employees (
    EmployeeID INT,
    Name VARCHAR(100),
    Age INT,
    Salary DECIMAL(10,2),
    DepartmentName VARCHAR(100)
);

INSERT INTO Employees VALUES 
(1, 'Alice', 30, 60000, 'HR'),
(2, 'Bob', 45, 75000, 'IT'),
(3, 'Charlie', 25, 50000, 'IT'),
(4, 'David', 35, 80000, 'Finance'),
(5, 'Eva', 29, 62000, 'HR'),
(6, 'Frank', 50, 90000, 'Finance'),
(7, 'Grace', 28, 55000, 'IT'),
(8, 'Hannah', 32, 70000, 'Finance'),
(9, 'Ian', 41, 67000, 'HR'),
(10, 'Jane', 26, 48000, 'Marketing');

CREATE TABLE Products (
    ProductID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Category VARCHAR(100)
);

INSERT INTO Products VALUES
(1, 'Laptop', 1200.00, 'Electronics'),
(2, 'Mouse', 25.00, 'Electronics'),
(3, 'Keyboard', 45.00, 'Electronics'),
(4, 'Desk', 300.00, 'Furniture'),
(5, 'Chair', 150.00, 'Furniture'),
(6, 'Notebook', 5.00, 'Stationery'),
(7, 'Pen', 2.00, 'Stationery');

CREATE TABLE Sales (
    SaleID INT,
    CustomerID INT,
    ProductID INT,
    Amount DECIMAL(10,2),
    SaleDate DATE
);

INSERT INTO Sales VALUES
(1, 101, 1, 1200.00, '2024-01-10'),
(2, 102, 2, 25.00, '2024-01-11'),
(3, 103, 3, 45.00, '2024-01-12'),
(4, 101, 4, 300.00, '2024-01-13'),
(5, 104, 5, 150.00, '2024-01-14'),
(6, 102, 6, 5.00, '2024-01-15'),
(7, 105, 7, 2.00, '2024-01-16'),
(8, 101, 2, 25.00, '2024-01-17'),
(9, 103, 1, 1200.00, '2024-01-18'),
(10, 106, 3, 45.00, '2024-01-19');

CREATE TABLE Customers (
    CustomerID INT,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Country VARCHAR(100)
);

INSERT INTO Customers VALUES
(101, 'ABC Corp', 'John Doe', 'USA'),
(102, 'XYZ Ltd', 'Jane Smith', 'UK'),
(103, 'Acme Inc', 'Robert Brown', 'Canada'),
(104, 'Global LLC', 'Emily Davis', 'USA'),
(105, 'Tech Solutions', 'Michael Johnson', 'Germany'),
(106, 'Bright Future', 'Laura Wilson', 'Australia');

SELECT MIN(Price) AS MinPrice
FROM Products;

SELECT MAX(Salary) AS MaxSalary
FROM Employees;

SELECT COUNT(*) AS TotalCustomers
FROM Customers;

SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;

SELECT SUM(Amount) AS TotalSales
FROM Sales
WHERE ProductID = 7;

SELECT AVG(Age) AS AverageAge
FROM Employees;

SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

SELECT CustomerID, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

SELECT DepartmentName
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;
