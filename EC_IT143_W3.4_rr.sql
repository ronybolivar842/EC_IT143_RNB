
/*
    EC_IT143_W3.4_rr.sql
    Author: Roni Rolando
    Date: 2025-07-19
    Description: AdventureWorks SQL answers
*/

-- =====================================
-- Q1. Business - Marginal Complexity
-- What is the job title of employee ID 3?
-- Original Author: Frederick Boafo Ampofo
-- Estimated Runtime: < 2 sec
-- =====================================
SELECT JobTitle 
FROM HumanResources.Employee 
WHERE BusinessEntityID = 3;


-- =====================================
-- Q2. Business - Marginal Complexity
-- What is the list price of the product named "Mountain-100 Silver, 44"?
-- Original Author: Kendall Navarro
-- Estimated Runtime: < 2 sec
-- =====================================
SELECT ListPrice 
FROM Production.Product 
WHERE Name = 'Mountain-100 Silver, 44';


-- =====================================
-- Q3. Business - Moderate Complexity
-- List the names of salespeople and their assigned territories.
-- Original Author: Frederick Boafo Ampofo
-- Estimated Runtime: 2–5 sec
-- =====================================
SELECT p.FirstName, p.LastName, st.Name AS Territory 
FROM Sales.SalesPerson sp
JOIN Sales.SalesTerritory st ON sp.TerritoryID = st.TerritoryID
JOIN HumanResources.Employee e ON sp.BusinessEntityID = e.BusinessEntityID
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID;


-- =====================================
-- Q4. Business - Moderate Complexity
-- What is the total sales amount for each product sold in the year 2022?
-- Original Author: Kendall Navarro
-- Estimated Runtime: 3–5 sec
-- =====================================
SELECT p.Name, SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE YEAR(soh.OrderDate) = 2022
GROUP BY p.Name;


-- =====================================
-- Q5. Business - Increased Complexity
-- What products did Brian Welcker buy last month and at what unit prices?
-- Original Author: Frederick Boafo Ampofo
-- Estimated Runtime: 5–8 sec
-- =====================================
SELECT p.Name, sod.UnitPrice
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person per ON c.PersonID = per.BusinessEntityID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE per.FirstName = 'Brian' AND per.LastName = 'Welcker'
AND MONTH(soh.OrderDate) = MONTH(GETDATE()) - 1
AND YEAR(soh.OrderDate) = YEAR(GETDATE());


-- =====================================
-- Q6. Business - Increased Complexity
-- Average standard cost vs. average list price for products in 'Bikes'
-- Original Author: Kendall Navarro
-- Estimated Runtime: 5–10 sec
-- =====================================
SELECT AVG(StandardCost) AS AvgCost, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE ProductSubcategoryID IN (
    SELECT ProductSubcategoryID 
    FROM Production.ProductSubcategory 
    WHERE Name LIKE '%Bike%'
);


-- =====================================
-- Q7. Metadata
-- What data types are used in Person.Person table columns?
-- Original Author: Frederick Boafo Ampofo
-- Estimated Runtime: < 2 sec
-- =====================================
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Person' AND TABLE_SCHEMA = 'Person';


-- =====================================
-- Q8. Metadata
-- Which tables in the database have a primary key, and what are the names of those keys?
-- Original Author: Kendall Navarro
-- Estimated Runtime: 2–4 sec
-- =====================================
SELECT t.name AS TableName, kc.name AS PrimaryKeyName
FROM sys.key_constraints kc
JOIN sys.tables t ON kc.parent_object_id = t.object_id
WHERE kc.type = 'PK';
