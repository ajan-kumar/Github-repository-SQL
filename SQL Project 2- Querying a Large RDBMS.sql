--Project 2 – Querying a Large Relational Database

--3) Perform the following with help of the above database
-->	Get all the details from the person table including email ID, phone number, and phone number type
use AdventureWorks2012
Select Person.*, EmailAddress.EmailAddress, PersonPhone.PhoneNumber, PhoneNumberType.Name  
From Person.Person 
LEFT JOIN Person.EmailAddress ON PERSON.BusinessEntityID = EmailAddress.BusinessEntityID 
LEFT JOIN Person.PersonPhone ON PERSON.BusinessEntityID = PersonPhone.BusinessEntityID 
LEFT JOIN Person.PhoneNumberType ON Person.PersonPhone.PhoneNumberTypeID = Person.PhoneNumberType.PhoneNumberTypeID

-->	Get the details of the sales header order made in May 2011
Select * from Sales.SalesOrderHeader WHERE OrderDate Between '2011-05-01 00:00:00' AND '2011-05-31 00:00:00'

-->	Get the details of the sales details order made in the month of May 2011
Select * from Sales.SalesOrderDetail D WHERE EXISTS
(
Select * from Sales.SalesOrderHeader H
WHERE OrderDate Between '2011-05-01 00:00:00' AND '2011-05-31 00:00:00'
AND D.SalesOrderID=H.SalesOrderID
)

-->	Get the total sales made in May 2011
Select SUM(TotalDue) from Sales.SalesOrderHeader WHERE OrderDate Between '2011-05-01 00:00:00' AND '2011-05-31 00:00:00'

-->	Get the total sales made in the year 2011 by month order by increasing sales
SELECT DATENAME(MONTH,[OrderDate]) as Month, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY MONTH([OrderDate]), DATENAME(MONTH,[OrderDate])
ORDER BY SUM(TotalDue)

-->	Get the total sales made to the customer with FirstName='Gustavo' and LastName ='Achong'
Select sum(TotalDue) as TotalSalesfrom sales.SalesOrderHeader s WHERE EXISTS (Select * from Person.Person p where FirstName='Gustavo' and LastName ='Achong' and s.rowguid=p.rowguid)

Select sum(TotalDue) from sales.SalesOrderHeader where rowguid = 'D4C132D3-FCB5-4231-9DD5-888A54BEC693' -- verifying above statement by using rowguid directly