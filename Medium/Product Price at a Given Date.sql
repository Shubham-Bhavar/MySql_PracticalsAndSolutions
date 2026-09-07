/*
LeetCode 1164 - Product Price at a Given Date

Problem:
Find the price of every product on 2019-08-16.

Rules:
- Initially, every product has price = 10.
- If a product has a price change on or before 2019-08-16,
  use its latest price.
- If there is no price change before/on that date,
  its price remains 10.

Approach:
1. Find the latest change_date for each product
   where change_date <= '2019-08-16'.
2. Get the corresponding new_price.
3. For products having no change before the target date,
   return price = 10.

Time Complexity: O(n)
Space Complexity: O(n)
*/

SELECT
    p.product_id,
    p.new_price AS price
FROM Products p
JOIN
(
    SELECT
        product_id,
        MAX(change_date) AS change_date
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
) latest
ON p.product_id = latest.product_id
AND p.change_date = latest.change_date

UNION

SELECT
    product_id,
    10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16';
