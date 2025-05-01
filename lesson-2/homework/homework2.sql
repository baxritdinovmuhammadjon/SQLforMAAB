IF OBJECT_ID('Inventory_New', 'U') IS NOT NULL DROP TABLE Inventory_New;
IF OBJECT_ID('Inventory', 'U') IS NOT NULL DROP TABLE Inventory;
IF OBJECT_ID('Products_Backup', 'U') IS NOT NULL DROP TABLE Products_Backup;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('Departments', 'U') IS NOT NULL DROP TABLE Departments;
IF OBJECT_ID('StaffMembers', 'U') IS NOT NULL DROP TABLE StaffMembers;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;

-- ======================================
-- BASIC-LEVEL TASKS
-- ======================================

-- 1. Create Employees table
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 2. Insert 3 records using single and multi-row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'John Doe', 6000.00);

INSERT INTO Employees (EmpID, Name, Salary)
VALUES (2, 'Jane Smith', 4500.00),
       (3, 'Alice Johnson', 5000.00);

-- 3. Update Salary
UPDATE Employees SET Salary = 7000 WHERE EmpID = 1;

-- 4. Delete record where EmpID = 2
DELETE FROM Employees WHERE EmpID = 2;

-- 5. DELETE vs TRUNCATE vs DROP
-- (Not a query, but for understanding):
-- DELETE: removes rows (can use WHERE); keeps table structure and logs each row.
-- TRUNCATE: removes all rows fast without WHERE; keeps structure.
-- DROP: deletes the entire table, structure and data.

-- 6. Modify Name column to VARCHAR(100)
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

-- 7. Add Department column
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 8. Change Salary to FLOAT
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- 9. Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 10. Remove all records from Employees table
TRUNCATE TABLE Employees;

-- ======================================
-- INTERMEDIATE-LEVEL TASKS
-- ======================================

-- 11. Insert using INSERT INTO SELECT
-- (First, create some sample data using a temp table)
CREATE TABLE #TempDepartments (
    ID INT, Name VARCHAR(50)
);

INSERT INTO #TempDepartments VALUES
(1, 'HR'), (2, 'IT'), (3, 'Finance'), (4, 'Sales'), (5, 'Marketing');

INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT ID, Name FROM #TempDepartments;

DROP TABLE #TempDepartments;

-- 12. Insert back sample Employees
INSERT INTO Employees (EmpID, Name, Salary, Department)
VALUES
(1, 'Michael', 7200, NULL),
(2, 'Sarah', 5300, NULL),
(3, 'Tom', 4500, NULL);

-- Update Department to 'Management' where Salary > 5000
UPDATE Employees SET Department = 'Management' WHERE Salary > 5000;

-- 13. Remove all employees but keep structure
TRUNCATE TABLE Employees;

-- 14. Drop Department column
ALTER TABLE Employees
DROP COLUMN Department;

-- 15. Rename Employees to StaffMembers
EXEC sp_rename 'Employees', 'StaffMembers';

-- 16. Drop Departments table
DROP TABLE Departments;

-- ======================================
-- ADVANCED-LEVEL TASKS
-- ======================================

-- 17. Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    CreatedAt DATETIME
);

-- 18. Add CHECK constraint to ensure Price > 0
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);

-- 19. Add StockQuantity with DEFAULT 50
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

-- 20. Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- 21. Insert 5 records
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, CreatedAt)
VALUES
(1, 'Laptop', 'Electronics', 1000.00, GETDATE()),
(2, 'Mouse', 'Accessories', 25.99, GETDATE()),
(3, 'Chair', 'Furniture', 150.00, GETDATE()),
(4, 'Notebook', 'Stationery', 3.99, GETDATE()),
(5, 'Phone', 'Electronics', 899.99, GETDATE());

-- 22. Create backup table using SELECT INTO
SELECT * INTO Products_Backup FROM Products;

-- 23. Rename Products to Inventory
EXEC sp_rename 'Products', 'Inventory';

-- 24. Alter Inventory table: Price to FLOAT
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

-- 25. Add IDENTITY column ProductCode

CREATE TABLE Inventory_New (
    ProductCode INT IDENTITY(1000,5) PRIMARY KEY,
    ProductID INT,
    ProductName VARCHAR(100),
    ProductCategory VARCHAR(50),
    Price FLOAT,
    CreatedAt DATETIME,
    StockQuantity INT
);

-- Copy data
INSERT INTO Inventory_New (ProductID, ProductName, ProductCategory, Price, CreatedAt, StockQuantity)
SELECT ProductID, ProductName, ProductCategory, Price, CreatedAt, StockQuantity
FROM Inventory;

-- Drop old table and rename new
DROP TABLE Inventory;
EXEC sp_rename 'Inventory_New', 'Inventory';

-- DONE ✅
