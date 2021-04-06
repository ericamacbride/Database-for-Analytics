-- Project 3
-- Erica MacBride
-- MIS 504 Fall 2020
-- The WHERE Clause



-- 1. Select the ProductID, ProductName, and unitsInStock of all products that have fewer than 5 unitsInStock. 
-- Order products by productID.

SELECT    ProductID AS [Product ID],
          ProductName AS [Product Name],
          UnitsInStock AS [Units in Stock]
FROM      Products
WHERE     UnitsInStock < 5
ORDER BY  ProductID ASC

-- 2. Select the ProductID, ProductName, and unitsInStock of all products that have unitprice greater than $8.00. Order by ProductID.

SELECT    ProductID AS [Product ID],
          ProductName AS [Product Name],
          UnitsInStock AS [Units in Stock]
FROM      Products
WHERE     UnitPrice > 8.00
ORDER BY  ProductID ASC

-- 3. Select the Productname, unitprice, and total value in inventory of all products. Value in inventory is calculated by multiplying
-- unitsInstock by unitprice. Order by productname.

SELECT    ProductName AS [Product Name],
          UnitPrice   AS [Unit Price],
          UnitsInStock * UnitPrice AS [Total Value in Inventory]
FROM      Products
ORDER BY  ProductName ASC

-- 4. Select the Productname, categoryID and unitprice of all products that are in category 2 and cost less than $4.

SELECT    ProductName AS [Product Name],
          CategoryID  AS [Category ID],
          UnitPrice   AS [Unit Price]
FROM      Products
WHERE     CategoryID IN (2)
    AND   UnitPrice < 4.00

-- 5. Select the ProductName, categoryID, and unitprice of all products that are in category 7 and cost more than $8.

SELECT   ProductName AS [Product Name],
         CategoryID  AS [Category ID],
         UnitPrice   AS [Unit Price]
FROM     Products
WHERE    CategoryID IN (7)
    AND  UnitPrice > 8.00
ORDER BY UnitPrice ASC

-- 6. Combine all the records from questions 4 and 5 into a single SELECT statement. Use parentheses, ANDs and ORs as necessary. 

SELECT    ProductName AS [Product Name],
          CategoryID  AS [Category ID],
          UnitPrice   AS [Unit Price]
FROM      Products
WHERE     CategoryID IN (2, 7)
    AND
          ( 
          UnitPrice < 4.00 
    OR    UnitPrice > 8.00
          )
          

-- 7. Show all productnames and prices of products that are packaged in bottles. Do this by using the LIKE statement on the 
-- QuantityPerUnit field.

SELECT    ProductName AS [Product Name],
          UnitPrice   AS [Unit Price]
FROM      Products
WHERE     ProductName LIKE '%bottle%'
ORDER BY  ProductName ASC

-- 8. Show all productnames that end in the word 'Lager'.

SELECT    ProductName AS [Product Name]
FROM      Products
WHERE     ProductName LIKE '%Lager'
ORDER BY  ProductName ASC

-- 9. Show all products that are in one of these categories: 2, 4, 5, or 7. Use the IN clause. Show the name and unitprice of 
-- each product.

SELECT    ProductName AS [Product Name],
          UnitPrice   AS [Unit Price]
FROM      Products
WHERE     CategoryID IN (2,4,5,7)
ORDER BY  CategoryID ASC

-- 10. Select ProductID, ProductName, and SupplierID of all products that have the word "Ale" or "Lager" in the productname. 
-- Order by ProductID.

SELECT    ProductID   AS [Product ID],
          ProductName AS [Product Name],
          SupplierID  AS [Supplier ID]
FROM      Products
WHERE     ProductName LIKE '%Ale'
    OR    ProductName LIKE '%Lager%'
ORDER BY  ProductID   ASC

-- 11. Select the productname, unitprice, and unitsInStock of all products whose units in stock are less than half of the reorder level.
-- Order by units in stock ascending.

SELECT    ProductName AS [Product Name],
          UnitPrice   AS [Unit Price],
          UnitsInStock AS [Units in Stock]
FROM      Products
WHERE     UnitsInStock < ReorderLevel/2.00
ORDER BY  UnitsInStock ASC


-- 12. Select the productname of all products whose value in inventory is less than $200. Order by inventory value descending.

SELECT    ProductName AS [Product Name],
          UnitsInStock * UnitPrice AS [Inventory Value]
FROM      Products
WHERE     UnitsInStock*UnitPrice < 200
ORDER BY  [Inventory Value] 

-- 13. Select the Productname of any products whose value in inventory is more than $500 and is discontinued. Also show inventory value. 
-- Order by inventory value descending.

SELECT    ProductName AS [Product Name],
          UnitsInStock * UnitPrice AS [Inventory Value]
FROM      Products
WHERE     UnitsinStock * UnitPrice > 500
    AND   Discontinued = 1
ORDER BY  [Inventory Value]

-- 14. Show all products that we need to reorder. These are the products that are not discontinued, and the unitsinstock plus
-- unitsOnOrder is less than or equal to the reorderLevel.

SELECT    ProductName AS [Product Name],
          UnitsInStock + UnitsOnOrder AS [Total Inventory]
FROM      Products
WHERE     Discontinued = 0     
    AND   UnitsInStock + UnitsOnOrder <= ReorderLevel
ORDER BY  ProductName ASC

-- 15. Show the categoryID, productID, productname, and unitprice of all products. Order by categoryID, then unitprice descending, 
-- then productID.

SELECT    CategoryID AS [Category ID],
          ProductID  AS [Product ID],
          ProductName AS [Product Name],
          UnitPrice  AS [Unit Price]
FROM      Products
ORDER BY  CategoryID ASC,
          UnitPrice DESC,
          ProductID ASC