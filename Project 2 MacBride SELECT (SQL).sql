-- Project 2
-- Erica MacBride
-- One-Table-SELECTS
-- August 31st, 2020



-- 1. Select the ProductName and ProductID. Order by ProductName.

SELECT    ProductName,
          ProductID
FROM      Products
ORDER BY  ProductName

-- 2. Select the ProductID and ProductName. Order by ProductName. (note that it is natural to order first by the left-most column)

SELECT    ProductID,
          ProductName
FROM      Products
ORDER BY  ProductName

-- 3. Select the ProductID, productname, and total value of inventory. The total value is found by multiplying the unitsInstock and unitprice.

SELECT    ProductName,
          ProductID,
          UnitsInStock * UnitPrice AS [Total Value of Inventory]
FROM      Products
ORDER BY  ProductName

--    Name the new column [inventory value]. Order by inventory value descending.

SELECT    ProductName,
          ProductID,
          UnitsInStock * UnitPrice AS [Iventory Value]
FROM      Products
ORDER BY  [Iventory Value] DESC

-- 4. Select the CategoryID, ProductID, productname and inventory value. Order first by CategoryID ascending, then by inventory value descending.

SELECT    CategoryID,
          ProductID,
          ProductName,
          UnitsInStock * UnitPrice AS [Inventory Value]
FROM      Products
ORDER BY  CategoryID DESC,
          [Inventory Value] DESC

-- 5. Select the ProductID, ProductName, and unitsInstock plus unitsOnOrder. Name this column [units available].

SELECT    ProductID,
          ProductName,
          UnitsInStock + UnitsOnOrder AS [Units Available]
FROM      Products
ORDER BY  ProductName ASC

-- 6. (Note, we're switching to the customer table....) Show the CustomerID and ContactName of all customers. Order by CustomerID. Rename the columns [ID] and [name].

SELECT    CustomerID AS [ID],
          ContactName AS [Name]
FROM      Customers
ORDER BY  ContactName ASC

-- 7. Show the CustomerID, ContactName, location of the space character in the contactname, and the length of the contactName. Use the CHARINDEX() and LEN() functions.

SELECT    CustomerID AS [ID],
          ContactName AS [Name],
          CHARINDEX(' ', ContactName) AS [Location of Space Character],
          LEN(ContactName) AS [Length of Name]
FROM      Customers
ORDER BY  ContactName ASC

-- 8. Show the CustomerID, ContactName, and the last name of the contact. Use code from 7 above, and the RIGHT() function.

SELECT    CustomerID AS [ID],
          ContactName AS [Name],
          RIGHT(ContactName,
          LEN(ContactName) 
          - CHARINDEX(' ', ContactName)) AS [Last Name]
FROM      Customers
ORDER BY  ContactName ASC

-- 9. Show the CustomerID, CompanyName, and the City and Country concatenated together with a comma, like this: Berlin, Germany.
--    Use the plus sign. Order first by the Country, then by the City, then by the customerID.

SELECT    CustomerID,
          CompanyName,
          City + ',' + ' ' + Country AS [Location]
FROM      Customers
ORDER BY  Country,
          City,
          CustomerID


-- 10.Let's check to see if the CompanyNames are clean. Show the CustomerID and CompanyName of each customer. Also show the length in characters of the CompanyName.
--    Also show the trimmed CompanyName (use the TRIM() function.) Also show the length of the trimmed CompanyName. If those two lengths are different, 
--    then CompanyName has some trailing spaces.

SELECT    CustomerID,
          CompanyName,
          LEN(CompanyName) AS [Length of Company Name],
          TRIM(CompanyName) AS [Trim Company Name],
          LEN( LTRIM(CompanyName)) AS [Length of Trim Company Name]
FROM      Customers
ORDER BY  CompanyName ASC


-- 11. Show the CustomerID and the customerID converted to lower case (use LOWER()).

SELECT    CustomerID,
          LOWER(CustomerID) AS [Lower Case ID]
FROM      Customers
ORDER BY  CustomerID ASC
     

-- 12. Show the CustomerID, and the contactname. We'd also like to see the customer name like this: first initial, one space, then the lastname, 
--     all in one column called [short name].

SELECT    CustomerID AS [ID],
          ContactName AS [Name],
          LEFT(ContactName, 1) + ' ' + RIGHT(ContactName, LEN(ContactName) - CHARINDEX(' ', ContactName)) AS [Short Name]
FROM      Customers
ORDER BY  ContactName ASC


