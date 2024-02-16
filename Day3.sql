/* Question1 */
SELECT DISTINCT City
FROM (
    SELECT City, 'Employee' AS Role
    FROM Employees
    UNION ALL
    SELECT City, 'Customer' AS Role
    FROM Customers
) AS Combined
GROUP BY City
HAVING COUNT(DISTINCT Role) = 2;

/* Question2a */
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN (
    SELECT DISTINCT City
    FROM Employees
);

/* Question2b */
SELECT DISTINCT C.City
FROM Customers C
LEFT JOIN Employees E ON C.City = E.City
WHERE E.City IS NULL;

/* Question3 */
SELECT p.ProductName, SUM(od.Quantity) as QuantityCounts
FROM Products p
JOIN [Order Details] od ON od.ProductID = p.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
GROUP BY p.ProductName;

/* Question4 */
SELECT c.City, COUNT(DISTINCT od.ProductID) AS TotalProductsOrdered
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City;

/* Question5a */
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2
UNION
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2;

/* Question5b */
SELECT DISTINCT City
FROM Customers
WHERE City IN (
    SELECT City
    FROM Customers
    GROUP BY City
    HAVING COUNT(CustomerID) >= 2
);

/* Question6 */
SELECT c.City
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2;

/* Question7 */
SELECT DISTINCT c.CustomerID
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.ShipCity <> c.City;

/* Question8 */
SELECT TOP 5 p.ProductName,
AVG(od.UnitPrice) AS AveragePrice,
(SELECT TOP 1 c.City
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE od.ProductID = p.ProductID
GROUP BY c.City
ORDER BY SUM(od.Quantity) DESC) AS MostOrderedCity
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY SUM(od.Quantity) DESC;

/* Question9a */
SELECT City
FROM Employees
WHERE City not in (
SELECT ShipCity
FROM Orders
)

/* Question9b */
SELECT DISTINCT e.City
FROM Employees e
LEFT JOIN Orders o ON e.City = o.ShipCity
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

/* Question10 */
SELECT TOP 1
    EmployeeCityOrders.City AS CityWithMostOrders,
    TotalQuantityOrdered.City AS CityWithMostTotalQuantity
FROM
    (SELECT TOP 1
        e.City,
        COUNT(o.OrderID) AS TotalOrders
    FROM
        Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    GROUP BY
        e.City
    ORDER BY
        COUNT(o.OrderID) DESC) AS EmployeeCityOrders
FULL JOIN
    (SELECT TOP 1
        c.City,
        SUM(od.Quantity) AS TotalQuantity
    FROM
        Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY
        c.City
    ORDER BY
        SUM(od.Quantity) DESC) AS TotalQuantityOrdered
ON 1=1;

/* Question11:
One way to remove duplicate records from a table in SQL is to use the DISTINCT keyword in a SELECT statement
*/