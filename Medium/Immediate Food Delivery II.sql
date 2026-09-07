/*
LeetCode 1174 - Immediate Food Delivery II

Approach:
1. Find the earliest order_date for every customer.
2. Select only those first orders.
3. Count how many first orders are immediate.
4. Calculate:
      immediate orders / total first orders * 100
5. Round the result to 2 decimal places.

Time Complexity: O(n)
Space Complexity: O(n)
*/

WITH first_orders AS
(
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
)

SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN d.order_date = d.customer_pref_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS immediate_percentage
FROM Delivery d
JOIN first_orders f
    ON d.customer_id = f.customer_id
    AND d.order_date = f.first_order_date;
