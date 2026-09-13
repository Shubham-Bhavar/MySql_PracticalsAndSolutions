/*
========================================================
LeetCode 607 - Sales Person
========================================================

Problem:
--------
Find the names of all salespersons who did NOT have
any orders related to the company named "RED".

--------------------------------------------------------
Approach:
--------------------------------------------------------

1. Join SalesPerson with Orders.
2. Join Orders with Company.
3. Find salespersons who have orders for "RED".
4. Exclude those salespersons from the SalesPerson table.

--------------------------------------------------------
Query:
--------------------------------------------------------
*/

SELECT name
FROM SalesPerson
WHERE sales_id NOT IN
(
    SELECT o.sales_id
    FROM Orders o
    JOIN Company c
        ON o.com_id = c.com_id
    WHERE c.name = 'RED'
);
