/*
LeetCode - Find Product Recommendation Pairs

Problem:
Find product pairs that were purchased by at least 3 different
customers.

For each pair:
- product1_id < product2_id
- Count how many customers bought both products
- Show both product categories

Approach:
1. Join ProductPurchases with itself using the same user_id.
2. Use p1.product_id < p2.product_id to create unique pairs.
3. Join ProductInfo to get the categories.
4. GROUP BY product pair.
5. COUNT(DISTINCT user_id) gives customers who bought both.
6. Keep pairs with at least 3 customers.
7. Sort by customer_count DESC, then product IDs ASC.

Time Complexity: O(n²) in the worst case
Space Complexity: O(n)
*/

SELECT
    p1.product_id AS product1_id,
    p2.product_id AS product2_id,

    i1.category AS product1_category,
    i2.category AS product2_category,

    COUNT(DISTINCT p1.user_id) AS customer_count

FROM ProductPurchases p1

JOIN ProductPurchases p2
    ON p1.user_id = p2.user_id
    AND p1.product_id < p2.product_id

JOIN ProductInfo i1
    ON p1.product_id = i1.product_id

JOIN ProductInfo i2
    ON p2.product_id = i2.product_id

GROUP BY
    p1.product_id,
    p2.product_id,
    i1.category,
    i2.category

HAVING COUNT(DISTINCT p1.user_id) >= 3

ORDER BY
    customer_count DESC,
    product1_id ASC,
    product2_id ASC;
