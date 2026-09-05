/*
LeetCode 3657 - Find Loyal Customers

A customer is loyal if ALL conditions are satisfied:

1. At least 3 purchase transactions.
2. Active for at least 30 days.
3. Refund rate is less than 20%.

Refund Rate:
refund transactions / total transactions

Approach:
1. Group transactions by customer_id.
2. Count purchase transactions.
3. Count refund transactions.
4. Count total transactions.
5. Find active days using:
      DATEDIFF(MAX(transaction_date), MIN(transaction_date))
6. Use HAVING to apply all conditions.
7. Order by customer_id.

Time Complexity: O(n)
Space Complexity: O(n)
*/

SELECT
    customer_id
FROM customer_transactions
GROUP BY customer_id
HAVING
    -- At least 3 purchases
    SUM(transaction_type = 'purchase') >= 3

    -- Active for at least 30 days
    AND DATEDIFF(
        MAX(transaction_date),
        MIN(transaction_date)
    ) >= 30

    -- Refund rate < 20%
    AND SUM(transaction_type = 'refund') * 1.0 / COUNT(*) < 0.20

ORDER BY customer_id ASC;
