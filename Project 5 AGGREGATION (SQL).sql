-- Erica MacBride
-- Project 5 MIS 504
-- AGGREGATION
-- September 21st, 2020

-- 1. Show the Supplier companyname and the count of how many products we get from that supplier. 
--    Make sure to count the primary key of the products table. Order by companyname.

SELECT    Suppliers.CompanyName,
          COUNT(Products.ProductID) AS [Total Products Supplied]
FROM      Suppliers
   JOIN   Products ON Suppliers.SupplierID = Products.SupplierID
GROUP BY  Suppliers.CompanyName
ORDER BY  Suppliers.CompanyName

-- 2. Do number 1 again, but only include products that are not discontinued.

SELECT    Suppliers.CompanyName,
          COUNT(Products.ProductID) AS [Total Products Supplied]
FROM      Suppliers
   JOIN   Products ON Suppliers.SupplierID = Products.SupplierID
WHERE     Products.Discontinued = 0
GROUP BY  Suppliers.CompanyName
ORDER BY  Suppliers.CompanyName

-- 3. Show the Supplier companyname and the average unitprice of products from that supplier.
--    Only include products that are not discontinued.

SELECT    Suppliers.CompanyName,
          AVG(Products.ProductID) AS [Average Product Price]
FROM      Suppliers
   JOIN   Products ON Suppliers.SupplierID = Products.SupplierID
WHERE     Products.Discontinued = 0
GROUP BY  Suppliers.CompanyName
ORDER BY  Suppliers.CompanyName

-- 4. Show the Supplier companyname and the total inventory value of all products from that supplier.
--    This will involve the SUM() function with some calculations inside the functions.

SELECT    Suppliers.CompanyName,
          SUM(Products.UnitPrice * Products.UnitsInStock) AS [Inventory Value]
FROM      Suppliers
   JOIN   Products ON Products.SupplierID = Suppliers.SupplierID
GROUP BY  Suppliers.CompanyName
ORDER BY  Suppliers.CompanyName

-- 5. Show the Category name and a count of how many products are in each category.

SELECT    Categories.CategoryName,
          COUNT(Products.ProductID) AS [Count of Products]
FROM      Categories
   JOIN   Products ON Products.CategoryID = Categories.CategoryID
GROUP BY  Categories.CategoryName
ORDER BY  Categories.CategoryName

-- 6. Show the Category name and a count of how many products in each category that are packaged
--    in jars (have the word 'jars' in the QuantityPerUnit.)

SELECT    Categories.CategoryName,
          COUNT(Products.ProductID) AS [Count of Products]
FROM      Categories
   JOIN   Products ON Products.CategoryID = Categories.CategoryID
WHERE     Products.QuantityPerUnit LIKE '%jars%'
GROUP BY  Categories.CategoryName
ORDER BY  Categories.CategoryName

-- 7. Show the Category name, and the minimum, average, and maximum price of products in each
--    category.

SELECT    Categories.CategoryName,
          MIN(Products.UnitPrice) AS [Minimum Product Price],
          AVG(Products.UnitPrice) AS [Average Product Price],
          MAX(Products.UnitPrice) AS [Maximum Product Price]
FROM      Categories
   JOIN   Products ON Categories.CategoryID = Products.CategoryID
GROUP BY  Categories.CategoryName
ORDER BY  Categories.CategoryName

-- 8. Show each order ID, its orderdate, the customer ID, and a count of how many items are on 
--    each order.

SELECT    Orders.OrderID,
          Orders.OrderDate,
          Orders.CustomerID,
          COUNT([Order Details].Quantity) AS [Total Units on Order]
