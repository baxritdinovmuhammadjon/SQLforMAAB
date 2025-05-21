-- EASY

-- 1. List all products and their prices from the Products table.
SELECT Product_Name, Price FROM Products;

-- 2. Display the names of all customers from the Customers table.
SELECT Customer_Name FROM Customers;

-- 3. Show the total number of products in the Products table.
SELECT COUNT(*) AS Total_Products FROM Products;

-- 4. Find the highest price among all products.
SELECT MAX(Price) AS Highest_Price FROM Products;

-- 5. List the names of customers who live in the city of 'Tashkent'.
SELECT Customer_Name FROM Customers WHERE City = 'Tashkent';

-- 6. Show the average discount percentage for products in the Products_Discounted table.
SELECT AVG(Discount_Percentage) AS Avg_Discount FROM Products_Discounted;

-- 7. Display all sales transactions where the quantity sold is greater than 10.
SELECT * FROM Sales WHERE Quantity > 10;

-- 8. Count the number of orders in the Orders table.
SELECT COUNT(*) AS Total_Orders FROM Orders;

-- 9. Find the minimum price in the Products table.
SELECT MIN(Price) AS Lowest_Price FROM Products;

-- 10. List all customers along with their city.
SELECT Customer_Name, City FROM Customers;


-- MEDIUM

-- 2. Display the product name, discount percentage, and discounted price for all products in the Products_Discounted table.
SELECT 
    Product_Name,
    Discount_Percentage,
    Price * (1 - Discount_Percentage / 100.0) AS Discounted_Price
FROM 
    Products_Discounted;

-- 3. Find the average quantity sold for each product from the Sales table, and only include products with an average quantity greater than 5.
SELECT 
    Product_ID,
    AVG(Quantity) AS Avg_Quantity
FROM 
    Sales
GROUP BY 
    Product_ID
HAVING 
    AVG(Quantity) > 5;

-- 4. Display the customer name and total amount spent for each customer. Use the Invoices table (assume Amount is per invoice).
SELECT 
    Customer_ID,
    SUM(Amount) AS Total_Spent
FROM 
    Invoices
GROUP BY 
    Customer_ID;

-- 5. Find the number of orders placed by each customer and only include customers who placed more than 3 orders.
SELECT 
    Customer_ID,
    COUNT(*) AS Order_Count
FROM 
    Orders
GROUP BY 
    Customer_ID
HAVING 
    COUNT(*) > 3;


-- HARD

-- 2. Display the names of products that are sold at a discount greater than 20% and have a total sales quantity of more than 100.
SELECT 
    pd.Product_Name
FROM 
    Products_Discounted pd
JOIN 
    Sales s ON pd.Product_ID = s.Product_ID
WHERE 
    pd.Discount_Percentage > 20
GROUP BY 
    pd.Product_Name
HAVING 
    SUM(s.Quantity) > 100;

-- 3. Find the customers who live in cities with a population over 1 million and have placed more than 5 orders.
SELECT 
    c.Customer_Name
FROM 
    Customers c
JOIN 
    City_Population cp ON c.City = cp.City
JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
WHERE 
    cp.Population > 1000000
GROUP BY 
    c.Customer_Name
HAVING 
    COUNT(o.Order_ID) > 5;

-- 4. Display the top 5 customers who spent the most, including their name and total spent.
SELECT TOP 5
    c.Customer_Name,
    SUM(i.Amount) AS Total_Spent
FROM 
    Customers c
JOIN 
    Invoices i ON c.Customer_ID = i.Customer_ID
GROUP BY 
    c.Customer_Name
ORDER BY 
    Total_Spent DESC;

-- 5. Find the city with the highest number of customers.
SELECT TOP 1
    City,
    COUNT(*) AS Customer_Count
FROM 
    Customers
GROUP BY 
    City
ORDER BY 
    Customer_Count DESC;
