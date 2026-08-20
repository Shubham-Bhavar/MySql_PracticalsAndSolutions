/*
LeetCode: Customer Who Visited but Did Not Make Any Transactions

Tables:
Visits(visit_id, customer_id)
Transactions(transaction_id, visit_id, amount)

Find customers who visited the mall but did not make any transaction,
and count how many such visits each customer made.
*/

SELECT 
    v.customer_id,
    COUNT(*) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t
    ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;
