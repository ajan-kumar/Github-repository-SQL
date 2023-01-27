/*
SQL Project 1- Subqueries

A Subquery or a nested query, is a SELECT statement that returns a single value or multiple values, and is nested inside a SELECT, INSERT, UPDATE or DELETE statement or inside another subquery.
A Subquery can be used anywhere an expression is allowed. In a batch the subquery gets executed first, returns a value or a group of value. This value is then used to execute the main query.
Subqueries are always enclosed within ().

Types of subqueries:
	1. WHERE <expression> [NOT] IN (subquery)
	2. WHERE <expression><comparison operator>[ANY|ALL] (subquery)
	3. WHERE [NOT] EXISTS (subquery)

Subqueries used with IN or NOT IN
The result of a subquery introduced with IN or with NOT IN is a list of zero or more values.
The subquery executes first and the outer query searches for the value of the expression in or not in the result set of the subquery.

Example is
USE Pubs
Select pub_name 
From publishers 
WHERE pub_id IN
(
SELECT pub_id 
FROM titles 
WHERE type = 'business'
)

Subqueries used with ANY or ALL
Comparison operators can be used with the results of a subquery by using the ANY or ALL keywords.
The ALL and ANY keywords each compare a scalar value with every record of the result set of the subquery one by one.
The ALL Keyword applies to every value and the ANY Keyword applies to at least one value.

Example is
USE Pubs
Select royaltyper
From titleauthor
WHERE royaltyper > ALL
(
SELECT royalty
FROM titles
WHERE type = 'business'
)

Subqueries used with EXISTS and NOT EXISTS
The subquery executes first and the outer query searches for the records that contain or do not contain the result set of the subquery.
EXISTS or NOT EXISTS is a search keyword that the outer query uses to search in the results of the subquery.

Example is
USE Pubs
Select pub_name
From publishers p
WHERE EXISTS
(
SELECT pub_id
FROM titles t
WHERE type = 'business'
and p.pub_id=t.pub_id
)

Firstly, I created a database Pubs and relevant tables using online sources (Github) and will be attempting the below exercise using pubs database

SQL Project 1- Subqueries Exercise
1. Use a subquery to identify the employee ID of those employees who live in Seattle. Then produce a report of those orders that were processed by these employees in Seattle.
*/

-- query to find emp_id working in Seattle branch
Use pubs
Select emp_id from employee WHERE employee.pub_id IN 
(
SELECT pub_id from titles where titles.title_id IN 
(
SELECT title_id from sales WHERE sales.stor_id IN
(
SELECT stor_id from stores
)))

-- query to find orders processed by employees in Seattle branch
SELECT * FROM sales WHERE sales.stor_id IN (Select stor_id from stores where city = 'Seattle')

--2. Use a subquery to identify the royalty in roysched table in Pubs database. Then produce a report of those titles that have royalty less than any of the royalty in roysched table.

-- query to find royalty in roysched table
Use pubs
SELECT royalty FROM roysched

-- query to find title which has royalty less than any royalty in roysched table
SELECT title from titles WHERE royalty < ANY (select royalty FROM roysched)