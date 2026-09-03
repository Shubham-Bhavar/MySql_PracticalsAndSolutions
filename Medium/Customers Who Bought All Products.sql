/*
LeetCode 1045 - Customers Who Bought All Products

Approach:
1. Group Customer table by customer_id.
2. Count distinct products bought by each customer.
3. Count total products in Product table.
4. If both counts are equal, the customer bought all products.

DISTINCT is important because Customer table can contain duplicate rows.
*/

SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(*)
    FROM Product
);
