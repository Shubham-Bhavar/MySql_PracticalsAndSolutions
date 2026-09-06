/*
===========================================================
LeetCode 1193 - Monthly Transactions I
===========================================================

Problem:
For each month and country, find:

1. Total number of transactions
2. Number of approved transactions
3. Total amount of all transactions
4. Total amount of approved transactions

-----------------------------------------------------------
Approach:
-----------------------------------------------------------

1. Extract month from trans_date using DATE_FORMAT().
2. Group records by month and country.
3. COUNT(*) gives total transactions.
4. SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END)
   gives approved transactions.
5. SUM(amount) gives total transaction amount.
6. SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)
   gives approved transaction amount.

-----------------------------------------------------------
*/

SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,

    COUNT(*) AS trans_count,

    SUM(
        CASE
            WHEN state = 'approved' THEN 1
            ELSE 0
        END
    ) AS approved_count,

    SUM(amount) AS trans_total_amount,

    SUM(
        CASE
            WHEN state = 'approved' THEN amount
            ELSE 0
        END
    ) AS approved_total_amount

FROM Transactions

GROUP BY
    DATE_FORMAT(trans_date, '%Y-%m'),
    country;
