-- Define and explain the purpose of BULK INSERT in SQL Server
-- BULK INSERT is a T-SQL command used to efficiently load large volumes of data
-- from external files (such as .csv, .txt) directly into a SQL Server table.
-- It is useful for high-performance data import operations.

-- List four file formats that can be imported into SQL Server
-- 1. .csv - Comma-separated values
-- 2. .txt - Plain text files with custom delimiters
-- 3. .xml - Used with XML data types or OPENXML
-- 4. .json - Supported in SQL Server 2016+ via OPENJSON

-- Create the Products table with primary key on ProductID
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

-- Insert three records into the Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (1, 'Laptop', 1200.00),
       (2, 'Mouse', 25.50),
       (3, 'Keyboard', 45.99);

-- Add UNIQUE constraint to ensure ProductName values are unique
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

-- Select products with price greater than 50
SELECT * FROM Products WHERE Price > 50;

-- Create the Categories table with PRIMARY KEY and UNIQUE constraint
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

-- Use BULK INSERT to import data into Products from a text file
BULK INSERT Products
FROM 'C:\\data\\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

-- Add CategoryID column to Products table
ALTER TABLE Products
ADD CategoryID INT;

-- Add FOREIGN KEY constraint to CategoryID referencing Categories table
ALTER TABLE Products
ADD CONSTRAINT FK_Category
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

-- Add CHECK constraint to ensure Price is greater than 0
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

-- Add Stock column with NOT NULL and default value 0
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

-- Use ISNULL to replace NULL values in Price with 0
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

-- Create Customers table with CHECK constraint to ensure Age >= 18
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT CHECK (Age >= 18)
);

-- Create Invoices table with IDENTITY column starting at 100, incrementing by 10
CREATE TABLE Invoices (
    InvoiceID INT IDENTITY(100, 10) PRIMARY KEY,
    InvoiceAmount DECIMAL(10, 2)
);

-- Create OrderDetails table with a composite PRIMARY KEY
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

-- Create Departments table with DeptID as PRIMARY KEY
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

-- Create Employees table with FOREIGN KEY referencing Departments
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    DeptID INT,
    Email VARCHAR(100) UNIQUE,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
    ON DELETE CASCADE -- Ensures that when a department is deleted, employees in that department are also deleted.
    ON UPDATE CASCADE -- Ensures that if the DeptID is updated in Departments, it reflects in Employees.
);