FROM      Orders
   JOIN   [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY  Orders.OrderID,
          Orders.OrderDate,
          Orders.CustomerID
ORDER BY  Orders.OrderID,
          Orders.OrderDate,
          Orders.CustomerID


-- 9. Show each productID, its productname, and a count of how many orders it has appeared on.

SELECT    Products.ProductID,
          Products.ProductName,
          COUNT([Order Details].ProductID) AS [Appeared on # of Orders]
FROM      Products
   JOIN   [Order Details] ON [Order Details].ProductID = Products.ProductID
GROUP BY  Products.ProductID,
          Products.ProductName
ORDER BY  Products.ProductID,
          Products.ProductName

-- 10. Do #9 again, but limit to only orders that were place in January of 1997.

SELECT    Products.ProductID,
          Products.ProductName,
          COUNT([Order Details].ProductID) AS [Appeared on # of Orders]
FROM      Products
   JOIN   [Order Details] ON [Order Details].ProductID = Products.ProductID
   JOIN   Orders ON Orders.OrderID = [Order Details].OrderID
WHERE     MONTH(Orders.OrderDate) = 01
    AND   YEAR(Orders.OrderDate) = 1997
GROUP BY  Products.ProductID,
          Products.ProductName
ORDER BY  Products.ProductID,
          Products.ProductName

-- 11. Show each OrderID, its orderdate, the customerID, and the total amount due, not including
--     freight. Sum the amounts due from each product on the order. The amount due is the quantity
--     times the unitprice, times one minus the discount. Order by amount due, descending, so the 
--     biggest dollar amount due is at the top.

SELECT    Orders.OrderID,
          Orders.OrderDate,
          Orders.CustomerID,
          SUM(([Order Details].Quantity * [Order Details].UnitPrice) * (1 - [Order Details].Discount)) AS [Amount Due]
FROM      Orders
   JOIN   [Order Details] ON [Order Details].OrderID = Orders.OrderID
GROUP BY  Orders.OrderID,
          Orders.OrderDate,
          Orders.CustomerID
ORDER BY  [Amount Due] DESC

-- 12. We want to know, for the year 1997, the total revenues by category. Show the CategoryID, 
--     categoryname, and the total revenue from products in that category. This is very much like #11. 
--     Don't include freight.

SELECT    Categories.CategoryID,
          Categories.CategoryName,
          SUM(([Order Details].Quantity * [Order Details].UnitPrice) * (1 - [Order Details].Discount)) AS [Amount Due]
FROM      Categories
   JOIN   Products ON Products.CategoryID = Categories.CategoryID
   JOIN   [Order Details] ON [Order Details].ProductID = Products.ProductID
   JOIN   Orders ON Orders.OrderID = [Order Details].OrderID
WHERE     YEAR(Orders.OrderDate) = 1997
GROUP BY  Categories.CategoryID,
          Categories.CategoryName
ORDER BY  [Amount Due] DESC


-- 13. We want to know, for the year 1997, total revenues by month. Show the month number, 
--     and the total revenue for that month. Don't include freight.

SELECT    MONTH(Orders.OrderDate) AS [Month Number],
          SUM(([Order Details].Quantity * [Order Details].UnitPrice) * (1 - [Order Details].Discount)) AS [Amount Due]
FROM      Orders
   JOIN   [Order Details] ON [Order Details].OrderID = Orders.OrderID
WHERE     YEAR(Orders.OrderDate) = 1997
GROUP BY  MONTH(Orders.OrderDate)
ORDER BY  [Month Number]

-- 14. We want to know, for the year 1997, total revenues by employee. Show the EmployeeID, lastname,
--     title, then their total revenues. Don't include freight. 

SELECT    Employees.EmployeeID,
          Employees.LastName,
          Employees.Title,
          SUM(([Order Details].Quantity * [Order Details].UnitPrice) * (1 - [Order Details].Discount)) AS [Total Revenue]
FROM      Employees
   JOIN   Orders ON Orders.EmployeeID = Employees.EmployeeID
   JOIN   [Order Details] ON [Order Details].OrderID = Orders.OrderID
WHERE     YEAR(ORDERS.OrderDate) = 1997
GROUP BY  Employees.EmployeeID,
          Employees.LastName,
          Employees.Title
ORDER BY  Employees.EmployeeID,
          Employees.LastName,
          Employees.Title 


-- 15. We want to know, for the year 1997, a breakdown of revenues by month and category. 
--     Show the month number, the categoryname, and the total revenue for that month in that category.
--     Order the records by month then category.

SELECT    Categories.CategoryName,
          MONTH(Orders.OrderDate) AS [Month Number],
          SUM(([Order Details].Quantity * [Order Details].UnitPrice) * (1 - [Order Details].Discount)) AS [Total Revenue by Category/Month]
FROM      Categories
   JOIN   Products ON Products.CategoryID = Categories.CategoryID
   JOIN   [Order Details] ON [Order Details].ProductID = Products.ProductID
   JOIN   Orders ON Orders.OrderID = [Order Details].OrderID
WHERE     YEAR(Orders.OrderDate) = 1997
GROUP BY  Categories.CategoryName,
          MONTH(Orders.OrderDate)
ORDER BY  MONTH(Orders.OrderDate),
          Categories.CategoryName