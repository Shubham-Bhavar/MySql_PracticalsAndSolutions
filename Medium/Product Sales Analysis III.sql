/*
LeetCode 1070 - Product Sales Analysis III

Problem:
Find all sales that happened in the first year
each product was sold.

For each product_id:
- Find the minimum year.
- Return all sales from that year.

Output:
product_id, first_year, quantity, price

Example:
Sales:
100 → 2008, 2009
200 → 2011

Output:
100 → 2008
200 → 2011

Approach:
1. Find the minimum year for each product.
2. Join it with Sales.
3. Keep only sales from that first year.

Time Complexity: O(n)
Space Complexity: O(n)
*/

SELECT
    s.product_id,
    s.year AS first_year,
    s.quantity,
    s.price
FROM Sales s
JOIN
(
    SELECT
        product_id,
        MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
) f
ON s.product_id = f.product_id
AND s.year = f.first_year;
